import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/domain/model/todo.dart';
import 'package:todo_app/domain/repository/todo_repo.dart';

class TodoCubit extends Cubit<List<Todo>> {
  final TodoRepo todoRepo;

  TodoCubit(this.todoRepo) : super([]) {
    loadTodos();
  }

  Future<void> loadTodos() async {
    final todoList = await todoRepo.getTodos();

    // emit todo_list as a new state
    emit(todoList);
  }

  Future<void> addTodo(String text) async {
    final newTodo = Todo(id: DateTime.now().microsecondsSinceEpoch, text: text);
    await todoRepo.createTodo(newTodo);
    loadTodos();
  }
  
  Future<void> deleteTodo(Todo todo) async {
    await todoRepo.deleteTodo(todo);
    loadTodos();
  }
  
  Future<void> toggleComplete(Todo todo) async {
    final updateTodo = todo.toggleCompletion();
    await todoRepo.updateTodo(updateTodo);
    loadTodos();
  }
}
