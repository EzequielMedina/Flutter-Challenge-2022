// To parse this JSON data, do
//
//     final Vehiculo = VehiculoFromJson(jsonString);

import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
part 'vehiculoModel.g.dart';

Vehiculo VehiculoFromJson(String str) => Vehiculo.fromJson(json.decode(str));

String VehiculoToJson(Vehiculo data) => json.encode(data.toJson());

@HiveType(typeId: 4)
class Vehiculo {
  Vehiculo({
    this.name,
    this.model,
    this.manufacturer,
    this.costInCredits,
    this.length,
    this.maxAtmospheringSpeed,
    this.crew,
    this.passengers,
    this.cargoCapacity,
    this.consumables,
    this.hyperdriveRating,
    this.mglt,
    this.starshipClass,
    this.pilots,
    this.films,
    this.created,
    this.edited,
    this.url,
  });
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? model;
  @HiveField(2)
  String? manufacturer;
  @HiveField(3)
  String? costInCredits;
  @HiveField(4)
  String? length;
  @HiveField(5)
  String? maxAtmospheringSpeed;
  @HiveField(6)
  String? crew;
  @HiveField(7)
  String? passengers;
  @HiveField(8)
  String? cargoCapacity;
  @HiveField(9)
  String? consumables;
  @HiveField(10)
  String? hyperdriveRating;
  @HiveField(11)
  String? mglt;
  @HiveField(12)
  String? starshipClass;
  @HiveField(13)
  List<String>? pilots;
  @HiveField(14)
  List<String>? films;
  @HiveField(15)
  DateTime? created;
  @HiveField(16)
  DateTime? edited;
  @HiveField(17)
  String? url;

  factory Vehiculo.fromJson(Map<String, dynamic> json) => Vehiculo(
        name: json["name"],
        model: json["model"],
        manufacturer: json["manufacturer"],
        costInCredits: json["cost_in_credits"],
        length: json["length"],
        maxAtmospheringSpeed: json["max_atmosphering_speed"],
        crew: json["crew"],
        passengers: json["passengers"],
        cargoCapacity: json["cargo_capacity"],
        consumables: json["consumables"],
        hyperdriveRating: json["hyperdrive_rating"],
        mglt: json["MGLT"],
        starshipClass: json["starship_class"],
        pilots: List<String>.from(json["pilots"].map((x) => x)),
        films: List<String>.from(json["films"].map((x) => x)),
        created: DateTime.parse(json["created"]),
        edited: DateTime.parse(json["edited"]),
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "model": model,
        "manufacturer": manufacturer,
        "cost_in_credits": costInCredits,
        "length": length,
        "max_atmosphering_speed": maxAtmospheringSpeed,
        "crew": crew,
        "passengers": passengers,
        "cargo_capacity": cargoCapacity,
        "consumables": consumables,
        "hyperdrive_rating": hyperdriveRating,
        "MGLT": mglt,
        "starship_class": starshipClass,
        "pilots": List<dynamic>.from(pilots!.map((x) => x)),
        "films": List<dynamic>.from(films!.map((x) => x)),
        "created": created!.toIso8601String(),
        "edited": edited!.toIso8601String(),
        "url": url,
      };
}
