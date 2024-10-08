import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testsampleproject/Marvel/hero.dart';

class HeroScreen extends StatelessWidget{
  const HeroScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return MaterialApp(
      title: 'Heroes',
      home: HeroList(),
    );
  }
}

class HeroList extends StatefulWidget {
  @override
  State<HeroList> createState() => _HeroListState();
}

class _HeroListState extends State<HeroList> {

  @override
  Widget build(BuildContext context) {
   final heroes = Provider.of<List<MarvelHero>>(context);

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Heroes'),
      ),
      body: heroes.isEmpty ?
      const Center(
        child: CircularProgressIndicator(),
      ) :
      Column(
        children: [
          Expanded(child: ListView.builder(
              itemCount: heroes.length,
              itemBuilder: (context, index) {
                return ListBody(
                  children: [
                   Padding(
                       padding: EdgeInsets.all(10) ,
                       child:  Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       Image.network(heroes[index].imageUrl , height: 50 ),
                       const SizedBox(width: 20),
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(
                               heroes[index].name ,
                               style: const TextStyle(
                                   fontSize: 18 ,
                                   fontWeight: FontWeight.bold)),
                           Text(
                             heroes[index].realName ,
                             style: const TextStyle(fontSize: 10),)
                         ],
                       )
                     ],
                   ),)
                  ],
                );
              }))
        ],
      ),
    );
  }
}

