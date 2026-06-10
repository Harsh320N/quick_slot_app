import 'package:dio/dio.dart';

abstract class BaseApiServices {
  Future<Response> getApi(String url);

  Future<Response> postApi(dynamic body, String url);

  Future<Response> deleteApi(dynamic body, String url);

  Future<Response> putApi(dynamic body, String url);

  Future<Response> multiPartApi(FormData body, String url);
}
