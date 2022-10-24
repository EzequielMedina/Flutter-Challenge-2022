import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_challenge_2022/Helper/Http.dart';
import 'package:flutter_challenge_2022/Home/repository/PeopleStarWart.dart';
import 'package:get_it/get_it.dart';

abstract class DependencyInjectionDio {
  static void initialize(){
    final Dio dio = Dio(
       BaseOptions(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }
      ),
    );

    Http http  = Http(dio: dio);

    final PeopleStarWart peopleStarWart = PeopleStarWart(http);

    GetIt.instance.registerSingleton<PeopleStarWart>(peopleStarWart);
  }
}