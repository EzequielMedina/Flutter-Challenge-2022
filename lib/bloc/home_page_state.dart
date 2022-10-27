part of 'home_page_bloc.dart';

class HomePageState extends Equatable {
  final bool? isDetailPeople;
  bool? changeSwitch = true;
  final Welcome? welcome;
  final Result? peope;
  final Planeta? planet;
  late List<dynamic>? listNameVehicles = [];
  late List<dynamic>? listNameStarships = [];
  final dynamic valorIdWelcome;

   HomePageState({this.isDetailPeople,this.changeSwitch, this.welcome, this.peope,this.planet, this.listNameVehicles, this.listNameStarships, this.valorIdWelcome});
     
     HomePageState copyWith({bool? isDetailPeople, bool? changeSwitch, Welcome? welcome, Result? peope,Planeta? planet, List<dynamic>? listNameVehicles, List<dynamic>? listNameStarships, dynamic valorIdWelcome}) {
    return HomePageState(
      isDetailPeople: isDetailPeople ?? this.isDetailPeople,
      changeSwitch: changeSwitch ?? this.changeSwitch,
      welcome: welcome ?? this.welcome,
      peope: peope ?? this.peope,
      planet: planet ?? this.planet,
      listNameVehicles: listNameVehicles ?? this.listNameVehicles,
      listNameStarships: listNameStarships ?? this.listNameStarships,
      valorIdWelcome: valorIdWelcome ?? this.valorIdWelcome,
    );
  }
  @override
  List<dynamic> get props => [isDetailPeople, changeSwitch , welcome, peope, listNameVehicles, listNameStarships, valorIdWelcome];
}

class HomePageLoading extends HomePageState {
  HomePageLoading() : super();
}

class HomePageError extends HomePageState {
  final String? message;
  HomePageError(this.message) : super();
}

