import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_challenge_2022/Home/model/PeopleStarWartModel.dart';
import 'package:flutter_challenge_2022/Home/repository/PeopleStarWart.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final _welcome = GetIt.instance<PeopleStarWart>();
  HomePageBloc() : super(HomePageInitial()) {

    on<HomePageEvent>((event, emit) async {
       try {
        emit(HomePageLoading());
        
        final mList = await _welcome.getPeople();
        emit(HomePageLoaded(mList));        
      } catch (e) {
        emit(const HomePageError("Failed to fetch data. is your device online?"));
      }
    });

    on<HomePageChangePage>((event, emit) async {
      try {
        emit(HomePageLoading());
        String page = event.path.split("?")[1];
        _welcome.path = "api/people?$page";
        final mList = await _welcome.getPeople();
        emit(HomePageLoaded(mList));        
      } catch (e) {
        emit(const HomePageError("Failed to fetch data. is your device online?"));
      }
    });
  }
}
