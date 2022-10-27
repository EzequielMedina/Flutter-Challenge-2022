import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_challenge_2022/Service/HiveData.dart';
import 'package:flutter_challenge_2022/Home/model/PeopleStarWartModel.dart';
import 'package:flutter_challenge_2022/Home/model/PlanetaModel.dart';
import 'package:flutter_challenge_2022/Home/model/StarshipsModel.dart';
import 'package:flutter_challenge_2022/Home/model/vehiculoModel.dart';
import 'package:flutter_challenge_2022/Home/repository/PeopleStarWart.dart';
import 'package:get_it/get_it.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final HiveData hiveData = HiveData();
  final _welcome = GetIt.instance<PeopleStarWart>();
  HomePageBloc()
      : super(HomePageState(
            isDetailPeople: false,
            changeSwitch: true,
            welcome: null,
            peope: null,
            planet: null,
            listNameStarships: null,
            listNameVehicles: null,
            valorIdWelcome: null)) {
    on<HomePageSetEvent>((event, emit) async {
      try {
        emit(HomePageLoading());

        Welcome? welcome;
        await hiveData
            .get("page=1", "Welcome")!
            .then((value) => welcome = value);
        if (welcome == null) {
          const path = "https://swapi.dev/api/people/";
          _welcome.path = path;
          welcome = await _welcome.getPeople(_welcome.path);
          await hiveData.put(welcome!, "page=1", "Welcome");
        }
        emit(state.copyWith(
            isDetailPeople: false,
            changeSwitch: state.changeSwitch,
            welcome: welcome,
            peope: state.peope,
            listNameStarships: state.listNameStarships,
            listNameVehicles: state.listNameVehicles,
            valorIdWelcome: state.valorIdWelcome));
      } catch (e) {
        emit(HomePageError("Failed to fetch data. is your device online?"));
      }
    });

    on<HomePageChangePage>((event, emit) async {
      try {
        emit(HomePageLoading());
        Welcome? welcome;
        String key = event.path.split("?")[1];
        await hiveData.get(key, "Welcome")!.then((value) => welcome = value);

        if (welcome == null) {
          _welcome.path = event.path;
          welcome = await _welcome.getPeople(_welcome.path);
          await hiveData.put(welcome!, key, "Welcome");
        }
        emit(state.copyWith(
            isDetailPeople: false,
            changeSwitch: state.changeSwitch,
            welcome: welcome,
            peope: state.peope,
            planet: state.planet,
            listNameStarships: state.listNameStarships,
            listNameVehicles: state.listNameVehicles,
            valorIdWelcome: state.valorIdWelcome));
      } catch (e) {
        emit(HomePageError("Failed to fetch data. is your device online?"));
      }
    });

    on<HomePageDetailPeopleEvent>((event, emit) async {
      Planeta? planet;
      Vehiculo? vehicles;
      Starships? starships;
      List<String> listNameVehicles = [];
      List<String> listNameStarships = [];
      try {
        Welcome? welcome;
        await hiveData
            .get(event.welcome.key, "Welcome")
            ?.then((value) => welcome = value);
        dynamic valorIdWelcome = welcome!.key;

        if (event.peope.homeworld != null) {
          await hiveData
              .getUrl(event.peope.homeworld!, "Planeta")!
              .then((value) => planet = value);
          if (planet == null) {
            _welcome.path = event.peope.homeworld!;
            planet = await _welcome.getPlanet();
            await hiveData.put(planet!, event.peope.homeworld!, "Planeta");
          }
        }
        if (event.peope.vehicles!.isNotEmpty) {
          for (var i = 0; i < event.peope.vehicles!.length; i++) {
            await hiveData
                .getUrl(event.peope.vehicles![i].toString(), "Vehiculo")!
                .then((value) => vehicles = value);

            if (vehicles == null) {
              _welcome.path = event.peope.vehicles![i].toString();
              vehicles = await _welcome.getVehicles();
              await hiveData.put(
                  vehicles!, event.peope.vehicles![i], "Vehiculo");
            }

            listNameVehicles.add(vehicles!.name.toString());
          }
        }
        if (event.peope.starships!.isNotEmpty) {
          for (var i = 0; i < event.peope.starships!.length; i++) {
            await hiveData
                .getUrl(event.peope.starships![i], "Starships")!
                .then((value) => starships = value);
            if (starships == null) {
              _welcome.path = event.peope.starships![i];
              starships = await _welcome.getStarships();
              await hiveData.put(
                  starships!, event.peope.starships![i], "Starships");
            }

            listNameStarships.add(starships!.name.toString());
          }
        }
        emit(state.copyWith(
            isDetailPeople: true,
            changeSwitch: state.changeSwitch,
            welcome: welcome,
            peope: event.peope,
            planet: planet,
            listNameStarships: listNameStarships,
            listNameVehicles: listNameVehicles,
            valorIdWelcome: valorIdWelcome));
      } catch (e) {
        emit(HomePageError("Failed to fetch data. is your device online?"));
      }
    });
    on<HomePageBackEvent>((event, emit) async {
      try {
        emit(HomePageLoading());
        late Welcome welcome;

        await hiveData
            .get(event.valorIdWelcome, "Welcome")
            ?.then((value) => welcome = value);
        emit(state.copyWith(
            isDetailPeople: false,
            changeSwitch: state.changeSwitch,
            welcome: welcome,
            peope: state.peope,
            listNameStarships: state.listNameStarships,
            listNameVehicles: state.listNameVehicles,
            valorIdWelcome: state.valorIdWelcome));
      } catch (e) {
        emit(HomePageError("Failed to fetch data. is your device online?"));
      }
    });

    on<ChangeSwitchEvent>((event, emit) async {
      emit(state.copyWith(
          isDetailPeople: state.isDetailPeople,
          changeSwitch: event.changeSwitch,
          welcome: state.welcome,
          peope: state.peope,
          listNameStarships: state.listNameStarships,
          listNameVehicles: state.listNameVehicles,
          valorIdWelcome: state.valorIdWelcome));
    });
  }
}
