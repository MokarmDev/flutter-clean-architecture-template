import 'package:dio/dio.dart';

import 'api_error_parser.dart';

abstract class Failure {
  final String message;

  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);

  factory ServerFailure.fromDioError(DioException e) {
    final failure = failureFromDioException(e);
    if (failure is ServerFailure) return failure;
    return ServerFailure(failure.message);
  }
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class CacheNotFoundFailure extends CacheFailure {
  const CacheNotFoundFailure([
    super.message = 'Requested data not found in cache.',
  ]);
}

class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

class TokenExpiredFailure extends AuthFailure {
  const TokenExpiredFailure([
    super.message = 'Session expired. Please log in again.',
  ]);
}

class UnauthorizedFailure extends AuthFailure {
  const UnauthorizedFailure([String? message])
    : super(message ?? 'You are not authorized to perform this action.');
}

class NetworkFailure extends Failure {
  const NetworkFailure([
    super.message = 'No internet connection. Please check your network.',
  ]);
}

class ValidationFailure extends Failure {
  final Map<String, String>? fieldErrors;

  const ValidationFailure(super.message, {this.fieldErrors});
}

/// Maps [DioException] to the appropriate [Failure] (used by [safeCall]).
Failure failureFromDioException(DioException exception) {
  switch (exception.type) {
    case DioExceptionType.connectionTimeout:
      return const ServerFailure('Connection timeout with API server.');
    case DioExceptionType.sendTimeout:
      return const ServerFailure('Send timeout with API server.');
    case DioExceptionType.receiveTimeout:
      return const ServerFailure('Receive timeout with API server.');
    case DioExceptionType.badCertificate:
      return const ServerFailure('Bad certificate from API server.');
    case DioExceptionType.badResponse:
      return failureFromResponse(
        exception.response!.statusCode!,
        exception.response!.data,
      );
    case DioExceptionType.cancel:
      return const ServerFailure('Request to API server was cancelled.');
    case DioExceptionType.connectionError:
      return const ServerFailure('No internet connection.');
    case DioExceptionType.unknown:
      return const ServerFailure(
        'An unexpected error occurred. Please try again.',
      );
  }
}

Failure failureFromResponse(int statusCode, dynamic response) {
  if (statusCode == 404) {
    return const ServerFailure('Resource not found. Please try later.');
  }
  if (statusCode == 500) {
    return const ServerFailure('Server error. Please try later.');
  }
  if (statusCode == 401) {
    return UnauthorizedFailure(ApiErrorParser.parseMessage(response));
  }
  if (statusCode == 400 || statusCode == 403) {
    return ServerFailure(ApiErrorParser.parseMessage(response));
  }
  return const ServerFailure('An error occurred. Please try again.');
}
