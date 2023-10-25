import 'package:poke_api/data/models/ability_data.dart';
import 'package:poke_api/data/models/default.dart';
import 'package:poke_api/data/models/move_data.dart';
import 'package:poke_api/data/models/sprites.dart';
import 'package:poke_api/data/models/stat_data.dart';
import 'package:poke_api/data/models/type_data.dart';

class ResponsePokemon {
  List<AbilityData>? abilities;
  int? base_experience;
  List<Default>? forms;
  int height;
  int id;
  bool is_default;
  String? location_area_encounters;
  List<MoveData>? moves;
  String? name;
  int order;
  Sprites? sprites;
  List<StatData>? stats;
  List<TypeData>? types;
  int weight;

  ResponsePokemon({
    this.abilities,
    this.base_experience,
    this.forms,
    this.height = 0,
    this.id = 0,
    this.is_default = false,
    this.location_area_encounters,
    this.moves,
    this.name,
    this.order = 0,
    this.sprites,
    this.stats,
    this.types,
    this.weight = 0,
  });
  factory ResponsePokemon.fromJson(Map<String, dynamic> json) {
    List<AbilityData>? abilities;
    List<Default>? forms;
    List<MoveData>? moves;
    List<StatData>? stats;
    List<TypeData>? types;
    if (json["abilities"] != null) {
      abilities = [];
      json['abilities'].forEach((v) {
        abilities!.add(AbilityData.fromJson(v));
      });
    }
    if (json["forms"] != null) {
      forms = [];
      json['forms'].forEach((v) {
        forms!.add(Default.fromJson(v));
      });
    }
    if (json["moves"] != null) {
      moves = [];
      json['moves'].forEach((v) {
        moves!.add(MoveData.fromJson(v));
      });
    }
    if (json["stats"] != null) {
      stats = [];
      json['stats'].forEach((v) {
        stats!.add(StatData.fromJson(v));
      });
    }
    if (json["types"] != null) {
      types = [];
      json['types'].forEach((v) {
        types!.add(TypeData.fromJson(v));
      });
    }
    return ResponsePokemon(
      abilities: abilities,
      base_experience: json["base_experience"] as int?,
      height: json["height"] as int,
      forms: forms,
      id: json["id"] as int,
      is_default: json["is_default"] as bool,
      location_area_encounters: json["location_area_encounters"] == null
          ? null
          : json["location_area_encounters"] as String,
      moves: moves,
      name: json["name"] == null ? null : json["name"] as String,
      order: json["order"] as int,
      sprites:
          json["sprites"] == null ? null : Sprites.fromJson(json["sprites"]),
      stats: stats,
      types: types,
      weight: json["weight"] as int,
    );
  }
}
