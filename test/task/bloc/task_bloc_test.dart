import 'package:Canban/blocs/task/tasks_bloc.dart';
import 'package:Canban/models/task_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // group('Task Bloc Testing', () {
  //   late TasksBloc tasksBloc;

  //   var expectedResult = [
  //     Task(
  //         title: 'Example',
  //         description: 'Do homework!',
  //         taskStatus: Status.todo),
  //     Task(title: 'title', description: 'description', taskStatus: Status.todo)
  //   ];

  //   // final initialTask = <Task>[];

  //   setUp(() {
  //     tasksBloc = TasksBloc();
  //   });

  //   blocTest<TasksBloc, TasksState>('emit state AddTaskEvent when triggered',
  //       build: () => tasksBloc,
  //       act: (bloc) => bloc.add(AddItemEvent(
  //           item: Task(
  //               title: 'title',
  //               description: 'description',
  //               taskStatus: Status.todo))),
  //       expect: () => [isA<TasksState>()]);

  //   blocTest<TasksBloc, TasksState>('emit state EditTaskEvent when triggered',
  //       build: () => tasksBloc,
  //       act: (bloc) => bloc.add(EditItemEvent(index: 0, description: 'test')),
  //       expect: () => [isA<TasksState>()]);

  //   blocTest<TasksBloc, TasksState>('emit state EditTaskStatusEvent when triggered',
  //       build: () => tasksBloc,
  //       act: (bloc) => bloc.add(EditItemStatusEvent(index: 0, status: Status.inprogress)),
  //       expect: () => [isA<TasksState>()]);

  //   blocTest<TasksBloc, TasksState>(
  //       'emit state DeleteTaskEvent when triggered',
  //       build: () => tasksBloc,
  //       act: (bloc) =>
  //           bloc.add(DeleteItemEvent(index: 0)),
  //       expect: () => [isA<TasksState>()]);
  // });
}
