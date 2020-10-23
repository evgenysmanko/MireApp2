import 'package:flutter/material.dart';
import 'package:mirea_app/main_screen/schedule_widget/schedule_widget.dart';

import '../app_theme.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(appBar: null, body: ScheduleWidget()),
      theme: AppTheme.themeData,
    );
  }
}
