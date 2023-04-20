// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class AddItemEvent extends TasksEvent {
  final Task item;

  const AddItemEvent({
    required this.item,
  });

  @override
  List<Object> get props => [item];
}

class EditItemEvent extends TasksEvent {
  final int index;
  final String description;

  const EditItemEvent({
    required this.index,
    required this.description,
  });

  @override
  List<Object> get props => [index, description];
}

class EditItemStatusEvent extends TasksEvent {
  final int index;
  final Status status;

  const EditItemStatusEvent({
    required this.index,
    required this.status,
  });

  @override
  List<Object> get props => [index, status];
}

class DeleteItemEvent extends TasksEvent {
  final int index;

  const DeleteItemEvent({
    required this.index,
  });

  @override
  List<Object> get props => [index];
}
