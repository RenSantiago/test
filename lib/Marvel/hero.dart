import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testsampleproject/Marvel/hero.dart';

class MarvelHero {
  final String name;
  final String realname;
  final String imageurl;

  MarvelHero({required this.name ,required this.realname , required this.imageurl});

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
              realname: hero['realname'] ,
              imageurl: hero['imageurl']));
    }
    return _marvelHero;
  }

  return [];

}
