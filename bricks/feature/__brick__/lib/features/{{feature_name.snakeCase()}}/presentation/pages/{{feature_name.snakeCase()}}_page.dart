import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection_container.dart';
import '../manager/{{entity_name.snakeCase()}}/{{entity_name.snakeCase()}}_cubit.dart';
import '../manager/{{entity_name.snakeCase()}}/{{entity_name.snakeCase()}}_state.dart';
import '../widgets/{{feature_name.snakeCase()}}_widgets.dart';

class {{feature_name.pascalCase()}}Page extends StatelessWidget {
  const {{feature_name.pascalCase()}}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<{{entity_name.pascalCase()}}Cubit>()..loadData(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('{{feature_name.pascalCase()}}'),
        ),
        body: BlocBuilder<{{entity_name.pascalCase()}}Cubit, {{entity_name.pascalCase()}}State>(
          builder: (context, state) {
            if (state is {{entity_name.pascalCase()}}Loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is {{entity_name.pascalCase()}}Error) {
              return Center(child: Text(state.message));
            }
            if (state is {{entity_name.pascalCase()}}Loaded) {
              return {{feature_name.pascalCase()}}List(items: state.items);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
