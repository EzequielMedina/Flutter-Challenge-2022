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
  final bool changeSwitch;
  const HomePageDetailPeopleEvent(this.peope, this.welcome, this.changeSwitch);
}

class HomePageBackEvent extends HomePageEvent {
  dynamic valorIdWelcome;
  HomePageBackEvent(this.valorIdWelcome);
}

class ReportEvent extends HomePageEvent {
  Result peope;
  ReportEvent(this.peope);
}

class ChangeSwitchEvent extends HomePageEvent {
  bool changeSwitch;
  ChangeSwitchEvent(this.changeSwitch);
}
