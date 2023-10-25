import 'package:poke_api/data/models/default.dart';

class ResponseListPokemon {
  int count;
  String? next;
  String? prev;
  List<Default>? results;

  ResponseListPokemon({
    this.count = 0, 
    this.next,
    this.prev,
    this.results,
  });
  factory ResponseListPokemon.fromJson(Map<String, dynamic> json) {
    List<Default>? results;
    if (json["results"] != null) {
      results = [];
      json['results'].forEach((v) {
        results!.add(Default.fromJson(v));
      });
    }
    return ResponseListPokemon(
      count: json["count"] as int,
      next: json["next"] == null 
            ? null 
            : json["next"] as String,
      prev: json["prev"] == null 
            ? null 
            : json["prev"] as String,
      results: results
    );
  }
}