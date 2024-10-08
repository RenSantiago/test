import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testsampleproject/Marvel/hero.dart';

class HeroScreen extends StatelessWidget{
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
   final  heroes = Provider.of<List<MarvelHero>>(context);

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Heroes'),
      ),
      body: Column(
        children: [
          Expanded(child: ListView.builder(
              itemCount: heroes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.network(heroes[index].imageurl , height: 50 ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(heroes[index].name!),
                          Text(heroes[index].realname , style: TextStyle(fontSize: 10),)
                        ],
                      )
                    ],
                  ),

                );
              }))
        ],
      ),
    );
  }
}

