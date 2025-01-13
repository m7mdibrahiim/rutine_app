import 'package:flutter/material.dart';
import 'package:rutine_app/models/todo_item_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoProvider extends ChangeNotifier {
  List<TodoItem> _todoItems = [];
  String _filter = 'All';
  final GlobalKey<AnimatedListState> _animatedListKey =
      GlobalKey<AnimatedListState>();

  TodoProvider() {
    _loadTodoItems();
  }

  GlobalKey<AnimatedListState> get animatedListKey => _animatedListKey;
  List<TodoItem> get todoItems => _todoItems;
  String get filter => _filter;

  List<TodoItem> get filteredItems {
    if (_filter == 'All') return _todoItems;
    if (_filter == 'Completed') {
      return _todoItems.where((item) => item.isCompleted).toList();
    }
    if (_filter == 'Incomplete') {
      return _todoItems.where((item) => !item.isCompleted).toList();
    }
    return _todoItems;
  }

  Future<void> _loadTodoItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? todoStrings = prefs.getStringList('todos');
    if (todoStrings != null) {
      _todoItems = todoStrings.map((item) => TodoItem.fromJson(item)).toList();
    }
    notifyListeners();
  }

  Future<void> _saveTodoItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> todoStrings = _todoItems.map((item) => item.toJson()).toList();
    await prefs.setStringList('todos', todoStrings);
  }

  void addTodoItem(String task, String category) {
    final newItem = TodoItem(task: task, category: category);
    _todoItems.insert(0, newItem);
    _animatedListKey.currentState
        ?.insertItem(0, duration: const Duration(milliseconds: 500));
    _saveTodoItems();
    notifyListeners();
  }

  void deleteTodoItem(TodoItem item) {
    final index = _todoItems.indexOf(item);
    _todoItems.removeAt(index);
    _animatedListKey.currentState?.removeItem(
      index,
      (context, animation) => _buildDeletedItem(item, animation),
      duration: const Duration(milliseconds: 500),
    );
    _saveTodoItems();
    notifyListeners();
  }

  void toggleTodoItem(TodoItem item) {
    item.isCompleted = !item.isCompleted;
    _saveTodoItems();
    notifyListeners();
  }

  void setFilter(String filter) {
    _filter = filter;
    notifyListeners();
  }

  Widget _buildDeletedItem(TodoItem item, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: ListTile(
        title: Text(
          item.task,
          style: TextStyle(
            decoration: item.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(item.category),
        trailing: const Icon(Icons.delete),
      ),
    );
  }

  void updateTodoItem(TodoItem item, String newTask, String newCategory) {
    final index = _todoItems.indexOf(item);
    if (index != -1) {
      _todoItems[index].task = newTask;
      _todoItems[index].category = newCategory;
      _saveTodoItems();
      notifyListeners();
    }
  }
}
