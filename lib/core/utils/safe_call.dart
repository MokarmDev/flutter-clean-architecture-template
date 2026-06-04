import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../errors/failures.dart';

Future<Either<Failure, T>> safeCall<T>(Future<T> Function() call) async {
  try {
    final result = await call();
    return Right(result);
  } on DioException catch (e) {
    return Left(failureFromDioException(e));
  } on FormatException catch (e) {
    return Left(ServerFailure(e.message));
  } catch (e) {
    return Left(ServerFailure(e.toString()));
  }
}
