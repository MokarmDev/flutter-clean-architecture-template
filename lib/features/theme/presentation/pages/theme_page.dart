import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/theme_cubit.dart';
import '../manager/theme_state.dart';

class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Theme')),
      body: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          if (state is ThemeLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return const Center(child: Text('Loaded State'));
        },
      ),
    );
  }
}
