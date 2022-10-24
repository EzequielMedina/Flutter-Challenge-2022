part of 'home_page_bloc.dart';


abstract class HomePageState extends Equatable {
  HomePageState();
  @override
  List<Object> get props => [];
  

  get welcome => null;
  @override
  get changeSwitch => null;

}

class HomePageInitial extends HomePageState {
  final bool _changeSwitch;
  @override
  get changeSwitch => _changeSwitch;
  HomePageInitial(this._changeSwitch) : super();
}

class HomePageLoading extends HomePageState {
  
  HomePageLoading() : super();
}
class HomePageLoaded extends HomePageState {
  final Welcome welcome;
  HomePageLoaded(this.welcome) : super();
}

class HomePageError extends HomePageState {
  final String? message;
  HomePageError(this.message) : super(); 
}

class HomePageDetailPeople extends HomePageState {
  final Result peope;
  final Planeta planet;
  final List<String> listNameVehicles;
  final List<String> listNameStarships;
  final Welcome welcome;
  HomePageDetailPeople(this.peope, this.planet,this.listNameVehicles,this.listNameStarships, this.welcome) : super();
}

class HomePageDetailPeopleBack extends HomePageState {
  final Welcome welcome;
  HomePageDetailPeopleBack(this.welcome) : super();

   //Welcome get getWelcome => welcome;
}

class ChangeSwitchState extends HomePageState {
  final bool _changeSwitch;
  ChangeSwitchState(this._changeSwitch) : super();

}


