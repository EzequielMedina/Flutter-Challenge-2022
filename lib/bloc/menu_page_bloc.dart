import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'menu_page_event.dart';
part 'menu_page_state.dart';

class MenuPageBloc extends Bloc<MenuPageEvent, MenuPageState> {
  MenuPageBloc() : super(MenuPageInitial(true)) {
    on<MenuPageEvent>((event, emit) {
    });

    on<MenuPageSetEvent>((event, emit) {
      emit(/*state.copyWith(event.changeSwitch)*/ MenuPageInitial(event.changeSwitch));
    });
  }
}
