import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:quick_slot_app/data/app_exceptions.dart';
import 'package:quick_slot_app/data/network/base_api_services.dart';
import 'package:quick_slot_app/utils/utils.dart';

class NetworkApiServices extends BaseApiServices {
  //TODO: GET API REQUEST
  @override
  Future<Map<String, dynamic>?> getApi(String url) async {
    final dio = Dio();
    bool connection = await Utils.checkConnection();
    try {
      if (connection) {
        Map<String, String> header = {};
        dio.options.contentType = Headers.formUrlEncodedContentType;
        if (kDebugMode) {
          log("URL ----- $url");
        }
        final response = await dio
            .get(url, options: Options(headers: header))
            .timeout(const Duration(seconds: 120));
        if (kDebugMode) {
          log("RESPONSE STATUS CODE ----- ${response.statusCode}");
          log("RESPONSE ----- $response");
        }
        return response.data;
      } else {
        Utils.snack(text: "Check your internet connection!");
      }
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    } on DioException catch (error) {
      if (error.response!.statusCode == 401) {}
      if (kDebugMode) {
        log("ERROR WITH RESPONSE STATUS CODE ----- ${error.response!.statusCode}");
        log("ERROR WITH RESPONSE ----- ${error.response}");
      }
      return error.response!.data;
    }
    return null;
  }

  //TODO: POST API REQUEST
  @override
  Future<Map<String, dynamic>?> postApi(var body, String url) async {
    final dio = Dio();
    bool connection = await Utils.checkConnection();
    try {
      if (connection) {
        Map<String, String> header = {};
        dio.options.contentType = Headers.formUrlEncodedContentType;
        if (kDebugMode) {
          log("URL ----- $url");
          log("HEADER ----- $header");
          log("BODY ----- $body");
        }
        final response = await dio.post(
          url,
          data: body,
          options: Options(headers: header),
          onSendProgress: (int sent, int total) {
            int progress = 0;
            progress = int.parse((sent / total * 100).toStringAsFixed(0));
            if (kDebugMode) {
              log('progress: $progress');
            }
          },
        ).timeout(const Duration(seconds: 120));
        if (kDebugMode) {
          log("RESPONSE STATUS CODE ----- ${response.statusCode}");
          log("RESPONSE ----- $response");
        }
        return response.data;
      } else {
        Utils.snack(text: "Check your internet connection!");
      }
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    } on DioException catch (error) {
      if (error.response!.statusCode == 401) {}
      if (kDebugMode) {
        log("ERROR WITH RESPONSE STATUS CODE ----- ${error.response!.statusCode}");
        log("ERROR WITH RESPONSE ----- ${error.response}");
      }
      return error.response!.data;
    }
    return null;
  }

  //TODO: PUT API REQUEST
  @override
  Future<Map<String, dynamic>?> putApi(var body, String url) async {
    final dio = Dio();
    bool connection = await Utils.checkConnection();
    try {
      if (connection) {
        Map<String, String> header = {};
        if (kDebugMode) {
          log("URL ----- $url");
          log("HEADER ----- $header");
          log("BODY ----- $body");
        }
        final response = await dio
            .put(url, data: body, options: Options(headers: header))
            .timeout(const Duration(seconds: 120));
        if (kDebugMode) {
          log("RESPONSE STATUS CODE ----- ${response.statusCode}");
          log("RESPONSE ----- $response");
        }
        return response.data;
      } else {
        Utils.snack(text: "Check your internet connection!");
      }
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    } on DioException catch (error) {
      if (error.response!.statusCode == 401) {}
      if (kDebugMode) {
        log("ERROR WITH RESPONSE STATUS CODE ----- ${error.response!.statusCode}");
        log("ERROR WITH RESPONSE ----- ${error.response}");
      }
      return error.response!.data;
    }
    return null;
  }

  //TODO: DELETE API REQUEST
  @override
  Future<Map<String, dynamic>?> deleteApi(var body, String url) async {
    final dio = Dio();
    bool connection = await Utils.checkConnection();
    try {
      if (connection) {
        Map<String, String> header = {};
        if (kDebugMode) {
          log("URL ----- $url");
          log("HEADER ----- $header");
          log("BODY ----- $body");
        }
        final response = await dio
            .delete(url, data: body, options: Options(headers: header))
            .timeout(const Duration(seconds: 120));
        if (kDebugMode) {
          log("RESPONSE STATUS CODE ----- ${response.statusCode}");
          log("RESPONSE ----- $response");
        }
        return response.data;
      } else {
        Utils.snack(text: "Check your internet connection!");
      }
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    } on DioException catch (error) {
      if (error.response!.statusCode == 401) {}
      if (kDebugMode) {
        log("ERROR WITH RESPONSE STATUS CODE ----- ${error.response!.statusCode}");
        log("ERROR WITH RESPONSE ----- ${error.response}");
      }
      return error.response!.data;
    }
    return null;
  }

  //TODO: MULTIPART API REQUEST
  @override
  Future<Map<String, dynamic>?> multiPartApi(
    FormData body,
    String url,
  ) async {
    final dio = Dio();
    bool connection = await Utils.checkConnection();
    try {
      if (connection) {
        Map<String, String> header = {};
        if (kDebugMode) {
          log("URL ----- $url");
          log("HEADER ----- $header");
          log("BODY (FILES) ----- ${body.files}");
          log("BODY (FIELDS) ----- ${body.fields}");
        }
        final response = await dio.post(
          url,
          data: body,
          options: Options(
            headers: header,
          ),
          onSendProgress: (int sent, int total) {
            int progress = 0;
            progress = int.parse((sent / total * 100).toStringAsFixed(0));
            if (kDebugMode) {
              log('progress: $progress');
            }
          },
        ).timeout(const Duration(seconds: 120));
        if (kDebugMode) {
          log("RESPONSE STATUS CODE ----- ${response.statusCode}");
          log("RESPONSE ----- $response");
        }
        return response.data;
      } else {
        Utils.snack(text: "Check your internet connection!");
      }
    } on DioException catch (error) {
      if (error.response!.statusCode == 401) {}
      if (kDebugMode) {
        log("ERROR WITH RESPONSE STATUS CODE ----- ${error.response!.statusCode}");
        log("ERROR WITH RESPONSE ----- ${error.response}");
      }
      return error.response!.data;
    } on SocketException {
      Utils.snack(text: "Check your internet connection");
    } on RequestTimeOutException {
      Utils.snack(text: "Something want wrong, please try again");
    }
    return null;
  }
}
