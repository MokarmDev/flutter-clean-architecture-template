import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/profile_entity.dart';

abstract class ProfileRemoteDataSource {
  Future<Either<Failure, ProfileEntity>> fetchProfile();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  @override
  Future<Either<Failure, ProfileEntity>> fetchProfile() async {
    // TODO: implement API call
    throw UnimplementedError();
  }
}
