import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';

abstract class UseCase<T, Param> {
  Future<Either<Failure, T>> call([Param param]);
}

class NoParam {}
