import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:news/modules/search_screen/SearchScreen.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../shared/components/constants.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>
      (
      listener:(context, state) {} ,
      builder:(context , state)
      {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: MediaQuery.of(context).size.height / 8,
            title: const Text('News App'),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(40),
              )
            ),
            centerTitle: true,
            actions: [
              IconButton(onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));},
                  icon: const Icon(Icons.search))
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.CurrentIndex,
              onTap: (index)
              {
                  cubit.ChangeNavBar(index);
              },
              items: cubit.bottomItems,
          ),
          body: cubit.Screens[cubit.CurrentIndex],
          drawer: Drawer(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(100),
                bottomRight: Radius.circular(100),
              )
            ),
            width: MediaQuery.of(context).size.width /1.3,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 8,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Text(
                          'Dark Mode',
                        style: TextStyle(
                          color: isDark ? Colors.white :Colors.black,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      FlutterSwitch(
                          value: isDark,
                          onToggle: (value) {
                            cubit.changeAppMode();
                          },
                        activeColor: Colors.cyanAccent,
                        toggleColor: isDark ? Colors.black : Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      } ,
    );
  }
}
