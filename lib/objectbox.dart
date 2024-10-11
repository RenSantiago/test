import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'objectbox.g.dart'; // Generated code
import 'Training/MyGate.dart'; // Assuming you saved your MyGate class in this file


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final store = await openStore();
  runApp(ObjectBoxApp(store));
}


class ObjectBoxApp extends StatelessWidget {
  final Store store;


  ObjectBoxApp(this.store);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(store),
    );
  }
}


class HomePage extends StatefulWidget {
  final Store store;


  HomePage(this.store);


  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _searchController = TextEditingController();
  String _statusMessage = '';


  late final Box<MyGate> _personBox;


  @override
  void initState() {
    super.initState();
    _personBox = widget.store.box<MyGate>();
  }


  void _saveData() {
    final name = _nameController.text;
    final location = _locationController.text;


    if (name.isEmpty || location.isEmpty) {
      setState(() {
        _statusMessage = 'Name and Location cannot be empty';
      });
      return;
    }


    final person = MyGate(name: name, location: location);
    _personBox.put(person);


    setState(() {
      _statusMessage = 'Data saved';
      _nameController.clear();
      _locationController.clear();
    });
  }


  void _fetchLocation() {
    final name = _searchController.text;
    if (name.isEmpty) {
      setState(() {
        _statusMessage = 'Name cannot be empty';
      });
      return;
    }


    final query = _personBox.query(MyGate_.name.equals(name)).build();
    final persons = query.find();
    if (persons.isNotEmpty) {
      setState(() {
        _statusMessage = 'Location: ${persons.first.location}';
      });
    } else {
      setState(() {
        _statusMessage = 'Person not found';
      });
    }
    query.close(); // Close the query when done
  }


  void _updateLocation() {
    final name = _searchController.text;
    final newLocation = _locationController.text;


    if (name.isEmpty || newLocation.isEmpty) {
      setState(() {
        _statusMessage = 'Name and new Location cannot be empty';
      });
      return;
    }


    final query = _personBox.query(MyGate_.name.equals(name)).build();
    final persons = query.find();
    if (persons.isNotEmpty) {
      final person = persons.first;
      person.location = newLocation;
      _personBox.put(person);


      setState(() {
        _statusMessage = 'Location updated';
        _locationController.clear();
      });
    } else {
      setState(() {
        _statusMessage = 'Person not found';
      });
    }
    query.close(); // Close the query when done
  }


  void _deleteData() {
    final name = _searchController.text;
    if (name.isEmpty) {
      setState(() {
        _statusMessage = 'Name cannot be empty';
      });
      return;
    }


    final query = _personBox.query(MyGate_.name.equals(name)).build();
    final persons = query.find();
    if (persons.isNotEmpty) {
      _personBox.remove(persons.first.id);


      setState(() {
        _statusMessage = 'Data deleted';
        _searchController.clear();
      });
    } else {
      setState(() {
        _statusMessage = 'Person not found';
      });
    }
    query.close(); // Close the query when done
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ObjectBox CRUD Example')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: _saveData, child: Text('Save')),
                ElevatedButton(onPressed: _fetchLocation, child: Text('Fetch')),
                ElevatedButton(onPressed: _updateLocation, child: Text('Update')),
                ElevatedButton(onPressed: _deleteData, child: Text('Delete')),
              ],
            ),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(labelText: 'Search Name'),
            ),
            SizedBox(height: 20),
            Text(_statusMessage),
          ],
        ),
      ),
    );
  }
}

