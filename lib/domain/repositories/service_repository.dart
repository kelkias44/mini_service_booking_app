import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/service.dart';

abstract class ServiceRepository {
  Future<Either<Failure, List<Service>>> getServices();
  Future<Either<Failure, Service>> addService(Service service);
  Future<Either<Failure, Service>> updateService(Service service);
  Future<Either<Failure, Service>> deleteService(String id);
}
