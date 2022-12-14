import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translate_app/providers/targettext.dart';
import 'package:translate_app/screens/home_screen.dart';
import 'package:translate_app/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: TargetText()),
      ],
      child: MaterialApp(
        title: 'Translate App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
        ),
        themeMode: ThemeMode.dark,
        home: const SplashScreen(),
      ),
    );
  }
}
