import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubit/subject_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_application_1/entity/subject.dart';
import 'package:flutter_application_1/view/texteditor_screen.dart';

import '../entity/level.dart';

// ignore: must_be_immutable
class SubjectScreen extends StatefulWidget {
  Levels level;

  SubjectScreen({
    Key? key,
    required this.level,
  }) : super(key: key);

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SubjectCubit>().getSubject();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFf0e6fe),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 24,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Stack(children: <Widget>[
                Positioned(
                  child: ClipPath(
                    clipper: OvalBottomBorderClipper(),
                    child: Container(
                      height: 150,
                      color: const Color(0xFFf0e6fe),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Text(
                          widget.level.name,
                          style: const TextStyle(
                              color: Colors.lightBlueAccent,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 175),
                  child: BlocBuilder<SubjectCubit, List<Subjects>>(
                    builder: (context, subjectsList) {
                      List<Subjects> subjectArrayByLevel = [];

                      if (subjectsList.isNotEmpty) {
                        for (int i = 0; i < subjectsList.length; i++) {
                          Subjects subject = subjectsList[i];
                          if (subject.level!.id == widget.level.id) {
                            subjectArrayByLevel.add(subject);
                          }
                        }

                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: subjectArrayByLevel.length,
                            itemBuilder: (context, index) {
                              var subject = subjectArrayByLevel[index];

                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFFf0e6fe),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            elevation: 0),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      TextEditorScreen(
                                                        subject: subject,
                                                      ))));
                                        },
                                        child: Row(
                                          children: [
                                            if (subject.level!.id ==
                                                    widget.level.id &&
                                                subject.name != null) ...[
                                              Text(
                                                "${subject.name}",
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              )
                                            ]
                                          ],
                                        )),
                                  ),
                                ),
                              );
                            });
                      } else {
                        return const Center();
                      }
                    },
                  ),
                )
              ])
            ],
          ),
        ),
      ),
    );
  }
}
