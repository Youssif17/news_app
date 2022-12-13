import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/cubit/states.dart';
import 'package:news/modules/business/BusinessScreen.dart';
import 'package:news/modules/science/ScienceScreen.dart';
import 'package:news/modules/sports/SportsScreen.dart';
import 'package:news/shared/network/local/cache_helper.dart';

import '../shared/components/constants.dart';
import '../shared/network/remote/dioHelper.dart';

class NewsCubit extends Cubit <NewsStates>
{
  NewsCubit() : super (NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int CurrentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(
          Icons.business_center
      ),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
          Icons.sports
      ),
      label: 'sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
          Icons.science
      ),
      label: 'Science',
    ),
  ];

  void ChangeNavBar(int index){
    CurrentIndex = index;
    emit(NewsBottomNavState());
  }

  List<Widget> Screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
  ];

  List<dynamic > business = [];

  void gebusiness() {
    emit(NewsGetBusinessloadingsState());
    if(business.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country':'eg',
          'category':'business',
          'apiKey':'14fafbc6062d44a8acd0044d2e43ca32',
        }
    ).then((value)
    {
      //print(value.data['articles'][3]['title'].toString());
      business = value.data['articles'];
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorsState(error.toString()));
    });
    }
  }

  List<dynamic> sports = [];
  
  void getSports() {
    emit(NewsGetSportssloadingsState());
    if(sports.length == 0)
      {
        DioHelper.getData(
            url: 'v2/top-headlines',
            query: {
              'country': 'eg',
              'category': 'sports',
              'apiKey': '14fafbc6062d44a8acd0044d2e43ca32'
            }).then((value)
        {
          sports = value.data['articles'];
          emit(NewsGetSportsSuccessState());
        }).catchError((error)
        {
          print(error.toString());
          emit(NewsGetSportsErrorsState(error.toString()));
        });
      } else{
      emit(NewsGetSportsSuccessState());
    }

  }

  List<dynamic> science = [];

  void getScience () {
    emit(NewsGetScienceLoadingsState());

    if (science.length == 0) {
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country': 'eg',
            'category': 'science',
            'apiKey': '14fafbc6062d44a8acd0044d2e43ca32'
          }).then((value) {
        science = value.data['articles'];
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorsState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
    }


  void changeAppMode()
  {
    isDark = ! isDark;
     CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
       emit(ChangeModeState());
     });
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsGetSearchLoadingsState());

    DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q': '$value',
          'apiKey': '14fafbc6062d44a8acd0044d2e43ca32'
        }).then((value)
    {
      search = value.data['articles'];
      emit(NewsGetSearchSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(NewsGetSearchErrorsState(error.toString()));
    });

  }

}