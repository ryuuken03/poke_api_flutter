import 'package:poke_api/data/models/sprites_other.dart';

class Sprites {
  String? back_default;
  String? back_female;
  String? back_shiny;
  String? back_shiny_female;
  String? front_default;
  String? front_female;
  String? front_shiny;
  String? front_shiny_female;
  String? default_data;
  SpritesOther? other;

  Sprites({
    this.back_default,
    this.back_female,
    this.back_shiny,
    this.back_shiny_female,
    this.front_default,
    this.front_female,
    this.front_shiny,
    this.front_shiny_female,
    this.default_data,
    this.other,
  });
  factory Sprites.fromJson(Map<String, dynamic> json) {
    return Sprites(
        back_default: json["back_default"] as String?,
        back_female: json["back_female"] as String?,
        back_shiny: json["back_shiny"] as String?,
        back_shiny_female: json["back_shiny_female"] as String?,
        front_default: json["front_default"] as String?,
        front_female: json["front_female"] as String?,
        front_shiny: json["front_shiny"] as String?,
        front_shiny_female: json["front_shiny_female"] as String?,
        default_data: json["default"] as String?,
        other: json["other"] == null
            ? null
            : SpritesOther.fromJson(json["other"]),
        );
  }
}
