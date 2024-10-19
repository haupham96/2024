import 'package:todo_app/domain/model/todo.dart';

abstract class TodoRepo {
  Future<List<Todo>> getTodos();

  Future<void> createTodo(Todo newTodo);

  Future<void> updateTodo(Todo todo);

  Future<void> deleteTodo(Todo todo);
}
