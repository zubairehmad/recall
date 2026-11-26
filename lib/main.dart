import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_common_ffi.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (defaultTargetPlatform == TargetPlatform.linux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    final directory = await getApplicationSupportDirectory();
    await databaseFactory.setDatabasesPath("$directory/databases");
  }

  runApp(const MyApp());
}
