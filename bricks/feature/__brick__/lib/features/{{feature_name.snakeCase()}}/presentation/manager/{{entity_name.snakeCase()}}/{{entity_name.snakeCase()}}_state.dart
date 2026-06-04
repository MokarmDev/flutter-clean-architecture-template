import 'package:equatable/equatable.dart';

import '../../../domain/entities/{{entity_name.snakeCase()}}_entity.dart';

abstract class {{entity_name.pascalCase()}}State extends Equatable {
  const {{entity_name.pascalCase()}}State();

  @override
  List<Object?> get props => [];
}

class {{entity_name.pascalCase()}}Initial extends {{entity_name.pascalCase()}}State {}

class {{entity_name.pascalCase()}}Loading extends {{entity_name.pascalCase()}}State {}

class {{entity_name.pascalCase()}}Loaded extends {{entity_name.pascalCase()}}State {
  final List<{{entity_name.pascalCase()}}Entity> items;

  const {{entity_name.pascalCase()}}Loaded(this.items);

  @override
  List<Object?> get props => [items];
}

class {{entity_name.pascalCase()}}Error extends {{entity_name.pascalCase()}}State {
  final String message;

  const {{entity_name.pascalCase()}}Error(this.message);

  @override
  List<Object?> get props => [message];
}
