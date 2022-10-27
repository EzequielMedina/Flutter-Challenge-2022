import 'package:flutter_challenge_2022/Home/model/PeopleStarWartModel.dart';
import 'package:flutter_challenge_2022/Home/model/PlanetaModel.dart';
import 'package:flutter_challenge_2022/Home/model/StarshipsModel.dart';
import 'package:flutter_challenge_2022/Home/model/vehiculoModel.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveData {
  late Box box;


  Future<Welcome> getWelcome(dynamic index, dynamic boxName) async { 
    box = await Hive.openBox(boxName);  
    final data =  box.getAt(index)!;
    await box.close();
    return data;
  }

  Future<void> put(dynamic data, String key, dynamic box) async {
    box = await Hive.openBox(box);
    box.put(key, data);
    Hive.close();
  }

  Future<dynamic>? get(String key, dynamic boxName) async {
    box = await Hive.openBox(boxName);
    final respuesta = box.values.where((element) => element.key == key);  
    final data = respuesta.isEmpty ? null : box.get(respuesta.first.key);
    await Hive.close();
    return data;
  }

  Future<dynamic>? getUrl(String key, dynamic boxName) async {
    box = await Hive.openBox(boxName);
    final respuesta = box.values.where((element) => element.url == key);  
    final data = respuesta.isEmpty ? null : box.get(respuesta.first.url);
    await Hive.close();
    return data;
  }

}
