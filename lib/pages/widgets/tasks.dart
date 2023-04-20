import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/task/tasks_bloc.dart';
import '../../models/task_model.dart';
import 'item_list.dart';

class TasksPage extends StatelessWidget {
  TasksPage({super.key, this.index = 0});

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final int index;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return FutureBuilder(
          future: _getItemList(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Scaffold(
                  backgroundColor: const Color.fromARGB(255, 136, 167, 69),
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 65,
                      ),
                      _getPageTitle(),
                      const SizedBox(
                        height: 15,
                      ),
                      ItemsList(items: snapshot.data as List<Task>)
                    ],
                  ),
                  floatingActionButton: _getFloatingAButton(context));
            } else {
              return const CircularProgressIndicator();
            }
          },
        );
      },
    );
  }

  //! mixin yapisina cek ve detail sayfasindaki ile ortak yere bagla
  Widget _getFloatingAButton(BuildContext context) {
    if (index != 0) {
      return Container();
    } else {
      return FloatingActionButton(
        heroTag: null,
        backgroundColor: const Color.fromARGB(255, 242, 180, 23),
        onPressed: () => _dialogBuilder(context),
        child: const Icon(
          Icons.edit,
          size: 30,
          color: Colors.white,
        ),
      );
    }
  }

  //! Switch-case yapisi icin genel mixin yaz...
  Widget _getPageTitle() {
    String pageTitle = 'All Tasks';

    switch (index) {
      case 1:
        pageTitle = 'Todo Tasks';
        break;
      case 2:
        pageTitle = 'In Progress Tasks';
        break;
      case 3:
        pageTitle = 'Done Tasks';
        break;
      default:
    }
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFebe7c0),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        pageTitle,
        style: const TextStyle(fontSize: 25, color: Color(0xFF000000)),
      ),
    );
  }

  //! BLOC ile yeniden yaz....
  Future _getItemList(BuildContext context) async {
    var filteredList = context.read<TasksBloc>().state.allItems;
    switch (index) {
      case 1:
        filteredList = await filteredList
            .where((element) => element.taskStatus == Status.todo)
            .toList();
        //await ItemsList(items: filteredList);
        break;
      case 2:
        filteredList = await filteredList
            .where((element) => element.taskStatus == Status.inprogress)
            .toList();
        //await ItemsList(items: filteredList);
        break;
      case 3:
        filteredList = await filteredList
            .where((element) => element.taskStatus == Status.done)
            .toList();
        //await ItemsList(items: filteredList);
        break;
      default:
        break;
    }
    return await filteredList;
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Padding(
            padding: const EdgeInsets.all(20.0),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    keyboardType: TextInputType.multiline,
                    controller: _titleController,
                    maxLength: 20,
                    decoration: const InputDecoration(
                      hintText: 'title',
                      hintStyle: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    controller: _descriptionController,
                    maxLength: 120,
                    textAlign: TextAlign.left,
                    decoration: const InputDecoration(
                      hintText: 'description',
                      hintStyle: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: _dialogButtons(context),
        );
      },
    );
  }

  List<Widget> _dialogButtons(BuildContext context) {
    return <Widget>[
      TextButton(
        style: TextButton.styleFrom(
          textStyle: Theme.of(context).textTheme.labelLarge,
        ),
        child: const Text('Cancel'),
        onPressed: () {
          Navigator.of(context).pop();
          _titleController.clear();
          _descriptionController.clear();
        },
      ),
      TextButton(
        style: TextButton.styleFrom(
          textStyle: Theme.of(context).textTheme.labelLarge,
        ),
        child: const Text('OK'),
        onPressed: () {
          Task task = Task(
              title: _titleController.text,
              description: _descriptionController.text,
              taskStatus: Status.todo);
          context.read<TasksBloc>().add(AddItemEvent(item: task));
          _titleController.clear();
          _descriptionController.clear();
          Navigator.of(context).pop();
        },
      ),
    ];
  }
}
