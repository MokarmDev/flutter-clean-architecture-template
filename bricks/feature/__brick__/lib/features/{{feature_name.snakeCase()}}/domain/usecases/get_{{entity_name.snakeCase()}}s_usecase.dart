import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/{{entity_name.snakeCase()}}_entity.dart';
import '../repositories/{{feature_name.snakeCase()}}_repository.dart';

class Get{{entity_name.pascalCase()}}sUseCase
    implements UseCase<List<{{entity_name.pascalCase()}}Entity>, NoParam> {
  final {{feature_name.pascalCase()}}Repository repository;

  Get{{entity_name.pascalCase()}}sUseCase(this.repository);

  @override
  Future<Either<Failure, List<{{entity_name.pascalCase()}}Entity>>> call(
      [NoParam? param]) async {
    return repository.get{{entity_name.pascalCase()}}s();
  }
}
