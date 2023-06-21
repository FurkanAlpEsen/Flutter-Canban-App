import 'package:Canban/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Canban/services/notify_service.dart';

import '../blocs/task/tasks_bloc.dart';
import '../blocs/theme/theme_bloc.dart';

class DetailPage extends StatelessWidget {
  DetailPage(
      {super.key,
      required this.index,
      required this.title,
      required this.description});

  final String title;
  final String description;
  final int index;

  final TextEditingController _descriptionEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    _descriptionEditingController.text = description;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: IconButton(
              onPressed: () async {
                context.read<TasksBloc>().add(DeleteItemEvent(index: index));
                Navigator.pop(context);
                // print('pressed');
              },
              icon: const Icon(
                Icons.delete,
                size: 27,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Container(
            //color: Colors.cyan,
            child: Column(
              children: [
                EditableText(
                  onChanged: (value) {
                    context
                        .read<TasksBloc>()
                        .add(EditItemEvent(index: index, description: value));
                  },
                  maxLines: 20,
                  selectionColor: Colors.amber,
                  enableInteractiveSelection: true,
                  backgroundCursorColor: Colors.amber,
                  cursorColor: Colors.green,
                  focusNode: FocusNode(),
                  controller: _descriptionEditingController,
                  style: TextStyle(
                      fontSize: 23,
                      color: context.read<ThemeBloc>().state.isDarkTheme
                          ? Colors.white
                          : Colors.black),
                ),
                // notificationButton(context),
                _stateButtons(context),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        height: 35,
        width: 35,
        child: FloatingActionButton(        
            child: const Icon(Icons.settings),
            onPressed: () {
              _setTheme(context);
            }),
      ),
    );
  }

  void _setTheme(BuildContext context) async {
    context.read<ThemeBloc>().add(ChangeThemeEvent());
  }

  Widget notificationButton(BuildContext context){
    return ElevatedButton(onPressed: (){
      NotificationService().showNotification(title: 'Your Canban Reminder', body: 'Come in your table!');
    }, child: Text('Set Reminder'));
  }

  //! burda sorun var tasklarin state i sadece anasayfadan yenilenirse degisiyo
  Widget _stateButtons(BuildContext context) {
    return BlocConsumer<TasksBloc, TasksState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Container(
          height: 60,
          width: 290,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              notificationButton(context),
              IconButton(
                  color: Colors.amber,
                  highlightColor: Colors.amber,
                  //splashColor: Colors.amber,
                  onPressed: () {
                    context.read<TasksBloc>().add(
                        EditItemStatusEvent(index: index, status: Status.todo));
                  },
                  icon: const Icon(Icons.start)),
              IconButton(
                  color: const Color.fromARGB(255, 165, 193, 242),
                  highlightColor: Colors.blue,
                  onPressed: () {
                    context.read<TasksBloc>().add(EditItemStatusEvent(
                        index: index, status: Status.inprogress));
                  },
                  icon: const Icon(Icons.refresh)),
              IconButton(
                  color: const Color.fromARGB(255, 247, 147, 140),
                  highlightColor: Colors.red,
                  onPressed: () {
                    context.read<TasksBloc>().add(
                        EditItemStatusEvent(index: index, status: Status.done));
                  },
                  icon: const Icon(Icons.checklist_sharp)),
            ],
          ),
        );
      },
    );
  }
}
