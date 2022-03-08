import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';
import 'package:studentrecord/Controller/providers.dart';
import 'package:studentrecord/database/modal.dart';

import 'package:studentrecord/main.dart';

final _formKey = GlobalKey<FormState>();
final _name = TextEditingController();
final _age = TextEditingController();
final _class = TextEditingController();
final _div = TextEditingController();
String pic =
    "https://i.pinimg.com/564x/ec/e2/b0/ece2b0f541d47e4078aef33ffd22777e.jpg";
bool imgStatus = false;

Future<void> addSheet(
  BuildContext context,
) async {
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [HexColor('#111036'), HexColor('#28054a')]),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
          ),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.80,
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 10,
              ),
              Consumer<StudentListProvider>(
                builder: (context, provider, child) {
                  return GestureDetector(
                    onTap: () async {
                      final ImagePicker _picker = ImagePicker();

                      final XFile? imagePath =
                          await _picker.pickImage(source: ImageSource.gallery);

                      if (imagePath != null) {
                        pic = imagePath.path;
                        imgStatus = Provider.of<StudentListProvider>(context,
                                listen: false)
                            .pickImage();
                      }
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Consumer<StudentListProvider>(
                          builder: (BuildContext context, value, child) {
                            return !imgStatus
                                ? Container(
                                    height: 100,
                                    width: 100,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                'https://i.pinimg.com/564x/ec/e2/b0/ece2b0f541d47e4078aef33ffd22777e.jpg'))),
                                  )
                                : Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: FileImage(File(pic)),
                                            fit: BoxFit.cover)),
                                  );
                          },
                        ),
                        const Positioned(
                          top: 60,
                          left: 60,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.add_photo_alternate,
                              size: 25,
                              color: Color.fromARGB(255, 27, 7, 69),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: TextFormField(
                          controller: _name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter name';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(18))),
                              hintText: 'Name'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _age,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter age';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(18))),
                              hintText: 'Age'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: TextFormField(
                          controller: _class,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter class';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(18))),
                              hintText: 'Class'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: TextFormField(
                          controller: _div,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter division';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(18))),
                              hintText: 'Division'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    shape: const CircleBorder(),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.cancel,
                      color: HexColor('#eeedf2'),
                    ),
                    color: Colors.red,
                  ),
                  Consumer<StudentListProvider>(
                      builder: (context, value, child) {
                    return MaterialButton(
                      shape: const CircleBorder(),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final nname = _name.text.trim();
                          final nage = _age.text.trim();
                          final nclass = _class.text.trim();
                          final ndiv = _div.text.trim();
                          final npic = pic.trim();

                          final _student = StudentModel(
                              name: nname,
                              age: nage,
                              grade: nclass,
                              div: ndiv,
                              pic: npic);

                          value.addStudent(_student);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              elevation: 10,
                              backgroundColor: Colors.indigo.shade900,
                              content: const Text('Savind Data'),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                          Navigator.pop(context);

                          // ListenableProvider<NavigationController>(create:(_)=>)
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => MyHomePage(),));
                        }
                      },
                      child: Icon(
                        Icons.check_circle,
                        color: HexColor('#eeedf2'),
                      ),
                      color: Colors.green,
                    );
                  })
                ],
              ),
            ],
          ),
        );
      });
}
