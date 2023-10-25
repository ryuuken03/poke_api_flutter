import 'package:poke_api/data/models/default.dart';

class AbilityData {
  Default? ability;
  bool is_hidden;
  int slot;

  AbilityData({
    this.ability,
    this.is_hidden = false,
    this.slot = 0,
  });
  factory AbilityData.fromJson(Map<String, dynamic> json) {
    return AbilityData(
        ability: json["ability"] == null 
        ? null 
        : Default.fromJson(json["ability"]),
        is_hidden: json["is_hidden"] as bool,
        slot: json["slot"]as int,
        );
  }
}
