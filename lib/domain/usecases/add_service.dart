import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/service.dart';
import '../repositories/service_repository.dart';

class AddService {
  final ServiceRepository repository;

  AddService(this.repository);

  Future<Either<Failure, void>> call(Service service) async {
    return await repository.addService(service);
  }
}
