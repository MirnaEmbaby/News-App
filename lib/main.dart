
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/layout_screen.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'package:news_app/shared/styles/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getBoolean(key: 'isDark');

  runApp( MyApp( isDark: isDark,));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  const MyApp({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..changeAppMode(fromShared: isDark),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state){},
        builder: (context, state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(

              colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink),
              appBarTheme: const AppBarTheme(
                titleSpacing: 20.0,
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
              textTheme: const TextTheme(
                bodyLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: dirtyBlack,
              colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink),
              appBarTheme: const AppBarTheme(
                titleSpacing: 20.0,
                color: dirtyBlack,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.light,
                  statusBarColor: dirtyBlack,
                ),
                surfaceTintColor: dirtyBlack,
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  color: pureWhite,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                backgroundColor: dirtyBlack,
                selectedItemColor: Colors.pink,
                elevation: 10.0,
              ),
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.pink,
                foregroundColor: pureBlack,
              ),
              unselectedWidgetColor: Colors.grey,
              textTheme: const TextTheme(
                bodyLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
            ),
            themeMode: AppCubit.get(context).isDark? ThemeMode.dark : ThemeMode.light,
            home: const LayoutScreen(),
          );
        },
      ),
    );
  }
}
