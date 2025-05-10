import 'package:dio/dio.dart';
import 'package:simple_service_management/core/constants/endpoints.dart';

class DioClient {
  final Dio dio = Dio(BaseOptions(
    baseUrl: Endpoints.baseUrl,
    connectTimeout: Duration(seconds: 50),
    receiveTimeout: Duration(seconds: 50),
  ));
}
