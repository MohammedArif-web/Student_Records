import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:studentrecord/Controller/providers.dart';

import 'update.dart';

class StudentProfile extends StatelessWidget {
  final String pname;
  final String page;
  final String pclass;
  final String pdiv;
  final int? pid;
  final String ppic;
  final int ind;
  // final int index;
  StudentProfile(
      {Key? key,
      required this.pname,
      required this.pclass,
      required this.page,
      required this.pdiv,
      required this.ppic,
      required this.pid,
      required this.ind})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor('#eeedf2'),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [HexColor('#111036'), HexColor('#28054a')]),
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(
                          MediaQuery.of(context).size.width, 150.0))),
              height: 270,
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: HexColor('#eeedf2'),
                            )),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 70,
                        child: ppic !=
                                "https://i.pinimg.com/564x/ec/e2/b0/ece2b0f541d47e4078aef33ffd22777e.jpg"
                            ? Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: FileImage(
                                      File(ppic),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "https://i.pinimg.com/564x/ec/e2/b0/ece2b0f541d47e4078aef33ffd22777e.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Name: $pname',
                              style: const TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                      height: 60,
                      width: 350,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            HexColor('#111036'),
                            HexColor('#28054a')
                          ]),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Age: $page',
                                style: const TextStyle(color: Colors.white)),
                          )
                        ],
                      ),
                      height: 60,
                      width: 350,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            HexColor('#111036'),
                            HexColor('#28054a')
                          ]),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Class: $pclass',
                                style: const TextStyle(color: Colors.white)),
                          )
                        ],
                      ),
                      height: 60,
                      width: 350,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            HexColor('#111036'),
                            HexColor('#28054a')
                          ]),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Division: $pdiv',
                                style: const TextStyle(color: Colors.white)),
                          )
                        ],
                      ),
                      height: 60,
                      width: 350,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            HexColor('#111036'),
                            HexColor('#28054a')
                          ]),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          shape: const CircleBorder(),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Updateone(
                                      name: pname,
                                      age: page,
                                      place: pclass,
                                      index: ind,
                                      div: pdiv,
                                    )));
                          },
                          child: Icon(
                            Icons.edit,
                            color: HexColor('#eeedf2'),
                          ),
                          color: Colors.amber,
                        ),
                        Consumer<StudentListProvider>(
                          builder: (context, value, child) {
                            return MaterialButton(
                              shape: const CircleBorder(),
                              onPressed: () {
                                value.deleteStudent(ind);
                                Navigator.of(context).pop();
                              },
                              child: Icon(
                                Icons.delete_forever,
                                color: HexColor('#eeedf2'),
                              ),
                              color: Colors.red,
                            );
                          },
                        )
                      ],
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  onupdate() {}
}
