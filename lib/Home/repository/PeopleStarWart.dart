import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_challenge_2022/Helper/Http.dart';
import 'package:flutter_challenge_2022/Helper/HttpResponse.dart';
import 'package:flutter_challenge_2022/Home/model/PeopleStarWartModel.dart';

class PeopleStarWart {
  final Http _http;
  late String path = 'api/people';
  PeopleStarWart(this._http);
  Future<Welcome> getPeople() async {
     return await _http.httpGet(path);
  }

 
}
