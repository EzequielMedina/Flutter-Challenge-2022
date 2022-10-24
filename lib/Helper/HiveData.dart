import 'package:flutter_challenge_2022/Home/model/PeopleStarWartModel.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveData{
  late Box box = Hive.box('Welcome');

  Future<bool> initializeBox()async{
    box = await Hive.openBox('Welcome');
    return true;
  }

  Future<bool> save(var Welcome) async{
    await box.add(Welcome);
    return true;
  }

  get() {
    Map<dynamic,dynamic> wel = box.toMap();
    return wel;
  }

  Future<int> saveWelcome(Welcome welcome) async{
    return box.add(welcome);
  }

  Future<Welcome> getWelcome(int index) async{
    return box.getAt(index)!;
  }
}