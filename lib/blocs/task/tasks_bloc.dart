import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/task_model.dart';
part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(TasksState.initial()) {
    on<AddItemEvent>(_onAddItem);
    on<EditItemEvent>(_onEditItem);
    on<EditItemStatusEvent>(_onEditItemStatus);
    on<DeleteItemEvent>(_onDeleteItem);
  }

  void _onAddItem(AddItemEvent event, Emitter<TasksState> emit) {
    final state = this.state;

    emit(TasksState(allItems: List.from(state.allItems)..add(event.item)));
  }

  void _onEditItem(EditItemEvent event, Emitter<TasksState> emit) {
    final state = this.state;

    final task = state.allItems.elementAt(event.index);
    //state.allItems.add(task.copyWith(description: task.description));

    task.description = event.description;

    emit(TasksState(allItems: state.allItems));
  }

  void _onEditItemStatus(EditItemStatusEvent event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = state.allItems.elementAt(event.index);

    task.taskStatus = event.status;

    emit(TasksState(allItems: state.allItems));
  }

  void _onDeleteItem(DeleteItemEvent event, Emitter<TasksState> emit) async {
    final state = this.state;
    final task = state.allItems.elementAt(event.index);
    emit(TasksState(allItems: List.from(state.allItems)..remove(task)));
  }
}
