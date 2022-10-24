import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_challenge_2022/Helper/HiveData.dart';
import 'package:flutter_challenge_2022/Home/model/PeopleStarWartModel.dart';
import 'package:flutter_challenge_2022/Home/model/PlanetaModel.dart';
import 'package:flutter_challenge_2022/Home/model/vehiculoModel.dart';
import 'package:flutter_challenge_2022/Home/repository/PeopleStarWart.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final HiveData hiveData =  HiveData();
  final _welcome = GetIt.instance<PeopleStarWart>();
  HomePageBloc() : super(HomePageInitial(false)) {

    on<HomePageSetEvent>((event, emit) async {
     try {
        emit(HomePageLoading());
        
        final mList = await _welcome.getPeople();
        emit(HomePageLoaded(mList));        
      } catch (e) {
        emit(HomePageError("Failed to fetch data. is your device online?"));
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
        emit(HomePageError("Failed to fetch data. is your device online?"));
      }
    });

    on<HomePageDetailPeopleEvent>((event, emit) async {
      var planet;
      var vehicles;
      var starships;
      List<String> listNameVehicles = [];
      List<String> listNameStarships = [];
      try {
        emit(HomePageLoading());
        if(event.peope.homeworld != null){
          String path = event.peope.homeworld!.split("dev/")[1];
          _welcome.path = path;
            planet = await _welcome.getPlanet();
        }
        if(event.peope.vehicles!.isNotEmpty){
          String path = event.peope.vehicles![0].split("dev/")[1];
          _welcome.path = path;
            vehicles = await _welcome.getVehicles();
            listNameVehicles.add(vehicles.name!);
        }
        if(event.peope.starships!.isNotEmpty){
          String path = event.peope.starships![0].split("dev/")[1];
          _welcome.path = path;
            starships = await _welcome.getStarships();
            listNameStarships.add(starships.name!);
        }
        emit(HomePageDetailPeople(event.peope, planet, listNameVehicles, listNameStarships, event.welcome));        
      } catch (e) {
        emit(HomePageError("Failed to fetch data. is your device online?"));
      }
    });
    on<HomePageBackEvent>((event, emit) async {
      try {
        emit(HomePageLoading());
         //hiveData.getWelcome(0).then((value) => 
          emit(HomePageDetailPeopleBack(event.welcome));
             
      } catch (e) {
        emit(HomePageError("Failed to fetch data. is your device online?"));
      }
    });

    on<ChangeSwitchEvent>((event, emit) async {       
        emit(HomePageInitial(event.changeSwitch));

    });

    on<ReportEvent>((event, emit) async {
      try {
        emit(HomePageLoading());
        String page = event.path.split("?")[1];
        _welcome.path = "api/people?$page";
        final mList = await _welcome.getPeople();
        emit(HomePageLoaded(mList));        
      } catch (e) {
        emit(HomePageError("Failed to fetch data. is your device online?"));
      }
    });
    
  }
}
