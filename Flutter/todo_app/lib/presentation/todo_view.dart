import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/domain/model/todo.dart';
import 'package:todo_app/presentation/todo_cubit.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  void _showAddTodoBox(BuildContext context) {
    TodoCubit todoCubit = context.read<TodoCubit>();
    TextEditingController textController = TextEditingController();
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(controller: textController),
              actions: [
                // cancel
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("Cancel")),
                // add
                TextButton(
                    onPressed: () {
                      todoCubit.addTodo(textController.text);
                      Navigator.of(context).pop();
                    },
                    child: const Text("Add"))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final TodoCubit todoCubit = context.read<TodoCubit>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showAddTodoBox(context),
      ),
      body: BlocBuilder<TodoCubit, List<Todo>>(
        builder: (context, todos) {
          // return list view to scroll all todos
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return ListTile(
                // text
                title: Text(todo.text),
                // checkbox
                leading: Checkbox(
                  value: todo.isComplete,
                  onChanged: (value) => todoCubit.toggleComplete(todo),
                ),
                //delete button
                trailing: IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () => todoCubit.deleteTodo(todo),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
