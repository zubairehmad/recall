import 'package:flutter/material.dart';

import 'config/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recall',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Recall'),
        ),
        body: const Center(
          child: Text('The recall application!'),
        ),
      ),
    );
  }
}
