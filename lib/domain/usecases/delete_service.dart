import 'package:dartz/dartz.dart';
import 'package:simple_service_management/domain/entities/service.dart';
import '../../core/errors/failures.dart';
import '../repositories/service_repository.dart';

class DeleteService {
  final ServiceRepository repository;

  DeleteService(this.repository);

  Future<Either<Failure, Service>> call(String id) async {
    return await repository.deleteService(id);
  }
}
