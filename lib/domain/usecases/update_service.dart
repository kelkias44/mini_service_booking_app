import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/service.dart';
import '../repositories/service_repository.dart';

class UpdateService {
  final ServiceRepository repository;

  UpdateService(this.repository);

  Future<Either<Failure, void>> call(Service service) async {
    return await repository.updateService(service);
  }
}
