// To parse this JSON data, do
//
//     final textEditor = textEditorFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_application_1/entity/level.dart';

TextEditor textEditorFromJson(String str) =>
    TextEditor.fromJson(json.decode(str));

String textEditorToJson(TextEditor data) => json.encode(data.toJson());

class TextEditor {
  TextEditor({
    required this.name,
    required this.level,
    required this.description,
    required this.lecture,
  });

  String name;
  Levels level;
  String description;
  String lecture;

  factory TextEditor.fromJson(Map<String, dynamic> json) => TextEditor(
        name: json["name"],
        level: Levels.fromJson(json["level"]),
        description: json["description"],
        lecture: json["lecture"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "level": level.toJson(),
        "description": description,
        "lecture": lecture,
      };
}
