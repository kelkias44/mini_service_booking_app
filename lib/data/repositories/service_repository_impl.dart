import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/service.dart';
import '../../domain/repositories/service_repository.dart';
import '../datasources/service_remote_data_source.dart';
import '../models/service_model.dart';

class ServiceRepositoryImpl implements ServiceRepository {
  final ServiceRemoteDataSource remoteDataSource;

  ServiceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Service>>> getServices() async {
    try {
      final models = await remoteDataSource.getServices();
      return Right(models.map((model) => model.toEntity()).toList());
    } on ServerException catch (e) {
      Println("ERROR SERVER ERROR!!");
      return Left(ServerFailure(
        message: e.message,
        statusCode: e.statusCode,
      ));
    } on DioException {
      Println("ERROR DIO ERROR!!");
      return Left(const NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Service>> addService(Service service) async {
    try {
      final serviceModel = ServiceModel.fromEntity(service);
      final createdService = await remoteDataSource.addService(serviceModel);
      return Right(createdService.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
        statusCode: e.statusCode,
      ));
    } on DioException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Service>> updateService(Service service) async {
    try {
      final serviceModel = ServiceModel.fromEntity(service);
      final updatedService = await remoteDataSource.updateService(serviceModel);
      return Right(updatedService.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
        statusCode: e.statusCode,
      ));
    } on DioException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Service>> deleteService(String id) async {
    try {
      final deletedService = await remoteDataSource.deleteService(id);
      return Right(deletedService.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
        statusCode: e.statusCode,
      ));
    } on DioException {
      return Left(NetworkFailure());
    }
  }
}
