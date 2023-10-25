import 'package:poke_api/data/models/default.dart';

class StatData {
  int base_stat;
  int effort;
  Default? stat;

  StatData({
    this.base_stat = 0,
    this.effort = 0,
    this.stat,
  });
  factory StatData.fromJson(Map<String, dynamic> json) {
    return StatData(
        base_stat: json["base_stat"]as int,
        effort: json["effort"]as int,
        stat: json["stat"] == null ? null : Default.fromJson(json["stat"]),
        );
  }
}
