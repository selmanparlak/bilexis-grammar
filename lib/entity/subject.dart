// ignore_for_file: prefer_void_to_null

import 'dart:convert';

import 'package:flutter_application_1/entity/level.dart';

List<Subjects> subjectsFromJson(String str) =>
    List<Subjects>.from(json.decode(str).map((x) => Subjects.fromJson(x)));

String subjectsToJson(List<Subjects> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Subjects {
  int? id;
  String? name;
  Null order;
  Null deletedAt;
  Levels? level;

  Subjects({this.id, this.name, this.order, this.deletedAt, this.level});

  Subjects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    order = json['order'];
    deletedAt = json['deletedAt'];
    level = json['level'] != null ? Levels.fromJson(json['level']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['order'] = order;
    data['deletedAt'] = deletedAt;
    if (level != null) {
      data['level'] = level!.toJson();
    }
    return data;
  }
}
