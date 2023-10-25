import 'package:poke_api/data/models/default.dart';

class VersionGroupDetailData {
  int level_learned_at;
  Default? move_learn_method;
  Default? version_group;

  VersionGroupDetailData({
    this.level_learned_at = 0,
    this.move_learn_method,
    this.version_group,
  });
  factory VersionGroupDetailData.fromJson(Map<String, dynamic> json) {
    return VersionGroupDetailData(
      level_learned_at: json["level_learned_at"] as int,
      move_learn_method: json["move_learn_method"] == null ? null : Default.fromJson(json["move_learn_method"]),
      version_group: json["version_group"] == null ? null : Default.fromJson(json["version_group"]),
    );
  }
}
