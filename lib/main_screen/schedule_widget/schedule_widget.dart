import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mirea_app/model/Lesson.dart';

import 'calendar_strip/calendar_strip_widget.dart';
import 'lessons_list/lessons_list.dart';

class ScheduleWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScheduleWidgetState();
}

typedef void ChangeDayCallback(DateTime dateTime);

class ScheduleWidgetState extends State<ScheduleWidget> {
  final List<Lesson> lessons = [];
  List<Lesson> lessonsOfDay = [];

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
            mainAxisSize: MainAxisSize.max,
            children: [
              CalendarStripWidget((DateTime date) {
                print('wn: ' + weekNumber(date).toString());
                setState(() {
                  lessonsOfDay = lessons.where((element) => date.weekday - 1 == element.dayOfWeek).where((element) => element.weeks.contains(weekNumber(date))).toList();
                  lessonsOfDay.sort((a, b) => a.num.compareTo(b.num));
                });
              }),
              LessonsList(lessons)
            ],
          );
        }

        return getLoadingIndicator();
      },
    );
  }

  int weekNumber(DateTime date) {
    int dayOfYear = int.parse(DateFormat("D").format(date));
    return ((dayOfYear - date.weekday + 10) / 7).floor() - 35;
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
