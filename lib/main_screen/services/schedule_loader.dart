import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mirea_app/model/Lesson.dart';

class ScheduleLoader {
  Future<List<Lesson>> loadSchedule(String groupName) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var lessonsF = firestore.collection('groups').doc("ББСО-01-17").collection("lessons");
  }
}
