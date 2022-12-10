import 'package:flutter/material.dart';
import 'package:flutter_application_1/repo/dao_repository.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_application_1/entity/subject.dart';
import 'package:flutter_application_1/entity/texteditor.dart';
import 'package:flutter_application_1/view/question_screen.dart';

class SubjectId {
  // ignore: prefer_typing_uninitialized_variables
  static var id;
}

// ignore: must_be_immutable
class TextEditorScreen extends StatefulWidget {
  Subjects subject;
  TextEditorScreen({
    Key? key,
    required this.subject,
  }) : super(key: key);

  @override
  State<TextEditorScreen> createState() => _TextEditorScreenState();
}

class _TextEditorScreenState extends State<TextEditorScreen> {
  var repo = const DaoRepository();

  @override
  void initState() {
    SubjectId.id = widget.subject.id;
    super.initState();
    repo.getTextEditor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
            bottom: false,
            child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 24,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => QuestionScreen(
                                      subject: widget.subject,
                                    ))));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFf0e6fe),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      child: const Text(
                        "Geç",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder<TextEditor>(
                future: repo.getTextEditor(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Html(
                      data: snapshot.data!.lecture,
                      style: {
                        "html": Style(
                          backgroundColor: Colors.white,
                        ),
                        "table": Style(
                          backgroundColor:
                              const Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                        ),
                        "tr": Style(
                          border: const Border(
                              bottom: BorderSide(color: Colors.grey)),
                        ),
                        "th": Style(
                          padding: const EdgeInsets.all(6),
                          backgroundColor: Colors.grey,
                        ),
                        "td": Style(
                          padding: const EdgeInsets.only(left: 8),
                          fontSize: FontSize.large,
                        ),
                        "var": Style(fontFamily: 'serif'),
                      },
                      onImageError: (exception, stackTrace) {},
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const Center(
                      child: Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: CircularProgressIndicator(),
                  ));
                },
              )
            ])),
      ),
    );
  }
}
