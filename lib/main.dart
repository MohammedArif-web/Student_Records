import 'dart:io';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:studentrecord/Controller/providers.dart';
import 'package:studentrecord/database/modal.dart';

import 'package:studentrecord/widgets/bottomsheet.dart';
import 'package:studentrecord/widgets/profile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }
  await Hive.openBox<StudentModel>('Student Record');
  runApp(ChangeNotifierProvider(
    create: (context) => StudentListProvider(),
    child: const MyApp(),
  ));
}

String search = "";

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  dynamic studentcount;
  final box = Hive.box<StudentModel>('Student Record');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor('#eeedf2'),
        appBar: AppBar(
          toolbarHeight: 120,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Column(
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 90,
                    height: 10,
                  ),
                  Text(
                    'Students Record',
                    style: TextStyle(color: HexColor('#eeedf2')),
                  ),
                  const SizedBox(
                    width: 80,
                    height: 10,
                  ),
                  Consumer<StudentListProvider>(
                    builder: (context, value, child) {
                      dynamic count = box.values.toList().length.toInt();
                      return Badge(
                        badgeContent: Text(
                          "$count",
                          style: const TextStyle(color: Colors.white),
                        ),
                        showBadge: value.showCount(count),
                        child: Icon(
                          Icons.group,
                          color: HexColor('#eeedf2'),
                        ),
                        animationType: BadgeAnimationType.fade,
                      );
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Container(
                    child: Consumer<StudentListProvider>(
                        builder: ((context, provider, child) {
                      return TextFormField(
                        onChanged: (value) {
                          search = provider.updateSearch(value);
                        },
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: HexColor('#eeedf2'),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18))),
                            hintText: 'Search..'),
                      );
                    })),
                    decoration: BoxDecoration(
                        color: HexColor('#eeedf2'),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    height: 40,
                    width: 250,
                  )
                ],
                ///////////////////////search...
              )
            ],
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [HexColor('#111036'), HexColor('#28054a')]),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
          ),
        ),
        body: Consumer<StudentListProvider>(
          builder: (context, provider, child) {
            provider.getAllstudents();
            return ValueListenableBuilder(
              valueListenable: provider.studentListNotifier,
              builder: (BuildContext context, List<StudentModel> studentList,
                  Widget? child) {
                final box = Hive.box<StudentModel>('Student Record');

                var records = search.isEmpty
                    ? box.values.toList()
                    : box.values
                        .where((value) => value.name.toLowerCase().contains(
                              search,
                            ))
                        .toList();

                return records.isEmpty
                    ? const Center(child: Text('No Records'))
                    : ListView.separated(
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                                backgroundImage: const NetworkImage(
                                    'https://i.pinimg.com/564x/ec/e2/b0/ece2b0f541d47e4078aef33ffd22777e.jpg'),
                                child: records[index].pic != null
                                    ? Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: FileImage(
                                              File(records[index].pic),
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        height: 50,
                                        width: 50,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                "https://i.pinimg.com/564x/ec/e2/b0/ece2b0f541d47e4078aef33ffd22777e.jpg"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )),
                            title: Text(records[index].name),
                            onTap: () {
                              print('Student list Count =${records.length}');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StudentProfile(
                                    pname: records[index].name,
                                    pclass: records[index].grade,
                                    page: records[index].age,
                                    pdiv: records[index].div,
                                    pid: records[index].id,
                                    ppic: records[index].pic,
                                    ind: index,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemCount: records.length,
                      );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: HexColor('#111036'),
          onPressed: () {
            addSheet(context);
          },
          child: const Icon(Icons.group_add),
        ),
      ),
    );
  }
}
