import 'package:poke_api/data/models/default.dart';

class TypeData {
  int slot;
  Default? type;

  TypeData({
    this.slot = 0,
    this.type,
  });
  factory TypeData.fromJson(Map<String, dynamic> json) {
    return TypeData(
        slot: json["slot"]as int,
        type: json["type"] == null ? null : Default.fromJson(json["type"]),
        );
  }
}
