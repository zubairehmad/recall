import 'package:flutter/material.dart';

import 'core/models/information.dart';
import 'core/theme/app_theme.dart';
import 'features/navigation/screens/main_navigation_screen.dart';
import 'features/information/screens/add_information_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recall',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const MainNavigationScreen(),
      routes: {
        AddInformationScreen.routeName: (ctx) {
          final initialType =
              ModalRoute.of(ctx)?.settings.arguments as InformationType?;

          return AddInformationScreen(
            initialType: initialType,
          );
        },
      },
    );
  }
}
