import '../../domain/entities/{{entity_name.snakeCase()}}_entity.dart';

class {{entity_name.pascalCase()}}Model extends {{entity_name.pascalCase()}}Entity {
  const {{entity_name.pascalCase()}}Model();

  factory {{entity_name.pascalCase()}}Model.fromJson(Map<String, dynamic> json) {
    return const {{entity_name.pascalCase()}}Model();
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}
