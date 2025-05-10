class ServerException implements Exception {
  final String message;
  final int statusCode;

  ServerException({
    this.message = 'Server Error',
    this.statusCode = 500,
  });

  @override
  String toString() => 'ServerException: $message ($statusCode)';
}

class NotFoundException extends ServerException {
  NotFoundException() : super(message: 'Resource not found', statusCode: 404);
}

class BadRequestException extends ServerException {
  BadRequestException() : super(message: 'Invalid request', statusCode: 400);
}
