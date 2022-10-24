// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
part 'PeopleStarWartModel.g.dart';
Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

@HiveType(typeId: 0)
class Welcome extends HiveObject{
    Welcome({
        this.count,
        this.next,
        this.previous,
        this.results,
    });
    @HiveField(0)
    int? count;
    @HiveField(1)
    String? next;
    @HiveField(2)
    String? previous;
    @HiveField(3)
    List<Result>? results;

    

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
    };
    Welcome get getWelcome =>  getWelcome;
}
@HiveType(typeId: 1)
class Result extends HiveObject{
    Result({
        this.name,
        this.height,
        this.mass,
        this.hairColor,
        this.skinColor,
        this.eyeColor,
        this.birthYear,
        this.gender,
        this.homeworld,
        this.films,
        this.species,
        this.vehicles,
        this.starships,
        this.created,
        this.edited,
        this.url,
    });
    @HiveField(0)
    String? name;
    @HiveField(1)
    String? height;
    @HiveField(2)
    String? mass;
    @HiveField(3)
    String? hairColor;
    @HiveField(4)
    String? skinColor;
    @HiveField(5)
    String? eyeColor;
    @HiveField(6)
    String? birthYear;
    @HiveField(7)
    String? gender;
    @HiveField(8)
    String? homeworld;
    @HiveField(9)
    List<String>? films;
    @HiveField(10)
    List<String>? species;
    @HiveField(11)
    List<String>? vehicles;
    @HiveField(12)
    List<String>? starships;
    @HiveField(13)
    DateTime? created;
    @HiveField(14)
    DateTime? edited;
    @HiveField(15)
    String? url;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json["name"],
        height: json["height"],
        mass: json["mass"],
        hairColor: json["hair_color"],
        skinColor: json["skin_color"],
        eyeColor: json["eye_color"],
        birthYear: json["birth_year"],
        gender: json["gender"],
        homeworld: json["homeworld"],
        films: List<String>.from(json["films"].map((x) => x)),
        species: List<String>.from(json["species"].map((x) => x)),
        vehicles: List<String>.from(json["vehicles"].map((x) => x)),
        starships: List<String>.from(json["starships"].map((x) => x)),
        created: DateTime.parse(json["created"]),
        edited: DateTime.parse(json["edited"]),
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "height": height,
        "mass": mass,
        "hair_color": hairColor,
        "skin_color": skinColor,
        "eye_color": eyeColor,
        "birth_year": birthYear,
        "gender": gender,
        "homeworld": homeworld,
        "films": List<dynamic>.from(films!.map((x) => x)),
        "species": List<dynamic>.from(species!.map((x) => x)),
        "vehicles": List<dynamic>.from(vehicles!.map((x) => x)),
        "starships": List<dynamic>.from(starships!.map((x) => x)),
        "created": created!.toIso8601String(),
        "edited": edited!.toIso8601String(),
        "url": url,
    };

    
  }

