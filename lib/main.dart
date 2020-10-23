import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mirea_app/main_screen/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MyApp> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      print(e.toString());
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error) {
      print("Ошибка");
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      print("Загрузка");
    } else
      return MainScreen();

    return MaterialApp(
        home: Scaffold(
      body: Text("Hello"),
    ));
  }
}
