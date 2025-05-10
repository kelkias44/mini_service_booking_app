import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final int statusCode;

  const Failure({required this.message, required this.statusCode});

  @override
  List<Object> get props => [message, statusCode];
}

class ServerFailure extends Failure {
  const ServerFailure({
    String message = 'Server Error',
    int statusCode = 500,
  }) : super(message: message, statusCode: statusCode);
}

class CacheFailure extends Failure {
  const CacheFailure() : super(message: 'Cache Error', statusCode: 500);
}

class NetworkFailure extends Failure {
  const NetworkFailure()
      : super(message: 'No Internet Connection', statusCode: 503);
}
