import 'package:device_preview/device_preview.dart';
import 'package:elevator_test/data/database_helper.dart';
import 'package:elevator_test/pigeon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'app_model.dart';
import 'config/routers/app_routers.dart';


final databaseHelper = DatabaseHelper();
final pigeonApi = PigeonApi();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  debugPaintSizeEnabled = false;
  runApp(ChangeNotifierProvider<AppModel>(
    create: (_) => AppModel(),
    child: DevicePreview(
      enabled: false,
      builder: (context) => const MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        fontFamily: 'Inter',
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }

  @override
  void initState() {
    super.initState();
    /// load data from database
    var data = databaseHelper.getAllItems();
    data.listen((event) {
      context
          .read<AppModel>()
          .updateList(name: event.$1, floorsCount: event.$2);
    });
  }
}

