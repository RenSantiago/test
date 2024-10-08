import 'dart:convert';
import 'package:http/http.dart' as http;


class MarvelHero {
  final String name;
  final String realName;
  final String imageUrl;

  MarvelHero({required this.name ,required this.realName , required this.imageUrl});

}

String heroURL = 'https://simplifiedcoding.net/demos/marvel/';

Future<List<MarvelHero>> getHeroes() async  {
  final response = await http.get(Uri.parse(heroURL));
  final List<MarvelHero> _marvelHero = [];
  if(response.statusCode == 200) {
    final data = json.decode(response.body);
    for(dynamic hero in data) {
      _marvelHero.add(
          MarvelHero(
              name: hero['name'] ,
              realName: hero['realname'] ,
              imageUrl: hero['imageurl']));
    }
    return _marvelHero;
  }

  return [];

}
