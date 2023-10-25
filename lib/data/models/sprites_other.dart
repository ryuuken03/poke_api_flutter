import 'package:poke_api/data/models/sprites.dart';

class SpritesOther {
  Sprites? dream_world;
  Sprites? home;
  Sprites? official_artwork;

  SpritesOther({
    this.dream_world,
    this.home,
    this.official_artwork,
  });
  factory SpritesOther.fromJson(Map<String, dynamic> json) {
    return SpritesOther(
      dream_world: json["back_default"] == null
      ? null 
      : Sprites.fromJson(json["back_default"]),
      home: json["back_female"] == null
          ? null
          : Sprites.fromJson(json["back_female"]),
      official_artwork: json["official-artwork"] == null
          ? null
          : Sprites.fromJson(json["official-artwork"]),
    );
  }
}
