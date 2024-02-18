import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/layout/layout_screen.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'package:news_app/shared/styles/colors.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  DioHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink),
        appBarTheme: const AppBarTheme(
          color: dirtyWhite,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: dirtyWhite,
          ),
          surfaceTintColor: dirtyWhite,
          elevation: 0.0,
          titleTextStyle: TextStyle(
            color: pureBlack,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          backgroundColor: dirtyWhite,
          selectedItemColor: Colors.pink,
          elevation: 10.0,
        ),
        scaffoldBackgroundColor: dirtyWhite,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.pink,
          foregroundColor: pureWhite,
        ),
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: pureBlack,
      ),
      themeMode: ThemeMode.light,
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: LayoutScreen(),
      ),
    );
  }
}
