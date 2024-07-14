import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/util/dialog_box.dart';

import '../util/todo_tile.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference to the box
  final _myBox = Hive.box('mybox');
  TodoDataBase db = TodoDataBase();

  final TextEditingController controller = TextEditingController();

  // show dialog
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) => DialogBox(
              controller: controller,
              onCancel: () => Navigator.of(context).pop(),
              onSave: saveNewTask,
            ));
  }

  // delete task
  void deleteTask(int i) {
    setState(() {
      db.todoList.removeAt(i);
    });
    db.updateData();
  }

  // save the task.
  void saveNewTask() {
    setState(() {
      db.todoList.add([controller.text, false]);
    });
    db.updateData();
    controller.clear();
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    if (_myBox.get("TODO") == null) {
      db.init();
    } else {
      db.loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0,
          title: Center(
              child: Text(
            'Todo Tasks',
            style: TextStyle(color: Colors.white),
          )),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          child: Icon(Icons.add),
        ),
        body: ListView.builder(
            itemCount: db.todoList.length,
            itemBuilder: (ctx, i) => TodoTile(
                  taskName: db.todoList[i][0],
                  isDone: db.todoList[i][1],
                  onChanged: (value) => {
                    setState(() {
                      db.todoList[i][1] = !db.todoList[i][1];
                      db.updateData();
                    })
                  },
                  onDeleteTask: (context) => deleteTask(i),
                )));
  }
}
