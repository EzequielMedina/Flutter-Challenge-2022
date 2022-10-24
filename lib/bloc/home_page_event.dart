part of 'home_page_bloc.dart';


abstract class HomePageEvent extends Equatable {
  const HomePageEvent();
  @override
  List<Object> get props => [];
}

class HomePageSetEvent extends HomePageEvent {}

class HomePageChangePage extends HomePageEvent {
  String path;
    HomePageChangePage(this.path);  
  
}

class HomePageDetailPeopleEvent extends HomePageEvent {
  final Result peope;
  final Welcome welcome;
  const HomePageDetailPeopleEvent(this.peope, this.welcome);

}

class HomePageBackEvent extends HomePageEvent {
  Welcome welcome;
  HomePageBackEvent(this.welcome);

}

class ReportEvent extends HomePageEvent {
  Welcome welcome;
  Result peope;
  ReportEvent(this.welcome, this.peope);

}

class ChangeSwitchEvent extends HomePageEvent {
  bool changeSwitch;
  ChangeSwitchEvent(this.changeSwitch);

}
