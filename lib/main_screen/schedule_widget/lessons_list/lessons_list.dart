import 'package:flutter/material.dart';
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

  LessonListState(this._lessons);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        children: _lessons.map((lesson) => lessonItemWidget(lesson)).toList(),
      ),
    );
  }

  Widget lessonItemWidget(Lesson lesson) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 90,
      child: Row(
        children: [
          Container(
            height: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(startTimes[lesson.num ?? 1]),
                Text(finishTimes[lesson.num ?? 1]),
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
                    label: Text(lesson.weeks.toString() ?? ""),
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
