import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testsampleproject/Login/login_bloc.dart';
import 'package:testsampleproject/Login/login_ui.dart';
import 'package:testsampleproject/Registration/registration_bloc.dart';
import 'package:testsampleproject/Registration/registration_ui.dart';
import 'package:testsampleproject/TimeTracker/TimeTracker_bloc.dart';
import 'package:testsampleproject/TimeTracker/TimeTracker_ui.dart';
import 'package:testsampleproject/Training/Animation/AnimationScreen.dart';
import 'package:testsampleproject/Training/ImageUpload/ImageUpload.dart';
import 'package:testsampleproject/firebase_options.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true
  );
  runApp(App());

}
class App extends StatelessWidget {

  const App({super.key });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
          BlocProvider<RegistrationBloc>(create: (_) => RegistrationBloc()),
          BlocProvider<TimeTrackerBloc>(create: (_) => TimeTrackerBloc())
    ],
        child: MaterialApp(
      title: 'super app',
      home: TimeTrackerPage(),
      initialRoute: '/dashboard',
      routes: {
        '/login' : (context) =>  LoginScreen(),
        '/signup' : (_) => RegistrationScreen(),
        '/dashboard' : (context) => TimeTrackerPage(),
        '/image' : (context) => ImageUploadScreen(),
        '/animation' : (context) => AnimationScreen()
      },
    )
    );
  }
}