import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'features/navigation/screens/main_navigation_screen.dart';
import 'features/information/models/information.dart';
import 'features/information/providers/information_provider.dart';
import 'features/statistics/providers/information_stats_provider.dart';
import 'features/information/screens/information_form_screen.dart';
import 'features/information/screens/information_detail_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => InformationStatsProvider(),
      child: ChangeNotifierProvider(
        create: (ctx) =>
            InformationProvider(ctx.read<InformationStatsProvider>()),
        child: MaterialApp(
          title: 'Recall',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
          home: const MainNavigationScreen(),
          routes: {
            InformationFormScreen.routeName: (ctx) {
              final args =
                  ModalRoute.of(ctx)?.settings.arguments
                      as Map<String, dynamic>?;

              final initialType = args?['initialType'] as InformationType?;
              final information = args?['information'] as Information?;

              return InformationFormScreen(
                initialType: initialType,
                information: information,
              );
            },
            InformationDetailScreen.routeName: (ctx) {
              final infoId = ModalRoute.of(ctx)?.settings.arguments as String;
              return InformationDetailScreen(
                infoId: infoId,
              );
            },
          },
        ),
      ),
    );
  }
}
