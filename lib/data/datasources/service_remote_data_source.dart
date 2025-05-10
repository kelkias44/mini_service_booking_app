import 'package:dio/dio.dart';
import '../../core/constants/endpoints.dart';
import '../../core/errors/exceptions.dart';
import '../../core/network/dio_client.dart';
import '../models/service_model.dart';

class ServiceRemoteDataSource {
  final DioClient dioClient;

  ServiceRemoteDataSource({required this.dioClient});

  Future<List<ServiceModel>> getServices() async {
    final response = await dioClient.dio.get(Endpoints.services);
    return (response.data as List)
        .map((e) => ServiceModel.fromJson(e))
        .toList();
  }

  Future<ServiceModel> addService(ServiceModel service) async {
    try {
      final response = await dioClient.dio.post(
        Endpoints.services,
        data: service.toJson(),
      );

      if (response.statusCode == 201) {
        return ServiceModel.fromJson(response.data);
      }

      throw ServerException(
        message: 'Failed to create service',
        statusCode: response.statusCode!,
      );
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  Future<ServiceModel> updateService(ServiceModel service) async {
    try {
      final response = await dioClient.dio.put(
        '${Endpoints.services}/${service.id}',
        data: service.toJson(),
      );

      if (response.statusCode == 200) {
        return ServiceModel.fromJson(response.data);
      }

      throw ServerException(
        message: 'Failed to update service',
        statusCode: response.statusCode!,
      );
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  Future<ServiceModel> deleteService(String id) async {
    try {
      final response = await dioClient.dio.delete(
        '${Endpoints.services}/$id',
      );

      if (response.statusCode != 200) {
        throw ServerException(
          message: 'Failed to delete service',
          statusCode: response.statusCode!,
        );
      } else {
        return ServiceModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  ServerException _handleDioException(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return ServerException(message: 'Connection timeout');
    }
    return ServerException(
      message: e.message ?? 'Unknown error occurred',
      statusCode: e.response?.statusCode ?? 500,
    );
  }
}
