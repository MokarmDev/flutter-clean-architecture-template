import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/routing/app_router.dart';
import 'config/theme/app_theme.dart';
import 'core/constants/app_strings.dart';
import 'features/theme/domain/entities/theme_entity.dart';
import 'features/theme/presentation/manager/theme_cubit.dart';
import 'features/theme/presentation/manager/theme_state.dart';
import 'shared/wrappers/app_providers.dart';
import 'shared/wrappers/app_wrapper.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProviders(
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          bool isDark = false;
          if (state is ThemeSuccess) {
            isDark = state.theme.type == ThemeType.dark;
          }
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) => FlavorBanner(
              child: MaterialApp.router(
                title: AppStrings.appName,
                debugShowCheckedModeBanner: false,
                builder: (context, child) =>
                    AppWrapper(child: child ?? const SizedBox.shrink()),
                theme: isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
                supportedLocales: context.supportedLocales,
                localizationsDelegates: context.localizationDelegates,
                locale: context.locale,
                routerConfig: router,
              ),
            ),
          );
        },
      ),
    );
  }
}
