import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'TodoProvider.dart';

class TodoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      MaterialApp(
        title: 'Todo Screen',
        home: TodoContainer(),
      );
  }
}
class TodoContainer extends StatelessWidget {
  TextEditingController todoController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Consumer<TodoProvider>(
                builder: (context, todoProvider, child) {
                  return ListView.builder(
                    itemCount: todoProvider.todos.length,
                    itemBuilder: (context, index) {
                      final todo = todoProvider.todos[index];
                      return ListTile(
                        title: Text(todo.title),
                        onTap: () => {
                          todoProvider.changeStatus(index, !todo.isCompleted)
                        },
                        trailing: Checkbox(
                          value: todo.isCompleted,
                          onChanged: (value) {
                            todoProvider.changeStatus(index, value!);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller : todoController,
                      decoration: const InputDecoration(
                        labelText: 'Add a new to-do',
                      ),
                      onSubmitted: (abc) {
                        if (abc.isNotEmpty) {
                          context.read<TodoProvider>().addTodo(abc,false);
                          todoController.clear();
                        }
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      // This could be another way to add a to-do, e.g., using a dialog
                      context.read<TodoProvider>().addTodo(todoController.text,false);
                      todoController.clear();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
