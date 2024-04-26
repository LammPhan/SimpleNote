import 'package:flutter/material.dart';
import 'package:note/database/database.dart';
import 'package:note/home/event_list_screen.dart';

@pragma('vm:entry-point')
Future mainNote() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  appDatabase = database;
  runApp(const MyApp());
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  appDatabase = database;
  runApp(const MyApp());
}

AppDatabase? appDatabase;

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const Color primaryColor = Color(0xff252525);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MaterialColor swatchColor = MaterialColor(primaryColor.value, {
      50: primaryColor.withOpacity(0.1),
      100: primaryColor.withOpacity(0.2),
      200: primaryColor.withOpacity(0.3),
      300: primaryColor.withOpacity(0.4),
      400: primaryColor.withOpacity(0.5),
      500: primaryColor.withOpacity(0.6),
      600: primaryColor.withOpacity(0.7),
      700: primaryColor.withOpacity(0.8),
      800: primaryColor.withOpacity(0.9),
      900: primaryColor,
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes',
      theme: ThemeData(
        primarySwatch: swatchColor,
      ),
      home: EventListScreen(),
    );
  }
}
