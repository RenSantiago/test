import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testsampleproject/AwesomeSignunp.dart';
import 'package:testsampleproject/Dashboard.dart';
import 'package:testsampleproject/Login.dart';
import 'package:testsampleproject/Marvel/HeroScreen.dart';
import 'package:testsampleproject/Marvel/hero.dart';
import 'package:testsampleproject/Todo/TodoProvider.dart';
import 'package:testsampleproject/objectbox.dart';
import 'package:testsampleproject/objectbox.g.dart';

void main() async{
  // runApp(MultiProvider(
  //     providers: [
  //     ChangeNotifierProvider(
  //       create: (context) => TodoProvider()
  //       ),
  //       FutureProvider<List<MarvelHero>>(
  //           create: (context) => getHeroes(),
  //           initialData: const [])
  //     ],
  //   child: const HeroScreen(),
  //   )
  // );

  WidgetsFlutterBinding.ensureInitialized();
  final store = await openStore();
  await Future.delayed(const Duration(milliseconds: 300));
  runApp(App(store));

}
class App extends StatelessWidget {
  final Store store;

  const App(this.store , {super.key });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'super app',
      home: LoginState(store),
      initialRoute: '/login',
      routes: {
        '/login' : (context) =>  LoginState(store),
        '/signup' : (context) => AwesomeSignUpPage(store),
        '/dashboard' : (context) => Dashboard(store)
      },
    );
  }
}
//
// class SimpleHomePage extends StatelessWidget {
//   const SimpleHomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Basics',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
//         useMaterial3: false,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('TITLE HERE'),
//
//         ),
//         body: const Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Text('NEW TEXT') ,
//             Text('2nd text'),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('row text'),
//                 Text('new row text')
//               ],
//             )
//           ],
//         ),
//       )
//     );
//   }
// }
//
// class NewContainer extends StatelessWidget {
//   const NewContainer({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Flutter Basics',
//         home: Scaffold(
//           appBar: AppBar(title: const Text('Flutter Basics'),),
//           body: Center(
//             child: Container(
//               height: 200,
//               width: 200 ,
//               decoration: const BoxDecoration(
//                   color: Colors.blue,
//                   borderRadius: BorderRadius.all(Radius.circular(10))
//               ),
//               child: const Center(
//                 child: Text(
//                   'test here' ,
//                   style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.white),),
//               ),
//             ),
//           ),
//         )
//     );
//   }
// }
//
// class NewList extends StatelessWidget {
//   const NewList({super.key});
//
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return MaterialApp(
//       title: 'List Page',
//       home : Scaffold(
//         appBar: AppBar(
//           title: const Text('List Page'),
//         ),
//         body: ListView(
//           children: const [
//             ListTile(
//               title: Text('help'),
//             ),
//             ListBody()
//           ],
//         ),
//       )
//     );
//     throw UnimplementedError();
//   }
// }
//
// class MyListApp extends StatelessWidget {
//   final List<String> items = List.generate(10, (index) => 'Item $index');
//
//   MyListApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text('ListView Example')),
//         body: ListView.builder(
//           itemCount: items.length,
//           itemBuilder: (context, index) {
//             return ListTile(
//               title: Text(items[index]),
//               leading: const Icon(Icons.check),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class MyGridApp extends StatelessWidget {
//   const MyGridApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text('GridView Example')),
//         body: GridView.count(
//           crossAxisCount: 3, // 2 items per row
//           children: List.generate(6, (index) {
//             return Card(
//               margin: const EdgeInsets.all(10),
//               child: Center(child: Text('Item $index')),
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }
//
// class MyButtonApp extends StatelessWidget {
//   const MyButtonApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text('Button Example')),
//         body: Center(
//           child: ElevatedButton(
//             onPressed: () {
//               print('Button Pressed!!!!');
//             },
//             child: const Text('Press Me'),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class MyFormApp extends StatelessWidget {
//   const MyFormApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text('TextField Example')),
//         body:const Padding(
//           padding: EdgeInsets.all(16.0),
//           child: TextField(
//             decoration: InputDecoration(labelText: 'Enter your name'),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class TodayTest extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Today Test',
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Today Test' , style: TextStyle(
//             fontSize: 18,
//
//           ),),
//         ),
//       ),
//     );
//   }
//
// }


// class _MyAppState extends State<SimpleFunctionality> {
//   String enteredText = ""; // To store the text from the TextField
//   TextEditingController textController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('TextField Example'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center, // Center the content vertically
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: TextField(
//                   controller: textController, // Capture the input
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Enter something',
//                   ),
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     enteredText = textController.text; // Update the text when button is pressed
//                   });
//                 },
//                 child: Text('Show Text'),
//               ),
//               SizedBox(height: 20), // Add some space
//               Text(
//                 enteredText, // Display the entered text
//                 style: TextStyle(fontSize: 24),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
