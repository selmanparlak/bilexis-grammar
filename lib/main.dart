// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/repo/dao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'cubit/level_cubit.dart';
import 'cubit/question_cubit.dart';
import 'cubit/subject_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LevelCubit()),
        BlocProvider(create: (context) => SubjectCubit()),
        BlocProvider(create: (context) => QuestionCubit()),
      ],
      child: MaterialApp(
        builder: (context, child) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, child!),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(450, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
        ),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class UrlAddress {
  static const url = "http://apiv2.bilgelugat.com/api";
}

class Token {
  static String token = "";
}

class _MyHomePageState extends State<MyHomePage> {
  late String? token;
  Future<String?> getToken() async {
    var response =
        await http.post(Uri.parse('${UrlAddress.url}/auth/login'), body: {
      "username": "osman",
      "password": 123.toString(),
    });
    Map valueMap = {};
    valueMap = json.decode(response.body);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', valueMap["token"]);
    token = prefs.getString('token');
    Token.token = token!;
    return token;
  }

  @override
  void initState() {
    super.initState();
    getToken().then((value) {
      if (token!.isNotEmpty) {
        // print(token);
        // print('${Token.token} ');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const DaoRepository()),
            (Route<dynamic> route) => false);
      }
      setState(() {
        if (token!.isEmpty) {
          // print("token empty : $token");
          Token.token = value!;
          token = value;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("img/eng.png"),
      ),
    );
  }
}
