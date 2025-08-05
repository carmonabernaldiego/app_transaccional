import 'package:flutter/material.dart';
import '../../data/repositories/todo_repository.dart';
import '../../domain/models/todo_model.dart';

class TodoViewModel extends ChangeNotifier {
  final _repo = TodoRepository();
  List<TodoModel> todos = [];
  bool isLoading = false;
  String? error;

  Future<void> updateTask(TodoModel updated) async {
    try {
      error = null;
      notifyListeners();
      
      await _repo.updateTodo(updated);
      final idx = todos.indexWhere((t) => t.id == updated.id);
      if (idx != -1) {
        todos[idx] = updated;
        notifyListeners();
      }
    } catch (e) {
      error = 'Error al actualizar tarea: $e';
      notifyListeners();
      print('Error updating task: $e');
    }
  }

  Future<void> loadTodos() async {
    if (isLoading) return;
    
    isLoading = true;
    error = null;
    notifyListeners();
    
    try {
      final fetchedTodos = await _repo.fetchTodos();
      todos = fetchedTodos;
      print('Loaded ${todos.length} todos');
    } catch (e) {
      error = 'No se pudo cargar las tareas: $e';
      print('Error loading todos: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addTodo(String title) async =>
      addTodoWithDesc(title, null);

  Future<void> addTodoWithDesc(String title, String? desc, {DateTime? dueDate}) async {
    try {
      error = null;
      notifyListeners();
      
      final newTodo = TodoModel(
        title: title,
        description: desc,
        dueDate: dueDate?.toIso8601String(),
      );
      
      print('Creating todo: ${newTodo.toJson()}');
      
      final created = await _repo.createTodo(newTodo);
      todos.insert(0, created);
      
      print('Created todo with ID: ${created.id}');
      notifyListeners();
    } catch (e) {
      error = 'Error al crear tarea: $e';
      notifyListeners();
      print('Error creating todo: $e');
    }
  }

  Future<void> toggleTodo(TodoModel todo) async {
    try {
      error = null;
      final updatedTodo = todo.copyWith(completed: !todo.completed);
      final idx = todos.indexWhere((t) => t.id == todo.id);
      if (idx != -1) {
        todos[idx] = updatedTodo;
        notifyListeners();
      }
      
      await _repo.updateTodo(updatedTodo);
    } catch (e) {
      error = 'Error al cambiar estado de tarea: $e';
      final idx = todos.indexWhere((t) => t.id == todo.id);
      if (idx != -1) {
        todos[idx] = todo;
      }
      notifyListeners();
      print('Error toggling todo: $e');
    }
  }

  Future<void> removeTodo(TodoModel todo) async {
    try {
      error = null;
      
      final originalIndex = todos.indexOf(todo);
      todos.remove(todo);
      notifyListeners();
      
      if (todo.id != null) {
        await _repo.deleteTodo(todo.id!);
        print('Deleted todo with ID: ${todo.id}');
      }
    } catch (e) {
      error = 'Error al eliminar tarea: $e';
      final originalIndex = todos.length;
      todos.insert(originalIndex, todo);
      notifyListeners();
      print('Error deleting todo: $e');
    }
  }
  
  void clearError() {
    error = null;
    notifyListeners();
  }
  
  int get completedCount => todos.where((t) => t.completed).length;
  int get pendingCount => todos.where((t) => !t.completed).length;
  int get totalCount => todos.length;
}