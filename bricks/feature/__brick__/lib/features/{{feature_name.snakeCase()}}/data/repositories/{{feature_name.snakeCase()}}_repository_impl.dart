import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/safe_call.dart';
import '../../domain/entities/{{entity_name.snakeCase()}}_entity.dart';
import '../../domain/repositories/{{feature_name.snakeCase()}}_repository.dart';
import '../datasources/{{feature_name.snakeCase()}}_remote_data_source.dart';

class {{feature_name.pascalCase()}}RepositoryImpl
    implements {{feature_name.pascalCase()}}Repository {
  final {{feature_name.pascalCase()}}RemoteDataSource remoteDataSource;

  {{feature_name.pascalCase()}}RepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<{{entity_name.pascalCase()}}Entity>>> get{{entity_name.pascalCase()}}s() {
    return safeCall(() => remoteDataSource.fetch{{entity_name.pascalCase()}}s());
  }
}
