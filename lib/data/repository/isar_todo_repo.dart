import 'package:isar/isar.dart';
import 'package:todoblocapp/data/models/isar_todo.dart';
import 'package:todoblocapp/domain/models/todo.dart';
import 'package:todoblocapp/domain/repository/todo_repo.dart';

class IsarTodoRepo implements TodoRepo {

  final Isar db;

  IsarTodoRepo(this.db);

  @override
  Future<void> addTodo(Todo newTodo) async{
    // TODO: implement addTodo
    final todoIsar = TodoIsar.fromDomain(newTodo);

    
    return db.writeTxn(() => db.todoIsars.put(todoIsar));
  }

  @override
  Future<void> deleteTodo(Todo todo) async {
    await db.writeTxn( () => db.todoIsars.delete(todo.id));

  }

  @override
  Future<List<Todo>> getTodo() async {
    // TODO: implement getTodo
    final todos = await db.todoIsars.where().findAll();
    return todos.map((todoIsar) => todoIsar.toDomain()).toList();
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    final todoIsar = TodoIsar.fromDomain(todo);
    return db.writeTxn(() => db.todoIsars.put(todoIsar));
  }
  
}