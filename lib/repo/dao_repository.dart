// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/entity/level.dart';
import 'package:flutter_application_1/entity/question.dart';
import 'package:flutter_application_1/entity/subject.dart';
import 'package:flutter_application_1/view/home.dart';
import 'package:http/http.dart' as http;
import '../entity/texteditor.dart';
import '../main.dart';
import '../view/texteditor_screen.dart';

class DaoRepository extends StatelessWidget {
  const DaoRepository({
    Key? key,
  }) : super(key: key);

  Future<List<Levels>> getLevel() async {
    var url = Uri.parse("${UrlAddress.url}/level");
    // print("${Token.token} - endpoint");
    var response = await http.get(url, headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': '*/*',
      'Authorization': Token.token,
    });
    return levelsFromJson(response.body);
  }

  Future<List<Subjects>> getSubject() async {
    var url = Uri.parse("${UrlAddress.url}/subject");
    var response = await http.get(url, headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': '*/*',
      'Authorization': Token.token,
    });
    return subjectsFromJson(response.body);
  }

  Future<List<Questions>> getQuestion() async {
    var url = Uri.parse("${UrlAddress.url}/question");
    var response = await http.get(url, headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': '*/*',
      'Authorization': Token.token,
    });
    return questionsFromJson(response.body);
  }

  Future<TextEditor> getTextEditor() async {
    var subjectid = SubjectId.id;
    var url = Uri.parse("${UrlAddress.url}/subject/$subjectid");
    var response = await http.get(url, headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': '*/*',
      'Authorization': Token.token,
    });
    return textEditorFromJson(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}
