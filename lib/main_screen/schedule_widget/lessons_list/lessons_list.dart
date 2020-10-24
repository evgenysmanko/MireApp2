import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mirea_app/main_screen/schedule_widget/calendar_strip/calendar_strip_widget.dart';
import 'package:mirea_app/model/Lesson.dart';

import '../../../constants.dart';

class LessonsList extends StatefulWidget {
  LessonsList(this._lessons);

  List<Lesson> _lessons;

  @override
  State<StatefulWidget> createState() => LessonListState(_lessons);
}

class LessonListState extends State<LessonsList> {
  List<Lesson> _lessons;
  List<Lesson> _lessonsOfDay = [];
  DateTime _date;

  LessonListState(this._lessons);

  @override
  Widget build(BuildContext context) {
    _date = _date ?? DateTime.now();
    _lessonsOfDay = _lessons.where((element) => _date.weekday - 1 == element.dayOfWeek).where((element) => element.weeks.contains(weekNumber(_date))).toList();
    _lessonsOfDay.sort((a, b) => a.num.compareTo(b.num));
    print(_lessonsOfDay.length);
    return Expanded(
        child: Column(
      children: [
        CalendarStripWidget((DateTime date) {
          print('wn: ' + weekNumber(date).toString());
          setState(() {
            _date = date;
          });
        }),
        Expanded(
            child: ListView.builder(
                itemCount: _lessonsOfDay.length,
                itemBuilder: (context, index) {
                  return lessonItemWidget(_lessonsOfDay[index]);
                }))
      ],
    ));
  }

  int weekNumber(DateTime date) {
    int dayOfYear = int.parse(DateFormat("D").format(date));
    return ((dayOfYear - date.weekday + 10) / 7).floor() - 35;
  }

  Widget lessonItemWidget(Lesson lesson) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Container(
            height: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(startTimes[lesson.num - 1 ?? 1]),
                Text(finishTimes[lesson.num - 1 ?? 1]),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(lesson.name ?? ""),
                  Chip(
                    label: Text(lesson.teacher.toString() ?? ""),
                  )
                ],
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(lesson.room ?? ""),
              Chip(
                label: Text(lesson.type ?? ""),
                backgroundColor: Colors.greenAccent,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
