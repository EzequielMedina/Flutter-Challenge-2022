part of 'home_page_bloc.dart';

@immutable
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
