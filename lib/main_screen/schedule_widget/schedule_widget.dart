import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mirea_app/model/Lesson.dart';

import 'calendar_strip/calendar_strip_widget.dart';
import 'lessons_list/lessons_list.dart';

class ScheduleWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScheduleWidgetState();
}

class ScheduleWidgetState extends State<ScheduleWidget> {
  final lessons = [
    Lesson(name: "Математическая логика и предметная статиистика", teacher: "Петров", room: "256", num: 1, type: "пр"),
    Lesson(name: "Основы инфромационной безопасности на предприятиях", teacher: "Петров", room: "256", num: 2, type: "лек"),
    Lesson(name: "Физическая культура и спорт", teacher: "Петров", room: "256", num: 3, type: "пр"),
    Lesson(name: "Квантовая физика в основах изучений Ньютона", teacher: "Петров", room: "256", num: 4, type: "пр")
  ];

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var lessonsF = firestore.collection('groups').doc("ББСО-01-17").collection("lessons");

    return FutureBuilder<QuerySnapshot>(
      future: lessonsF.get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          print(snapshot);
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          snapshot.data.docs.forEach((lessonRAW) {
            print(lessonRAW.get("weeks").toString());
            lessons.add(Lesson(
              name: lessonRAW.get("name"),
              teacher: lessonRAW.get("teacher"),
              room: lessonRAW.get("room"),
              type: lessonRAW.get("type"),
              weeks: List<int>.from(lessonRAW.get("weeks")),
              num: lessonRAW.get("num"),
              dayOfWeek: lessonRAW.get("dayOfWeek"),
            ));
          });
          return Column(
            children: [CalendarStripWidget(), LessonsList(lessons)],
          );
        }

        return getLoadingIndicator();
      },
    );

    return Column(
      children: [Container(padding: EdgeInsets.only(top: 30), child: CalendarStripWidget()), LessonsList(lessons)],
    );
  }

  Widget getLoadingIndicator() {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: 100),
        child: Column(
          children: [CircularProgressIndicator()],
        ));
  }
}
