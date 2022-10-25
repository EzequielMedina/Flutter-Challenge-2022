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
  HomePageBloc() : super(HomePageInitial(true)) {

    on<HomePageSetEvent>((event, emit) async {
     try {
        emit(HomePageLoading());
        const path = "https://swapi.dev/api/people/";
        _welcome.path = path;
        final mList = await _welcome.getPeople(_welcome.path);
        emit(HomePageLoaded(mList));        
      } catch (e) {
        emit(HomePageError("Failed to fetch data. is your device online?"));
      }
    });

    on<HomePageChangePage>((event, emit) async {
      try {
        emit(HomePageLoading());
        
        _welcome.path = event.path;
        final mList = await _welcome.getPeople(_welcome.path);
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
        //emit(HomePageLoading());
        int valor;
        await hiveData.saveWelcome(event.welcome).then((value) => print(valor = value));
        if(event.peope.homeworld != null){
           
          _welcome.path = event.peope.homeworld!;
            planet = await _welcome.getPlanet();
        }
        if(event.peope.vehicles!.isNotEmpty){
          for (var i = 0; i < event.peope.vehicles!.length; i++) {
            _welcome.path = event.peope.vehicles![i];
            vehicles = await _welcome.getVehicles();
            listNameVehicles.add(vehicles.name!);
          }
          
        }
        if(event.peope.starships!.isNotEmpty){
          for (var i = 0; i < event.peope.starships!.length; i++) {
            _welcome.path = event.peope.starships![i];
            starships = await _welcome.getStarships();
            listNameStarships.add(starships.name!);
          }
          
        }
        emit(HomePageDetailPeople(event.peope, planet, listNameVehicles, listNameStarships, event.welcome));        
      } catch (e) {
        emit(HomePageError("Failed to fetch data. is your device online?"));
      }
    });
    on<HomePageBackEvent>((event, emit) async {
      try {
        emit(HomePageLoading());
        Welcome welcome;
        await hiveData.getWelcome(4).then((value) => print(welcome = value));
         //hiveData.getWelcome(0).then((value) => 
          emit(HomePageDetailPeopleBack(event.welcome));
             
      } catch (e) {
        emit(HomePageError("Failed to fetch data. is your device online?"));
      }
    });

    on<ChangeSwitchEvent>((event, emit) async {       
        emit(state.copyWith(event.changeSwitch));

    });

    // on<ReportEvent>((event, emit) async {
    //   try {
       
        
    //     _welcome.path =  "https://jsonplaceholder.typicode.com/posts";
    //     Map<String, dynamic> queryParameters ={
    //       "userId": 1,
    //       "dateTime": DateTime.now().toString(),
    //       "character_name": event.peope.name,
    //     };
    //     Map<dynamic, dynamic> res = await _welcome.postReport(_welcome.path, queryParameters );
        
              
    //   } catch (e) {
    //     emit(HomePageError("Failed to fetch data. is your device online?"));
    //   }
    // });
    
  }
}
