part of 'home_page_bloc.dart';


abstract class HomePageState extends Equatable {
  HomePageState();
  final bool _changeSwitch = true;
  @override
  List<dynamic> get props => [];
  
     HomePageState copyWith(bool changeSwitch) {
      return HomePageInitial(changeSwitch);
  }

  get welcome => null;
  get peope => null;
  get planet => null;
  get listNameVehicles => null;
  get listNameStarships => null;
  get changeSwitch => _changeSwitch;

}

class HomePageInitial extends HomePageState {
  
  final bool _changeSwitch;
  HomePageInitial( this._changeSwitch) : super();
  @override
  get changeSwitch => _changeSwitch;
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
  final Result? peope;
  final Planeta? planet;
  final List<String>? listNameVehicles;
  final List<String>? listNameStarships;
  final Welcome? welcome;

  @override

  get changeSwitch => _changeSwitch;
  HomePageDetailPeople(this.peope, this.planet,this.listNameVehicles,this.listNameStarships, this.welcome) : super();
}

class HomePageDetailPeopleBack extends HomePageState {
  final Welcome welcome;
  HomePageDetailPeopleBack(this.welcome) : super();

   //Welcome get getWelcome => welcome;
}

class ReportEventState extends HomePageState {
  final Welcome welcome;
  final Result peope;
  final message;
  ReportEventState(this.welcome, this.peope, this.message) : super();

}

class ChangeSwitchState extends HomePageState {
  final bool _changeSwitch;
  ChangeSwitchState(this._changeSwitch) : super();

}


