import 'package:hive_flutter/adapters.dart';
part 'modal.g.dart';

@HiveType(typeId: 1)
class StudentModel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String age;
  @HiveField(3)
  String grade;
  @HiveField(4)
  String div;
  @HiveField(5)
  dynamic pic;

  StudentModel(
      {required this.name,
      required this.age,
      required this.grade,
      required this.div,
      required this.pic,
      this.id});
}
