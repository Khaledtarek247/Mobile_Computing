import 'package:flutter/foundation.dart';
import '../../data/models/todo_model.dart';

/// Provider class for managing Todo state
/// Implements ChangeNotifier for reactive state management
class TodoProvider extends ChangeNotifier {
  final List<TodoModel> _todos = [];

  /// Returns an unmodifiable list of all todos
  List<TodoModel> get todos => List.unmodifiable(_todos);

  /// Returns the count of total todos
  int get todoCount => _todos.length;

  /// Returns the count of completed todos
  int get completedCount => _todos.where((todo) => todo.isCompleted).length;

  /// Returns the count of pending todos
  int get pendingCount => _todos.where((todo) => !todo.isCompleted).length;

  /// Adds a new todo to the list
  ///
  /// [title] must not be empty or whitespace-only
  /// Returns true if the todo was added successfully, false otherwise
  bool addTodo(String title) {
    // Validate input
    final trimmedTitle = title.trim();
    if (trimmedTitle.isEmpty) {
      return false;
    }

    // Create new todo with unique ID
    final newTodo = TodoModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: trimmedTitle,
    );

    _todos.insert(0, newTodo); // Add to the beginning of the list
    notifyListeners();
    return true;
  }

  /// Deletes a todo by its ID
  ///
  /// Returns true if the todo was found and deleted, false otherwise
  bool deleteTodo(String id) {
    final initialLength = _todos.length;
    _todos.removeWhere((todo) => todo.id == id);

    if (_todos.length < initialLength) {
      notifyListeners();
      return true;
    }
    return false;
  }

  /// Toggles the completion status of a todo
  ///
  /// Returns true if the todo was found and toggled, false otherwise
  bool toggleTodoStatus(String id) {
    try {
      final index = _todos.indexWhere((todo) => todo.id == id);

      if (index == -1) {
        return false;
      }

      _todos[index] = _todos[index].copyWith(
        isCompleted: !_todos[index].isCompleted,
      );

      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Error toggling todo status: $e');
      return false;
    }
  }

  /// Updates the title of a todo
  ///
  /// Returns true if the todo was found and updated, false otherwise
  bool updateTodoTitle(String id, String newTitle) {
    final trimmedTitle = newTitle.trim();
    if (trimmedTitle.isEmpty) {
      return false;
    }

    try {
      final index = _todos.indexWhere((todo) => todo.id == id);

      if (index == -1) {
        return false;
      }

      _todos[index] = _todos[index].copyWith(title: trimmedTitle);
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Error updating todo title: $e');
      return false;
    }
  }

  /// Clears all completed todos
  void clearCompleted() {
    _todos.removeWhere((todo) => todo.isCompleted);
    notifyListeners();
  }

  /// Clears all todos
  void clearAll() {
    _todos.clear();
    notifyListeners();
  }
}
