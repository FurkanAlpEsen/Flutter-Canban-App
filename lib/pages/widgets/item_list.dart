import 'package:flutter/material.dart';
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
            return GestureDetector(
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
                    color: const Color.fromARGB(255, 235, 250, 26),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      items[index].title,
                      style: const TextStyle(
                        color: Color(0xFF472d54),
                        fontWeight: FontWeight.normal,
                        fontSize: 19,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
