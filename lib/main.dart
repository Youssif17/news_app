import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news/cubit/cubit.dart';
import 'package:news/cubit/states.dart';
import 'package:news/shared/components/constants.dart';
import 'package:news/shared/network/local/cache_helper.dart';
import 'package:news/shared/network/remote/dioHelper.dart';

import 'layout/Homelayout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
    () {},
    blocObserver: MyBlocObserver(),
  );
  DioHelper.init();
  await CacheHelper.init();

  // bool? isDark = CacheHelper.getData(key: 'isDark');
  //bool isDark = NewsCubit.get(context).isDark;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => NewsCubit()
            ..gebusiness()
            ..changeAppMode()
            ..getScience()
            ..getSports(),
        ),
      ],
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          darkTheme: ThemeData(
            drawerTheme: const DrawerThemeData(
              backgroundColor: Colors.black54,
            ),
            primarySwatch: Colors.indigo,
            scaffoldBackgroundColor: HexColor('333739'),
            appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(color: Colors.cyanAccent),
              backgroundColor: Colors.black,
              elevation: 0.0,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.black,
                statusBarIconBrightness: Brightness.light,
              ),
              titleTextStyle: TextStyle(
                  color: Colors.cyanAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0),
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: Colors.grey,
                selectedItemColor: Colors.cyanAccent,
                elevation: 20.0,
                backgroundColor: Colors.black),
          ),
          theme: ThemeData(
            drawerTheme: const DrawerThemeData(
              backgroundColor: Colors.white54
            ),
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: HexColor('6e61ab'),
              elevation: 0.0,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: HexColor('6e61ab'),
                statusBarIconBrightness: Brightness.light,
              ),
              titleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white54,
                elevation: 20.0,
                backgroundColor: HexColor('6e61ab')),
          ),
          themeMode:
              isDark ? ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: const Directionality(
              textDirection: TextDirection.ltr, child: HomeLayout()),
        ),
      ),
    );
  }
}
