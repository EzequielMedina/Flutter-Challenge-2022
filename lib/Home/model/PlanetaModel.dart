// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
part 'PlanetaModel.g.dart';

Planeta welcomeFromJson(String str) => Planeta.fromJson(json.decode(str));

String welcomeToJson(Planeta data) => json.encode(data.toJson());

@HiveType(typeId: 2)
class Planeta {
  Planeta({
    this.name,
    this.rotationPeriod,
    this.orbitalPeriod,
    this.diameter,
    this.climate,
    this.gravity,
    this.terrain,
    this.surfaceWater,
    this.population,
    this.residents,
    this.films,
    this.created,
    this.edited,
    this.url,
  });
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? rotationPeriod;
  @HiveField(2)
  String? orbitalPeriod;
  @HiveField(3)
  String? diameter;
  @HiveField(4)
  String? climate;
  @HiveField(5)
  String? gravity;
  @HiveField(6)
  String? terrain;
  @HiveField(7)
  String? surfaceWater;
  @HiveField(8)
  String? population;
  @HiveField(9)
  List<String>? residents;
  @HiveField(10)
  List<String>? films;
  @HiveField(11)
  DateTime? created;
  @HiveField(12)
  DateTime? edited;
  @HiveField(13)
  String? url;

  factory Planeta.fromJson(Map<String, dynamic> json) => Planeta(
        name: json["name"],
        rotationPeriod: json["rotation_period"],
        orbitalPeriod: json["orbital_period"],
        diameter: json["diameter"],
        climate: json["climate"],
        gravity: json["gravity"],
        terrain: json["terrain"],
        surfaceWater: json["surface_water"],
        population: json["population"],
        residents: List<String>.from(json["residents"].map((x) => x)),
        films: List<String>.from(json["films"].map((x) => x)),
        created: DateTime.parse(json["created"]),
        edited: DateTime.parse(json["edited"]),
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "rotation_period": rotationPeriod,
        "orbital_period": orbitalPeriod,
        "diameter": diameter,
        "climate": climate,
        "gravity": gravity,
        "terrain": terrain,
        "surface_water": surfaceWater,
        "population": population,
        "residents": List<dynamic>.from(residents!.map((x) => x)),
        "films": List<dynamic>.from(films!.map((x) => x)),
        "created": created?.toIso8601String(),
        "edited": edited?.toIso8601String(),
        "url": url,
      };
}
