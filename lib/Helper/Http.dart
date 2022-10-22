import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_challenge_2022/Helper/HttpResponse.dart';
import 'package:flutter_challenge_2022/Home/model/PeopleStarWartModel.dart';
class Http {
  Dio? _dio;
  Http({required Dio? dio}) {
    _dio = dio;
  }
  Future<Welcome>httpGet(String path) async {
    try {
      Response resp = await _dio!.get(path);
      return Welcome.fromJson(resp.data);
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occured: $error stackTrace: $stacktrace");
      }
      return Welcome.fromJson({});
    }
  }

  Future<HttpResponse<T>> request<T>(
    String path, {
    String method = 'POST',
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    T Function(dynamic data)? parser,
  }) async {
    try {
      final reponse = await _dio!.request(
        path,
        options: Options(method: method, headers: headers),
        queryParameters: queryParameters,
        data: data,
      );
      if (parser != null) {
        return HttpResponse.success(parser(reponse));
      }
      return HttpResponse.success(reponse.data);
    } catch (e) {
      int statusCode = 0; //errores sin acceso a internet
      String message = "error desconocido";
      dynamic data;
      if (e is DioError) {
        statusCode = -1;
        message = e.message;
        if (e.response != null) {
          statusCode = e.response!.statusCode!;
          message = e.response!.statusMessage!;
          data = e.response!.data!;
        }
      }
      return HttpResponse.fail(
        statusCode: statusCode,
        message: message,
        data: data,
      );
    }
  }


}