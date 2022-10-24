part of 'menu_page_bloc.dart';

abstract class MenuPageState extends Equatable {
  MenuPageState();
  late bool _changeSwitch;
  @override
  List<Object> get props => [];
  get changeSwitch => false;
   MenuPageState copyWith(bool changeSwitch) {
      return MenuPageInitial(changeSwitch);
  }
}

class MenuPageInitial extends MenuPageState {
  late bool _changeSwitch;
   MenuPageInitial( this._changeSwitch) : super();
  
  get changeSwitch => _changeSwitch;
}
