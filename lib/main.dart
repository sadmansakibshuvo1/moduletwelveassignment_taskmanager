import 'package:flutter/material.dart';
import 'package:moduletwelveassignment_taskmanager/ui/screens/splash_screen.dart';


void main() {
  runApp(const TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: const SplashScreen(),
      title: "Task Manager App ",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: const TextTheme(
            bodyLarge: TextStyle(
              fontFamily: 'oswald',
              fontWeight: FontWeight.w800,
              fontSize: 26,
            ),
            bodyMedium: TextStyle(
              fontFamily: 'oswald',
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            titleLarge: TextStyle(
              fontFamily: 'oswald',
              fontWeight: FontWeight.w800,
              fontSize: 14,
              color: Colors.greenAccent,
            ),
            titleSmall: TextStyle(
              fontFamily: 'oswald',
              fontWeight: FontWeight.normal,
              fontSize: 12,
              color: Colors.greenAccent,
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.greenAccent,
            hintStyle: Theme.of(context).textTheme.bodySmall,
            border: const OutlineInputBorder(borderSide: BorderSide.none),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              backgroundColor: const Color(0xFF21bf73),
            ),
          )),
    );
  }
}