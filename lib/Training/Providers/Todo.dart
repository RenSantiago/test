
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testsampleproject/Training/Models/Todo.dart';

final todoProvider = StateNotifierProvider<Todo , List<String>>((ref) {
  return Todo();
});