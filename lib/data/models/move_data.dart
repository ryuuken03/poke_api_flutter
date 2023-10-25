import 'package:poke_api/data/models/default.dart';
import 'package:poke_api/data/models/version_group_detail_data.dart';

class MoveData {
  Default? move;
  List<VersionGroupDetailData>? version_group_details;

  MoveData({
    this.move,
    this.version_group_details,
  });
  factory MoveData.fromJson(Map<String, dynamic> json) {
    List<VersionGroupDetailData>? version_group_details;
    if (json["version_group_details"] != null) {
      version_group_details = [];
      json['version_group_details'].forEach((v) {
        version_group_details!.add(VersionGroupDetailData.fromJson(v));
      });
    }
    return MoveData(
        move: json["move"] == null 
        ? null 
        : Default.fromJson(json["move"]),
        version_group_details: version_group_details,
        );
  }
}
