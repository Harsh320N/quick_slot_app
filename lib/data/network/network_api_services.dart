import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:quick_slot_app/data/app_exceptions.dart';
import 'package:quick_slot_app/data/network/base_api_services.dart';
import 'package:quick_slot_app/data/session/session.dart';
import 'package:quick_slot_app/utils/utils.dart';

class NetworkApiServices extends BaseApiServices {
  Dio _client() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        contentType: Headers.jsonContentType,
        validateStatus: (status) => status != null && status < 500,
      ),
    );
    if (Session.userId != null) {
      dio.options.headers['X-User-Id'] = Session.userId;
      dio.options.headers['X-User-Name'] = Session.userName ?? 'Player';
    }
    return dio;
  }

  Future<Response> _send(
    Future<Response> Function(Dio dio) request,
    String url,
  ) async {
    final connected = await Utils.checkConnection();
    if (connected != true) {
      throw InternetException('No internet connection');
    }
    try {
      if (kDebugMode) log("REQUEST ----- $url");
      final response = await request(_client());
      if (kDebugMode) {
        log("RESPONSE [${response.statusCode}] ----- ${response.data}");
      }
      return response;
    } on SocketException {
      throw InternetException('No internet connection');
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.sendTimeout) {
        throw RequestTimeOut('The request timed out');
      }
      throw FetchDataException('Could not reach the server');
    }
  }

  @override
  Future<Response> getApi(String url) =>
      _send((dio) => dio.get(url), url);

  @override
  Future<Response> postApi(dynamic body, String url) =>
      _send((dio) => dio.post(url, data: body), url);

  @override
  Future<Response> putApi(dynamic body, String url) =>
      _send((dio) => dio.put(url, data: body), url);

  @override
  Future<Response> deleteApi(dynamic body, String url) =>
      _send((dio) => dio.delete(url, data: body), url);

  @override
  Future<Response> multiPartApi(FormData body, String url) =>
      _send((dio) => dio.post(url, data: body), url);
}
