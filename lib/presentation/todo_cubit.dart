import 'package:todoblocapp/domain/models/todo.dart';
import 'package:todoblocapp/domain/repository/todo_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoCubit extends Cubit<List<Todo>>{
  final TodoRepo todoRepo;

  TodoCubit(this.todoRepo) : super([]){
    loadTodos();
  }

  Future<void> loadTodos() async {
    final todoList = await todoRepo.getTodo();

    emit(todoList);
  }

  Future<void> addTodo(String text) async {
    final newTodo = Todo(id: DateTime.now().millisecondsSinceEpoch, text: text);
    await todoRepo.addTodo(newTodo);
    loadTodos();

  }
  Future<void> deleteTodo(Todo todo) async {
    await todoRepo.deleteTodo(todo);
    loadTodos();
  }
  Future<void> toggleCompletion(Todo todo) async {
    final updatedTodo = todo.toggleCompletion();

    await todoRepo.updateTodo(updatedTodo);

    loadTodos();
  }

}