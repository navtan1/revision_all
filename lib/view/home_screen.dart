import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final taskName = TextEditingController();

  Box<String>? todoBox;

  @override
  void initState() {
    todoBox = Hive.box<String>("todo");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Column(
                  children: [
                    Text('Add Task'),
                    TextField(
                      controller: taskName,
                      decoration: InputDecoration(hintText: 'task'),
                    )
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                      taskName.clear();
                    },
                    child: Text("cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      todoBox!.put("${Random().nextInt(1000)}", taskName.text);
                      Get.back();
                      taskName.clear();
                    },
                    child: Text("Add Task"),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      body: ValueListenableBuilder(
        valueListenable: todoBox!.listenable(),
        builder: (BuildContext context, Box<String> todos, _) {
          return ListView.builder(
            itemCount: todos.keys.length,
            itemBuilder: (context, index) {
              final key = todos.keys.toList()[index];
              final value = todos.get(key);
              return ListTile(
                title: Text(value!),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Column(
                                children: [
                                  Text("Update Task"),
                                  TextField(
                                    controller: taskName,
                                    decoration:
                                        InputDecoration(hintText: 'task'),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                    taskName.clear();
                                  },
                                  child: Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    todoBox!.put("$key", taskName.text);
                                    Get.back();
                                    taskName.clear();
                                  },
                                  child: Text("Update"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Delete Task"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text("no"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    todoBox!.delete("$key");
                                    Get.back();
                                  },
                                  child: Text("yes"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
