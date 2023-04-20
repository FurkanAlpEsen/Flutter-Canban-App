import 'package:task_managment_app/blocs/task/tasks_bloc.dart';
import 'package:task_managment_app/pages/widgets/custom_navigation_bar.dart';
import 'package:task_managment_app/pages/widgets/tasks.dart';
import 'package:task_managment_app/sett%C4%B1ngs/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'blocs/theme/theme_bloc.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ThemeBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => TasksBloc(),
        )
      ],
      // create: (context) => TasksBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          initialization();
          return MaterialApp(
              title: 'All In One',
              debugShowCheckedModeBanner: false,
              theme: state.isDarkTheme ? darkTheme : lightTheme,
              home: Scaffold(
                bottomNavigationBar: const CustomBottomNavigationBar(),
                body: TasksPage(),
              ));
        },
      ),
    );
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 1));
    FlutterNativeSplash.remove();
  }
}
