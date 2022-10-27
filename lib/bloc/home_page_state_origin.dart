// part of 'home_page_bloc.dart';

// import 'package:flutter_challenge_2022/Home/model/PeopleStarWartModel.dart';
// import 'package:flutter_challenge_2022/Home/model/PlanetaModel.dart';

// abstract class HomePageState extends Equatable {
//   HomePageState();
//   late bool _changeSwitch = true;
//   late Welcome? _welcome;
//   late Result? _peope;
//   late dynamic valorIdWelcome;
//   @override
//   List<dynamic> get props => [_changeSwitch];

//   //  HomePageState copyWith(bool changeSwitch, Welcome? welcome, Result? peope) {
//   //    bool changeSwitch =  _changeSwitch ?? this.changeSwitch;
//   //   final Welcome welcome = _welcome ?? this.welcome;
//   //   final Result peope = _peope ?? this.peope;
//   //   return HomePageInitial(changeSwitch, welcome, peope);
//   // }

//   get welcome => null;
//   get peope => null;
//   get planet => null;
//   get listNameVehicles => null;
//   get listNameStarships => null;
//   get changeSwitch => _changeSwitch;
// }

// class HomePageInitial extends HomePageState {
  
//   final bool changeSwitch;


//   @override
//    List<dynamic> get props => [changeSwitch];
//   HomePageInitial(this.changeSwitch) : super( );
  
// }

// class HomePageLoading extends HomePageState {
//   HomePageLoading() : super();
// }

// class HomePageLoaded extends HomePageState {
//   final Welcome? welcome;
//   HomePageLoaded(this.welcome) : super();
// }

// class HomePageError extends HomePageState {
//   final String? message;
//   HomePageError(this.message) : super();
// }

// class HomePageDetailPeople extends HomePageState {
//   final Result? peope;
//   final Planeta? planet;
//   final List<String>? listNameVehicles;
//   final List<String>? listNameStarships;
//   final dynamic valorIdWelcome;
//   final bool changeSwitch;

//   @override
//    List<dynamic> get props => [changeSwitch];
//   HomePageDetailPeople(this.peope, this.planet, this.listNameVehicles,
//       this.listNameStarships,this.changeSwitch, this.valorIdWelcome)
//       : super();
// }

// class HomePageDetailPeopleBack extends HomePageState {
//   final Welcome? welcome;
//   HomePageDetailPeopleBack(this.welcome) : super();

//   //Welcome get getWelcome => welcome;
// }

// class ReportEventState extends HomePageState {
//   final Welcome welcome;
//   final Result peope;
//   final message;
//   ReportEventState(this.welcome, this.peope, this.message) : super();
// }

// class ChangeSwitchState extends HomePageState {
//   final bool _changeSwitch;
//   @override
//   get changeSwitch => _changeSwitch;
//   ChangeSwitchState(this._changeSwitch) : super();
// }
