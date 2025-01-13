import 'dart:convert';

class TodoItem {
  String task;
  String category;
  bool isCompleted;

  TodoItem(
      {required this.task, required this.category, this.isCompleted = false});

  String toJson() {
    return jsonEncode(
        {'task': task, 'category': category, 'isCompleted': isCompleted});
  }

  static TodoItem fromJson(String json) {
    Map<String, dynamic> data = jsonDecode(json);
    return TodoItem(
      task: data['task'],
      category: data['category'],
      isCompleted: data['isCompleted'],
    );
  }
}
