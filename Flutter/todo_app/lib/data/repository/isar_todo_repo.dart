import 'package:isar/isar.dart';
import 'package:todo_app/data/models/isar_todo.dart';
import 'package:todo_app/domain/model/todo.dart';
import 'package:todo_app/domain/repository/todo_repo.dart';

class IsarTodoRepo implements TodoRepo {
  final Isar db;

  IsarTodoRepo(this.db);

  @override
  Future<void> createTodo(Todo newTodo) async {
    IsarTodo isarTodo = IsarTodo.fromDomain(newTodo);
    return db.writeTxn(() => db.isarTodos.put(isarTodo));
  }

  @override
  Future<void> deleteTodo(Todo todo) {
    IsarTodo isarTodo = IsarTodo.fromDomain(todo);
    return db.writeTxn(() => db.isarTodos.delete(todo.id));
  }

  @override
  Future<List<Todo>> getTodos() async {
    var todos = await db.isarTodos.where().findAll();
    return todos.map((isarTodo) => isarTodo.toDomain()).toList();
  }

  @override
  Future<void> updateTodo(Todo todo) {
    IsarTodo isarTodo = IsarTodo.fromDomain(todo);
    return db.writeTxn(() => db.isarTodos.put(isarTodo));
  }
}
