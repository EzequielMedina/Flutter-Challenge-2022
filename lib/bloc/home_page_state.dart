part of 'home_page_bloc.dart';

@immutable
abstract class HomePageState extends Equatable {

  const HomePageState();
  @override
  List<Object> get props => [];
}

class HomePageInitial extends HomePageState {}

class HomePageLoading extends HomePageState {}

class HomePageLoaded extends HomePageState {
  final Welcome welcome;
  const HomePageLoaded(this.welcome);
}

class HomePageError extends HomePageState {
  final String? message;
  const HomePageError(this.message);
}
