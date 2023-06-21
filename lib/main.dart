import 'package:Canban/blocs/language/language_bloc.dart';
import 'package:Canban/blocs/task/tasks_bloc.dart';
import 'package:Canban/pages/widgets/custom_navigation_bar.dart';
import 'package:Canban/pages/widgets/tasks.dart';
import 'package:Canban/services/notify_service.dart';
import 'package:Canban/sett%C4%B1ngs/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'blocs/theme/theme_bloc.dart';
import 'l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => LanguageBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => ThemeBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => TasksBloc(),
        )
      ],
      // create: (context) => TasksBloc(),
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              // print('=============' +
              //     BlocProvider.of<LanguageBloc>(context).state.lg);
              initialization();
              return MaterialApp(
                  title: 'All In One',
                  debugShowCheckedModeBanner: false,
                  theme: state.isDarkTheme ? darkTheme : lightTheme,
                  supportedLocales: L10n.all,
                  locale: Locale(BlocProvider.of<LanguageBloc>(context)
                      .state
                      .lg), //! dil state i lazim!!
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate
                  ],
                  home: Scaffold(
                    bottomNavigationBar: const CustomBottomNavigationBar(),
                    body: TasksPage(),
                  ));
            },
          );
        },
      ),
    );
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 1));
    FlutterNativeSplash.remove();
  }
}
