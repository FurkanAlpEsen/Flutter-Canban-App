// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  final List<Task> allItems;

  const TasksState({
    required this.allItems,
  });

  factory TasksState.initial() {
    return TasksState(allItems: [
      Task(title: 'Example', description: 'Do homework!', taskStatus: Status.todo, isFavorite: false)
    ]);
  }

  @override
  List<Object> get props => [allItems];

  @override
  String toString() => 'TasksState(allItems: $allItems)';
}
