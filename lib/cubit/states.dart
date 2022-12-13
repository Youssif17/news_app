abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsGetBusinessSuccessState extends NewsStates {}
class NewsGetBusinessloadingsState extends NewsStates {}
class NewsGetBusinessErrorsState extends NewsStates {
  final String error;

  NewsGetBusinessErrorsState(this.error);
}

class NewsBottomNavState extends NewsStates {}

class NewsGetSportsSuccessState extends NewsStates {}
class NewsGetSportssloadingsState extends NewsStates {}
class NewsGetSportsErrorsState extends NewsStates {
  final String error;

  NewsGetSportsErrorsState(this.error);
}

class NewsGetScienceSuccessState extends NewsStates {}
class NewsGetScienceLoadingsState extends NewsStates {}
class NewsGetScienceErrorsState extends NewsStates {
  final String error;

  NewsGetScienceErrorsState(this.error);
}

class ChangeModeState extends NewsStates {}

class NewsGetSearchSuccessState extends NewsStates {}
class NewsGetSearchLoadingsState extends NewsStates {}
class NewsGetSearchErrorsState extends NewsStates {
  final String error;

  NewsGetSearchErrorsState(this.error);
}

