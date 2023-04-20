import 'package:task_managment_app/pages/widgets/tasks.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int selectedpage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 136, 167, 69),
      body: TasksPage(
        index: selectedpage,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        onTap: (index) {
          setState(() {
            selectedpage = index;
            // print('index: $index');
          });
        },
        height: 60,
        backgroundColor: const Color.fromRGBO(87, 48, 55, 0),
        buttonBackgroundColor: const Color.fromARGB(255, 248, 181, 23),
        color: const Color(0xFF5B9033),
        animationCurve: Curves.decelerate,
        animationDuration: const Duration(milliseconds: 600),
        items: const <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.start, size: 30),
          Icon(Icons.refresh, size: 30),
          Icon(Icons.checklist_sharp, size: 30),
        ],
      ),
    );
  }
}
