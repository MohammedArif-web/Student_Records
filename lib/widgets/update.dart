import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:studentrecord/database/modal.dart';
import 'package:studentrecord/main.dart';
import 'package:hexcolor/hexcolor.dart';

class Updateone extends StatelessWidget {
  String name, age, place, div;
  int index;
  Updateone(
      {Key? key,
      required this.name,
      required this.age,
      required this.place,
      required this.index,
      required this.div})
      : super(key: key);

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: HexColor('#28054a'),
      content: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Builder(
              builder: (context) {
                var box = Hive.box<StudentModel>('Student Record');
                var data = box.getAt(index);
                return TextFormField(
                  initialValue: name,
                  decoration: const InputDecoration(
                    hintText: 'Name',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (value) {
                    data!.name = value;
                    data.save();
                  },
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Builder(
              builder: (context) {
                var box = Hive.box<StudentModel>('Student Record');
                var data = box.getAt(index);
                return TextFormField(
                  initialValue: age,
                  decoration: const InputDecoration(
                    hintText: 'Age',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (value) {
                    data!.age = value;
                    data.save();
                  },
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Builder(
              builder: (context) {
                var box = Hive.box<StudentModel>('Student Record');
                var data = box.getAt(index);
                return TextFormField(
                    initialValue: place,
                    decoration: const InputDecoration(
                      hintText: 'Class',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onChanged: (value) {
                      data!.grade = value;
                      data.save();
                    });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Builder(
              builder: (context) {
                var box = Hive.box<StudentModel>('Student Record');
                var data = box.getAt(index);
                return TextFormField(
                    initialValue: div,
                    decoration: const InputDecoration(
                      hintText: 'Division',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onChanged: (value) {
                      data!.div = value;
                      data.save();
                    });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () async {
              Navigator.pop(context);
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            )),
        TextButton(
            onPressed: () async {
              Navigator.push(
                  context, MaterialPageRoute(builder: (c) => MyHomePage()));
            },
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            )),
      ],
    );
  }
}
