import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class StreamProviderSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
        home: MessagesScreen()
    );
  }
}

// Simulated message stream
Stream<List<String>> messageStream() async* {
  List<String> messages = [];
  int counter = 0;
  while (true) {
    await Future.delayed(Duration(seconds: 2)); // Simulate a delay for new messages
    messages.add('Message ${++counter}');

    yield messages; // Emit the current list of messages
  }
}

class MessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final messages = Provider.of<List<String>>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('User Messages'),
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(messages[index]),
          );
        },
      ),
    );
  }
}