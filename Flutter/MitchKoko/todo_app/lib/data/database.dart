import 'package:hive_flutter/hive_flutter.dart';

class TodoDataBase {
  List todoList = [];

// ref to the box
  final _mybox = Hive.box('mybox');

  void init() {
    todoList = [
      ["Go to the ATM", false],
      ["Go running for 30 minutes", false],
      ["Learning Flutter", false],
    ];
  }

  void loadData() {
    todoList = _mybox.get("TODO");
  }

  void updateData() {
    _mybox.put("TODO", todoList);
  }
}
