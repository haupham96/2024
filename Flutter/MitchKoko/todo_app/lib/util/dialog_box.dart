import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/util/my_button.dart';

class DialogBox extends StatelessWidget {

  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  DialogBox({required this.controller, required this.onSave, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                    labelText: 'Task name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        gapPadding: 10
                    ),
                    hintText: 'Input Task name...'),
              ),
            ),

            // two buttons.
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(text: 'Cancel', onPressed: onCancel),
                SizedBox(width: 5),
                MyButton(text: 'Save', onPressed: onSave),
              ],
            )
          ],
        ),
      ),
    );
  }
}
