import 'package:flutter/material.dart';
import 'package:meditation/pages/main_screen.dart';
import 'package:meditation/providers/filter_provider.dart';
import 'package:meditation/providers/meditation_provider.dart';
import 'package:meditation/providers/mindfull_exercise_provider.dart';
import 'package:meditation/providers/sleep_content_provider.dart';
import 'package:meditation/router/router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => MindfullExerciseProvider()),
      ChangeNotifierProvider(create: (context) => MeditationProvider()),
      ChangeNotifierProvider(create: (context) => SleepContentProvider()),
      ChangeNotifierProvider(create: (context) => FilterdDataprovider()),
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Meditation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: RouterClass().router,
    );
  }
}
