import 'dart:convert';

Lesson lessonFromJson(String str) {
  final jsonData = json.decode(str);
  return Lesson.fromJson(jsonData);
}

String lessonToJson(Lesson lesson) {
  final dyn = lesson.toJson();
  return json.encode(dyn);
}

class Lesson {
  int id;
  String name;
  String teacher;
  String room;
  String type;
  List<int> weeks;
  int num;
  int dayOfWeek;

  Lesson({this.id, this.name, this.teacher, this.room, this.type, this.weeks, this.num, this.dayOfWeek});

  factory Lesson.fromJson(Map<String, dynamic> json) =>
      Lesson(id: json["id"], name: json["name"], teacher: json["teacher"], room: json["room"], weeks: json["weeks"], num: json["num"], type: json["type"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "teacher": teacher,
        "room": room,
      };

  Map<String, dynamic> toMap() {
    return {"id": id, "name": name, "teacher": teacher, "room": room};
  }
}
