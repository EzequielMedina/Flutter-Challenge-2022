import 'package:flutter_challenge_2022/Service/HiveData.dart';
import 'package:flutter_challenge_2022/Service/Http.dart';
import 'package:flutter_challenge_2022/Home/model/PeopleStarWartModel.dart';
import 'package:flutter_challenge_2022/Home/model/PlanetaModel.dart';
import 'package:flutter_challenge_2022/Home/model/StarshipsModel.dart';
import 'package:flutter_challenge_2022/Home/model/vehiculoModel.dart';

class PeopleStarWart {
  final Http _http;
  final HiveData hiveData = HiveData();
  late String path = "https://swapi.dev/api/people/";
  PeopleStarWart(this._http);
  Future<Welcome> getPeople(path) async {
    final resp = await _http.httpGet(path);
    return Welcome.fromJson(resp.data);
  }

  Future<Planeta> getPlanet() async {
    final resp = await _http.httpGet(path);
    return Planeta.fromJson(resp.data);
  }

  Future<Vehiculo> getVehicles() async {
    final resp = await _http.httpGet(path);
    return Vehiculo.fromJson(resp.data);
  }

  Future<Starships> getStarships() async {
    final resp = await _http.httpGet(path);
    return Starships.fromJson(resp.data);
  }

  Future<Map<dynamic, dynamic>> postReport(path, queryParameters) async {
    final resp = await _http.httpPost(path, queryParameters);
    return resp.data;
  }
}
