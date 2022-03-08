import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studentrecord/database/modal.dart';

import '../database/modal.dart';

class StudentListProvider with ChangeNotifier {
  final box = Hive.box<StudentModel>('Student Record');
  ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

  String updateSearch(String hello) {
    String search1 = hello;
    notifyListeners();
    return search1;
  }

  File? image;
  bool pickImage() {
    notifyListeners();
    return true;
  }

  updatename(String value) {
    notifyListeners();
  }

  void addStudent(StudentModel value) async {
    final studentdb = await Hive.openBox<StudentModel>('Student Record');
    studentdb.add(value);

    notifyListeners();
  }

  getAllstudents() async {
    final studentdb = await Hive.openBox<StudentModel>('Student Record');
    studentListNotifier.value.clear();
    studentListNotifier.value.addAll(studentdb.values);
    notifyListeners();
  }

  Future<void> deleteStudent(int id) async {
    final studentdb = await Hive.openBox<StudentModel>('Student Record');
    studentdb.deleteAt(id);
    getAllstudents();
  }

  showCount(int count) {
    bool? check;
    if (count == 0) {
      check = false;
    } else if (count > 0) {
      check = true;
    }
    return check;
  }
}
