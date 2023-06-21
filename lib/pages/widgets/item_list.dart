import 'package:Canban/blocs/bloc_exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/task_model.dart';
import '../detail.dart';

class ItemsList extends StatelessWidget {
  ItemsList({
    super.key,
    required this.items,
  });

  final List<Task> items;
  final List<String> statusList = ['Todo', 'InPorgress', 'Done'];
  final dropdownController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: _gridViewBuilder(context),
    );
  }

  Widget _gridViewBuilder(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key('item ${items[index]}'),
              background: Container(
                color: Colors.white,
                child: const Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.favorite, color: Colors.black),
                      Text('Move to favorites',
                          style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
              ),
              confirmDismiss: (DismissDirection direction) async {
                return await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    if (direction == DismissDirection.startToEnd) {
                      // print("Add to favorite");
                      return _favoriteAlert(context, index, true);
                      // context.read<TasksBloc>().add(AddItemFavoritesEvent(index: index));
                    } else {
                      // print('Remove item');
                      // context.read()<TasksBloc>().state.allItems.removeAt(index);
                      return _deleteAlert(context, index);
                    }
                  },
                );
              },
              secondaryBackground: Container(
                color: Colors.white,
                child: const Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      
                      Text('Move to trash',
                          style: TextStyle(color: Colors.black)),
                          Icon(Icons.delete, color: Colors.black),
                    ],
                  ),
                ),
              ),
              onDismissed: (DismissDirection direction) {
                if (direction == DismissDirection.startToEnd) {
                  // print("Add to favorite");
                  // context.read<TasksBloc>().add(AddItemFavoritesEvent(index: index));
                  // context.read()<TasksBloc>().state.allItems;
                } else {
                  // print('Remove item');
                  // context.read<TasksBloc>().add(DeleteItemEvent(index: index));
                  // context.read()<TasksBloc>().state.allItems.removeAt(index);
                }
              },
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return DetailPage(
                        index: index,
                        title: items[index].title,
                        description: items[index].description,
                      );
                    }),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 105, 193, 211),
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        items[index].title,
                        style: const TextStyle(
                          color: Color(0xFF472d54),
                          fontWeight: FontWeight.normal,
                          fontSize: 19,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 120),
                        child: IconButton(
                            onPressed: () {}, icon: Icon(Icons.favorite, color: context.read<TasksBloc>().state.allItems[index].isFavorite ? Colors.purpleAccent : Colors.black ,)),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget _deleteAlert(BuildContext context, int index) {
    return AlertDialog(
      title: const Text("Delete Confirmation"),
      content: const Text("Are you sure you want to delete this item?"),
      actions: <Widget>[
        ElevatedButton(
            onPressed: () {
              context.read<TasksBloc>().add(DeleteItemEvent(index: index));
              Navigator.of(context).pop(true);
            },
            child: const Text("Delete")),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text("Cancel"),
        ),
      ],
    );
  }

  Widget _favoriteAlert(BuildContext context,int index, bool isFavorite) {
    return AlertDialog(
      title: const Text("Favorite Confirmation"),
      content: const Text("Are you sure you want to favorite this item?"),
      actions: <Widget>[
        ElevatedButton(
            onPressed: (){
              context.read<TasksBloc>().add(FavoriteItemEvent(index: index, isFavorite: isFavorite));
              Navigator.of(context).pop(true);},
            child: const Text("Yes")),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text("No"),
        ),
      ],
    );
  }
}
