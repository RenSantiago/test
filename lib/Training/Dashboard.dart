import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testsampleproject/Training/Models/Todo.dart';
import 'package:testsampleproject/Training/Providers/Todo.dart';
import 'package:testsampleproject/Training/Todo/TodoProvider.dart';



class Dashboard extends ConsumerWidget {



  @override
  Widget build(BuildContext context ,WidgetRef ref) {
    final todos = ref.watch(todoProvider);
    final TextEditingController todoController = TextEditingController();


    void handleAddTodo () {
      String todo = todoController.text;
      if(todo.isNotEmpty) {
        ref.read(todoProvider.notifier).addTodo(todo);
        todoController.clear();
      }

    }

    void handleRemoveTodo(int index) {
        print(index);
        ref.read(todoProvider.notifier).removeTodo(index);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20) ,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: TextField(
                    controller: todoController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)
                      ) ,
                      labelText: 'Add Todo',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5) ,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const CircleBorder() ,
                        backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white
                    ),
                    onPressed: handleAddTodo,
                    child: Text('+')),
                )
              ],
            ),
            Expanded(

                child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: todos.length,
                    itemBuilder: (_ , index) {
                      return ListTile(
                        title: Text(todos[index]),
                        trailing: IconButton(
                            onPressed: () {
                              handleRemoveTodo(index);
                            },
                            icon: Icon(Icons.close)),
                      );
                    })
            ),
          ],
        )
      ),
    );
  }
}