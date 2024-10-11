import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FetchDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Data Fetch',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Get Data from API'),
        ),
        body: DataFromApi(),
      ),
    );
  }
}
class DataFromApi extends StatefulWidget {
  @override
  _DataFromApiState createState() => _DataFromApiState();
}

class _DataFromApiState extends State<DataFromApi> {
  String data = 'Fetching data...';
  @override
  void initState() {
    super.initState();
    fetchData();
  }
// Fetch data from an API
  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
    if (response.statusCode == 200) {
      // If server returns a successful response, parse the JSON
      final jsonData = json.decode(response.body);
      setState(() {
        data = jsonData['title'];  // Update the state with fetched data
      });
    } else {
      setState(() {
        data = 'Failed to load data';
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(data),  // Display fetched data
    );
  }
}