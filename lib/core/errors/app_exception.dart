import 'package:equatable/equatable.dart';

abstract class AppException implements Exception, Equatable {
  final String message;
  final String? code;
  final StackTrace? stackTrace;

  const AppException({
    required this.message,
    this.code,
    this.stackTrace,
  });

  @override
  List<Object?> get props => [message, code, stackTrace];

  @override
  bool? get stringify => true;
}

class BleException extends AppException {
  const BleException({
    required super.message,
    super.code,
    super.stackTrace,
  });
}

class NetworkException extends AppException {
  const NetworkException({
    required super.message,
    super.code,
    super.stackTrace,
  });
}

class ValidationException extends AppException {
  const ValidationException({
    required super.message,
    super.code,
    super.stackTrace,
  });
}

class CacheException extends AppException {
  const CacheException({
    required super.message,
    super.code,
    super.stackTrace,
  });
}