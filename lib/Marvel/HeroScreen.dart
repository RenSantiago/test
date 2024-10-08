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
                final marvelHero = heroes[index];
                return ListTile(
                  onTap: () => {
                    print(marvelHero)
                  },
                  leading:  Image.network(heroes[index].imageUrl , height: 50 ),
                  title: Text(marvelHero.name , style: TextStyle(fontSize: 18 ,fontWeight: FontWeight.bold),),
                  subtitle: Text(marvelHero.realName),
                );
              }))
        ],
      ),
    );
  }
}

