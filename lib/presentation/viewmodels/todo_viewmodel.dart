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
    if (isLoading) return; // Evitar múltiples cargas simultáneas
    
    isLoading = true;
    error = null;
    notifyListeners();
    
    try {
      final fetchedTodos = await _repo.fetchTodos();
      todos = fetchedTodos;
      print('Loaded ${todos.length} todos'); // Debug
    } catch (e) {
      error = 'No se pudo cargar las tareas: $e';
      print('Error loading todos: $e'); // Debug
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
      
      print('Creating todo: ${newTodo.toJson()}'); // Debug
      
      final created = await _repo.createTodo(newTodo);
      todos.insert(0, created);
      
      print('Created todo with ID: ${created.id}'); // Debug
      notifyListeners();
    } catch (e) {
      error = 'Error al crear tarea: $e';
      notifyListeners();
      print('Error creating todo: $e'); // Debug
    }
  }

  Future<void> toggleTodo(TodoModel todo) async {
    try {
      error = null;
      final updatedTodo = todo.copyWith(completed: !todo.completed);
      
      // Actualizar inmediatamente en la UI para mejor UX
      final idx = todos.indexWhere((t) => t.id == todo.id);
      if (idx != -1) {
        todos[idx] = updatedTodo;
        notifyListeners();
      }
      
      // Luego sincronizar con el servidor
      await _repo.updateTodo(updatedTodo);
    } catch (e) {
      error = 'Error al cambiar estado de tarea: $e';
      // Revertir cambio en caso de error
      final idx = todos.indexWhere((t) => t.id == todo.id);
      if (idx != -1) {
        todos[idx] = todo;
      }
      notifyListeners();
      print('Error toggling todo: $e'); // Debug
    }
  }

  Future<void> removeTodo(TodoModel todo) async {
    try {
      error = null;
      
      // Remover inmediatamente de la UI
      final originalIndex = todos.indexOf(todo);
      todos.remove(todo);
      notifyListeners();
      
      // Luego eliminar del servidor
      if (todo.id != null) {
        await _repo.deleteTodo(todo.id!);
        print('Deleted todo with ID: ${todo.id}'); // Debug
      }
    } catch (e) {
      error = 'Error al eliminar tarea: $e';
      // Revertir cambio en caso de error
      final originalIndex = todos.length;
      todos.insert(originalIndex, todo);
      notifyListeners();
      print('Error deleting todo: $e'); // Debug
    }
  }
  
  // Método para limpiar errores
  void clearError() {
    error = null;
    notifyListeners();
  }
  
  // Getters útiles
  int get completedCount => todos.where((t) => t.completed).length;
  int get pendingCount => todos.where((t) => !t.completed).length;
  int get totalCount => todos.length;
}