import 'package:calendar_strip/calendar_strip.dart';
import 'package:flutter/material.dart';

class CalendarStripWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CalendarStripWidgetState();
}

class CalendarStripWidgetState extends State<CalendarStripWidget> {
  @override
  Widget build(BuildContext context) => CalendarStrip(
        startDate: DateTime(2020, 1, 1),
        endDate: DateTime(2020, 12, 1),
        dateTileBuilder: dateTileBuilder,
        monthNameWidget: monthNameWidget,
        iconColor: Colors.black87,
        onDateSelected: () => print("object"),
        containerDecoration: BoxDecoration(color: Theme.of(context).primaryColor),
        addSwipeGesture: true,
      );

  monthNameWidget(monthName) {
    return Container(
      child: Container(width: double.infinity, child: Text(monthName.toString().split(" ")[0], textAlign: TextAlign.start, style: Theme.of(context).textTheme.bodyText2)),
      padding: EdgeInsets.only(top: 8, bottom: 4, left: 40),
    );
  }

  dateTileBuilder(date, selectedDate, rowIndex, dayName, isDateMarked, isDateOutOfRange) {
    bool isSelectedDate = date.compareTo(selectedDate) == 0;
    List<Widget> _children = [
      Text(dayName, style: Theme.of(context).textTheme.subtitle2),
      Text(date.day.toString(), style: isSelectedDate ? TextStyle(color: Colors.white) : Theme.of(context).textTheme.headline4),
    ];

    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 8, left: 5, right: 5, bottom: 5),
      decoration: BoxDecoration(
        color: !isSelectedDate ? Colors.transparent : Colors.lightBlue,
        borderRadius: BorderRadius.all(Radius.circular(60)),
      ),
      child: Column(
        children: _children,
      ),
    );
  }
}
