import 'package:dio/dio.dart';

class DioService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.aladhan.com/v1/',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10)
    )
  ) ;
  static Future <dynamic> get(
      String endpoint , {
        Map <String , dynamic>? params ,
  }) async{
    final response = await _dio.get (
      endpoint , queryParameters: params
    );
     return response.data ;
  }
  static Future<dynamic> post(
      String endpoint, {
        Map<String, dynamic>? body,
      }) async {
    final response = await _dio.post(
      endpoint,
      data: body,
    );
    return response.data;
  }
}

