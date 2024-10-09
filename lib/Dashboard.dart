import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:testsampleproject/Models/UserEntity.dart';
import 'package:testsampleproject/Models/UserFirestore.dart';
import 'package:testsampleproject/Services/UserFirestoreService.dart';
import 'package:testsampleproject/objectbox.g.dart';

class Dashboard extends StatefulWidget {
  final Store store;
  const Dashboard(this.store , {super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late final Box<UserEntity> _userBox;
  static late  UserFirestore user = UserFirestore(username: '', email: '', password: '');
  final UserFirestoreService _userFirestoreService = UserFirestoreService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userBox = widget.store.box<UserEntity>();

  }

  @override void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    try {
      String userId = ModalRoute.of(context)?.settings.arguments as String;
      print(userId);
      user = await _userFirestoreService.getUserById(userId);
    }catch(e) {
      print('error : $e' );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Column(
        children: [
          Text(
            'Hello ${user.username}  , here is your dashboard' ,
            style: const TextStyle(
                fontSize: 24 ,
                fontWeight: FontWeight.bold
            ),
          ),
          TextButton(onPressed: () => {
            Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false)
          },  child: const Text('Sign out'))
        ],
      ),
    );
  }
}