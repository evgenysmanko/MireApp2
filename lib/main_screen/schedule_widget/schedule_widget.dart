import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mirea_app/model/Lesson.dart';

import 'lessons_list/lessons_list.dart';

class ScheduleWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScheduleWidgetState();
}

typedef void ChangeDayCallback(DateTime dateTime);

class ScheduleWidgetState extends State<ScheduleWidget> {
  final List<Lesson> lessons = [];

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.settings = Settings(persistenceEnabled: true);
    var lessonsF = firestore.collection('groups').doc("ББСО-01-17").collection("lessons");

    return lessons.length > 0
        ? scheduleWidget()
        : FutureBuilder<QuerySnapshot>(
            future: lessons.length > 0 ? lessons : lessonsF.get(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                print(snapshot);
                return Text("Something went wrong");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                lessons.clear();
                snapshot.data.docs.forEach((lessonRAW) {
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
                return scheduleWidget();
              }

              return getLoadingIndicator();
            },
          );
  }

  Widget scheduleWidget() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [LessonsList(lessons)],
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
