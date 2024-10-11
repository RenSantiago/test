import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FutureProviderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider<UserProfile>(
          create: (context) => fetchUserProfile(),
          initialData: UserProfile(name: 'Ranjith',
              email: 'good@email.com'), //some inital value
        ),
      ],
      child: MyApp(),
    );
  }
}


// Simulated API call
Future<UserProfile> fetchUserProfile() async {
  // Simulate network delay
  await Future.delayed(Duration(seconds: 4));
  return UserProfile(name: "Shiela", email: "Shiela@example.com");
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserProfileScreen(),
    );
  }
}


class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProfile = Provider.of<UserProfile>(context);


    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Center(
        child: userProfile == null
            ? CircularProgressIndicator() // Show loading indicator while fetching
            : Text('Name: ${userProfile.name}\nEmail: ${userProfile.email}'),
      ),
    );
  }
}


class UserProfile {
  final String name;
  final String email;


  UserProfile({required this.name, required this.email});
}

