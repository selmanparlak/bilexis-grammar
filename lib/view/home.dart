import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubit/level_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_application_1/view/subject_screen.dart';
import '../entity/level.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController controller = ScrollController();
  @override
  void initState() {
    super.initState();
    context.read<LevelCubit>().getLevels();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFFf0e6fe),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  Padding(
                    padding: const EdgeInsets.only(top: 75),
                    child: BlocBuilder<LevelCubit, List<Levels>>(
                      builder: (context, levelsList) {
                        if (levelsList.isNotEmpty) {
                          return Center(
                            child: GridView.builder(
                                controller: controller,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 2.8,
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 5,
                                  crossAxisCount: 1,
                                ),
                                itemCount: levelsList.length,
                                itemBuilder: (context, index) {
                                  var level = levelsList[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            elevation: 1),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SubjectScreen(
                                                        level: level,
                                                      )));
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              level.name,
                                              style: const TextStyle(
                                                  color: Colors.lightBlueAccent,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        )),
                                  );
                                }),
                          );
                        } else {
                          return const Center();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
