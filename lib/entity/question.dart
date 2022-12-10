// To parse this JSON data, do
//
//     final questions = questionsFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_application_1/entity/subject.dart';

List<Questions> questionsFromJson(String str) =>
    List<Questions>.from(json.decode(str).map((x) => Questions.fromJson(x)));

String questionsToJson(List<Questions> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Questions {
  Questions({
    required this.id,
    required this.question,
    required this.order,
    this.description,
    this.deletedAt,
    required this.subject,
    required this.correctAnswer,
    required this.options,
  });

  int id;
  String question;
  int order;
  dynamic description;
  dynamic deletedAt;
  Subjects subject;
  CorrectAnswer correctAnswer;
  List<CorrectAnswer> options;

  factory Questions.fromJson(Map<String, dynamic> json) => Questions(
        id: json["id"],
        question: json["question"],
        order: json["order"],
        description: json["description"],
        deletedAt: json["deletedAt"],
        subject: Subjects.fromJson(json["subject"]),
        correctAnswer: CorrectAnswer.fromJson(json["correctAnswer"]),
        options: List<CorrectAnswer>.from(
            json["options"].map((x) => CorrectAnswer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "order": order,
        "description": description,
        "deletedAt": deletedAt,
        "subject": subject.toJson(),
        "correctAnswer": correctAnswer.toJson(),
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
      };
}

class CorrectAnswer {
  CorrectAnswer({
    required this.id,
    required this.optionName,
    required this.value,
  });

  int id;
  String optionName;
  String value;

  factory CorrectAnswer.fromJson(Map<String, dynamic> json) => CorrectAnswer(
        id: json["id"],
        optionName: json["optionName"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "optionName": optionName,
        "value": value,
      };
}
