import 'dart:convert';

List<Levels> levelsFromJson(String str) =>
    List<Levels>.from(json.decode(str).map((x) => Levels.fromJson(x)));

String levelsToJson(List<Levels> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Levels {
  int id;
  String name;
  dynamic deletedAt;

  Levels({
    required this.id,
    required this.name,
    required this.deletedAt,
  });

  factory Levels.fromJson(Map<String, dynamic> json) {
    return Levels(
      id: json["id"] as int,
      name: json["name"] as String,
      deletedAt: json["deletedAt"] as dynamic,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "deletedAt": deletedAt,
      };
}
