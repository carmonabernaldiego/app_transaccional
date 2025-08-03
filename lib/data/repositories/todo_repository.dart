import 'package:dio/dio.dart';
import '../../domain/models/todo_model.dart';
import '../../core/network/task_api_client.dart';

class TodoRepository {
  final TaskApiClient _client = TaskApiClient();

  Future<List<TodoModel>> fetchTodos() async {
    final resp = await _client.get('/tasks/');
    return (resp.data as List)
        .map((e) => TodoModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<TodoModel> createTodo(TodoModel todo) async {
    final resp = await _client.post('/tasks/', data: todo.toJson());
    return TodoModel.fromJson(resp.data as Map<String, dynamic>);
  }

  Future<void> updateTodo(TodoModel todo) async {
    await _client.patch('/tasks/${todo.id}', data: todo.toJson());
  }

  Future<void> deleteTodo(int id) async {
    await _client.delete('/tasks/$id');
  }
}
