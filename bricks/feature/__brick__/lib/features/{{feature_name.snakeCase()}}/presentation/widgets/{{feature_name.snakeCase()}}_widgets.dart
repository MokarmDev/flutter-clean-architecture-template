import 'package:flutter/material.dart';

import '../../domain/entities/{{entity_name.snakeCase()}}_entity.dart';

/// A simple ListView for {{entity_name.pascalCase()}} items.
/// Replace this with your own UI implementation.
class {{feature_name.pascalCase()}}List extends StatelessWidget {
  final List<{{entity_name.pascalCase()}}Entity> items;

  const {{feature_name.pascalCase()}}List({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(child: Text('No items found.'));
    }
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          title: Text(item.toString()),
        );
      },
    );
  }
}
