import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/controller/cubit/cubit.dart';
import 'package:todo/controller/cubit/states.dart';
import 'package:todo/shared/styles/themes.dart';
import 'package:todo/views/home_screen.dart';
import 'package:page_transition/page_transition.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool isDark = sharedPreferences.getBool("isDark") ?? false;
  runApp(EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [Locale('en', 'US'), Locale('ar', 'EG')],
      fallbackLocale: const Locale('en', 'US'),
      child: MyApp(
        isDark: isDark,
      )));
}

// Localization

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.isDark,
  }) : super(key: key);
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => TodoCubit()
              ..createDatabase()
              ..changeThemeMode(darkMode: isDark)),
      ],
      child: BlocBuilder<TodoCubit, TodoStates>(
        builder: (BuildContext context, state) {
          var cubit = TodoCubit.get(context);
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            title: 'Flutter Demo',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
            home: AnimatedSplashScreen(
              splash:
                  Image.asset('assets/images/todo_app.jpg', fit: BoxFit.cover),
              nextScreen: const HomeScreen(),
              splashIconSize: double.infinity,
              splashTransition: SplashTransition.fadeTransition,
              pageTransitionType: PageTransitionType.fade,
              backgroundColor: Colors.transparent,
              duration: 1000,
            ),
          );
        },
      ),
    );
  }
}
