import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_application_1/entity/question.dart';
import 'package:flutter_application_1/entity/subject.dart';

import '../cubit/question_cubit.dart';

// ignore: must_be_immutable
class QuestionScreen extends StatefulWidget {
  Subjects subject;
  QuestionScreen({
    Key? key,
    required this.subject,
  }) : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  Future<bool> main(BuildContext context) async {
    int count = 0;
    bool stat = Navigator.of(context).popUntil((_) => count++ >= 2) as bool;
    return stat;
  }

  String? description = "";
  bool pressAttention = false;
  int selectedIndex = 0;
  int indexofQuest = 0;
  int countofQuest = 0;
  int activeButtonIndex = -1;
  int clickAnswerCount = 0;

  @override
  void initState() {
    super.initState();
    context.read<QuestionCubit>().getQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => main(context),
      child: Scaffold(
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
              var nav = Navigator.of(context);
              nav.pop(context);
              nav.pop(context);
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "${widget.subject.name}",
                style: const TextStyle(
                    color: Colors.lightBlueAccent,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        body: (Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Positioned(
                  child: ClipPath(
                    clipper: OvalBottomBorderClipper(),
                    child: Container(
                      height: 150,
                      color: const Color(0xFFf0e6fe),
                    ),
                  ),
                ),
                BlocBuilder<QuestionCubit, List<Questions>>(
                    builder: (context, questionsList) {
                  List<Questions> questionsArrayBySubjects = [];
                  List<int> questionIDs = [];
                  var name = "";
                  var optionValue1 = "";
                  var optionValue2 = "";
                  var optionValue3 = "";
                  var optionValue4 = "";
                  var optionName1 = "";
                  var optionName2 = "";
                  var optionName3 = "";
                  var optionName4 = "";
                  var correctAnswer = "";

                  for (int i = 0; i < questionsList.length; i++) {
                    Questions questions = questionsList[i];
                    if (questions.subject.id == widget.subject.id) {
                      questionsArrayBySubjects.add(questions);
                      questionIDs.add(questions.id);
                    }
                  }

                  questionIDs.sort();
                  countofQuest = questionIDs.length;

                  for (int i = 0; i < questionIDs.length; i++) {
                    if (questionsArrayBySubjects[i].id ==
                        questionIDs[indexofQuest]) {
                      name = questionsArrayBySubjects[i].question;
                      description = questionsArrayBySubjects[i].description;
                      optionName1 =
                          questionsArrayBySubjects[i].options[0].optionName;
                      optionName2 =
                          questionsArrayBySubjects[i].options[1].optionName;
                      optionName3 =
                          questionsArrayBySubjects[i].options[2].optionName;
                      optionName4 =
                          questionsArrayBySubjects[i].options[3].optionName;
                      optionValue1 =
                          questionsArrayBySubjects[i].options[0].value;
                      optionValue2 =
                          questionsArrayBySubjects[i].options[1].value;
                      optionValue3 =
                          questionsArrayBySubjects[i].options[2].value;
                      optionValue4 =
                          questionsArrayBySubjects[i].options[3].value;
                      correctAnswer =
                          questionsArrayBySubjects[i].correctAnswer.value;
                    }
                  }
                  List<String> optionName = [
                    optionName1,
                    optionName2,
                    optionName3,
                    optionName4
                  ];
                  List<String> optionValue = [
                    optionValue1,
                    optionValue2,
                    optionValue3,
                    optionValue4
                  ];
                  var optionCount = 0;

                  for (var name in optionValue) {
                    if (name == "") {
                      optionCount = optionValue.length - 1;
                    } else {
                      optionCount = optionValue.length;
                    }
                  }

                  if (questionsList.isNotEmpty) {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Center(
                              child: Column(
                                children: [
                                  if (questionsArrayBySubjects.isNotEmpty) ...[
                                    Text.rich(TextSpan(
                                        text: "Question ${indexofQuest + 1}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5
                                            ?.copyWith(
                                                color: Colors.lightBlueAccent),
                                        children: [
                                          TextSpan(
                                            text: "/" "$countofQuest",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                ?.copyWith(
                                                    color:
                                                        Colors.lightBlueAccent),
                                          )
                                        ])),
                                    const Divider(
                                      thickness: 0.75,
                                      indent: 75,
                                      endIndent: 75,
                                    ),
                                    Card(
                                      elevation: 1,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Container(
                                        width: 300,
                                        height: 150,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Colors.white),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                name,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ]),
                                      ),
                                    ),
                                    const SizedBox(height: 50),
                                    ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: optionCount,
                                      itemBuilder: (BuildContext _, i) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 50),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 20),
                                            child: SizedBox(
                                              width: 50,
                                              height: 50,
                                              child: OutlinedButton(
                                                style: OutlinedButton.styleFrom(
                                                    backgroundColor:
                                                        pressAttention
                                                            ? optionValue[i] ==
                                                                    correctAnswer
                                                                ? Colors.green
                                                                : (activeButtonIndex ==
                                                                        i
                                                                    ? Colors.red
                                                                    : Colors
                                                                        .white)
                                                            // : Colors.red
                                                            : Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                    elevation: 0),
                                                onPressed: () {
                                                  clickAnswerCount > 0
                                                      ? null
                                                      : setState(() {
                                                          activeButtonIndex = i;
                                                          pressAttention = true;
                                                          clickAnswerCount++;
                                                        });
                                                },
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "${optionName[i]}) ${optionValue[i]}",
                                                      style: const TextStyle(
                                                          fontFamily: "Roboto",
                                                          fontSize: 16,
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ]
                                ],
                              ),
                            ),
                          );
                        });
                  } else {
                    return const Center();
                  }
                }),
              ],
            ),
          ],
        )),
        bottomNavigationBar: BottomNavigationBar(
            elevation: 0,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.lightBlueAccent,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.info,
                  color: Colors.lightBlueAccent,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.lightBlueAccent,
                ),
                label: '',
              )
            ],
            backgroundColor: const Color(0xFFfafafa),
            currentIndex: selectedIndex,
            // selectedItemColor: Colors.black,
            // unselectedItemColor: Colors.black,
            // selectedFontSize: 14,
            // unselectedFontSize: 14,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
                if (index == 0) {
                  clickAnswerCount = 0;
                  indexofQuest -= 1;
                  pressAttention = false;
                  if (indexofQuest == -1) {
                    indexofQuest = 0;
                  }
                } else if (index == 2) {
                  clickAnswerCount = 0;
                  indexofQuest += 1;
                  pressAttention = false;
                  if (indexofQuest == countofQuest) {
                    indexofQuest = countofQuest - 1;
                  }
                } else if (index == 1) {
                  var desc = "";
                  if (description != null) {
                    desc = description!;
                  }
                  if (desc.isNotEmpty) {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            title: const Center(
                                child: Text(
                              'Açıklama',
                              style: TextStyle(color: Colors.lightBlueAccent),
                            )),
                            content: Text("$description"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Tamam"),
                              )
                            ],
                          );
                        });
                  } else {
                    return;
                  }
                }
              });
            }),
      ),
    );
  }
}
