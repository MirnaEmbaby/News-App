import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/settings/settings_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.sports_soccer_outlined,
      ),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.science_outlined,
      ),
      label: 'Science',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.settings_outlined,
      ),
      label: 'Settings',
    ),
  ];

  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
    const SettingsScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1) {
      getSportsNews();
    }
    if (index == 2) {
      getScienceNews();
    }
    emit(NewsBottomNavState());
  }

  List<dynamic> businessNews = [];

  void getBusinessNews() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'us',
      'category': 'business',
      'apiKey': 'e706c9b0e34548b6bbb748504062a6ec',
    }).then((value) {
      businessNews = value.data['articles'];
      debugPrint(businessNews[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      error.toString();
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sportsNews = [];

  void getSportsNews() {
    emit(NewsGetSportsLoadingState());
    if (sportsNews.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'us',
        'category': 'sports',
        'apiKey': 'e706c9b0e34548b6bbb748504062a6ec',
      }).then((value) {
        sportsNews = value.data['articles'];
        debugPrint(sportsNews[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        error.toString();
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> scienceNews = [];

  void getScienceNews() {
    emit(NewsGetScienceLoadingState());
    if (scienceNews.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'us',
        'category': 'science',
        'apiKey': 'e706c9b0e34548b6bbb748504062a6ec',
      }).then((value) {
        scienceNews = value.data['articles'];
        debugPrint(scienceNews[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        error.toString();
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }
}
