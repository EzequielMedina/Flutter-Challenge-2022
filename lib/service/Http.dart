import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_challenge_2022/Home/model/PeopleStarWartModel.dart';

class Http {
  Dio? _dio;
  Http({required Dio? dio}) {
    _dio = dio;
  }
  Future<dynamic> httpGet(String path) async {
    try {
      final res = await _dio!.get(path);
      return res;
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occured: $error stackTrace: $stacktrace");
      }
      return null;
    }
  }

  Future<dynamic> httpPost(
      String path, Map<String, dynamic> queryParameters) async {
    try {
      return await _dio!.post(path, data: queryParameters);
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occured: $error stackTrace: $stacktrace");
      }
      return null;
    }
  }
}
