import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Todo extends StateNotifier<List<String>> {
    Todo() : super([]);

  void addTodo(String todo) {
    state = [...state , todo];
  }

  void removeTodo(int index) {
    state.removeAt(index);
    state = [...state];
  }
}