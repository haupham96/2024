import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  TodoTile({
    super.key,
    required this.taskName,
    required this.isDone,
    required this.onChanged,
    required this.onDeleteTask,
  });

  final String taskName;
  final bool isDone;
  final Function(bool?)? onChanged;
  Function(BuildContext?)? onDeleteTask;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.3,
        motion: ScrollMotion(),
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 15),
              child: SlidableAction(
                borderRadius: BorderRadius.circular(12),
                backgroundColor: Colors.red.shade300,
                icon: Icons.delete,
                onPressed: onDeleteTask,
              ),
            ),
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(
            color: Colors.lightBlue[100],
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            // checkbox
            Checkbox(
                value: isDone,
                onChanged: onChanged,
                activeColor: Colors.blueAccent),

            // task name
            Text(
              taskName,
              style: TextStyle(
                  decoration: isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none),
            ),
          ],
        ),
      ),
    );
  }
}
