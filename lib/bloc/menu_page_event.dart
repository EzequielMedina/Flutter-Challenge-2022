part of 'menu_page_bloc.dart';

abstract class MenuPageEvent extends Equatable {
   MenuPageEvent();

  @override
  List<Object> get props => [];
}

class MenuPageSetEvent extends MenuPageEvent {
  final bool changeSwitch;
  MenuPageSetEvent(this.changeSwitch);
}
