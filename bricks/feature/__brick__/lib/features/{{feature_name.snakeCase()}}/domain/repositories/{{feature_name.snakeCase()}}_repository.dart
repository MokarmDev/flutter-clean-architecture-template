import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/{{entity_name.snakeCase()}}_entity.dart';

abstract class {{feature_name.pascalCase()}}Repository {
  Future<Either<Failure, List<{{entity_name.pascalCase()}}Entity>>> get{{entity_name.pascalCase()}}s();
}
