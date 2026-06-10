import 'package:dio/dio.dart';

abstract class BaseApiServices {
  Future<Map<String, dynamic>?> getApi(String url);

  Future<Map<String, dynamic>?> postApi(dynamic body, String url);

  Future<Map<String, dynamic>?> deleteApi(dynamic body, String url);

  Future<Map<String, dynamic>?> putApi(dynamic body, String url);

  Future<Map<String, dynamic>?> multiPartApi(
    FormData body,
    String url,
  );
}
