import 'package:flutter/foundation.dart';

import 'Todo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'TodoScreen.dart';

class TodoProvider with ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  void addTodo(String title, bool ck) {
    _todos.add(Todo(title: title));
    notifyListeners();
  }
  void changeStatus(int index, bool completed) {
    _todos[index].isCompleted = completed;
    notifyListeners();
  }

}
