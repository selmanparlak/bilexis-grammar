import 'package:flutter_application_1/entity/question.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repo/dao_repository.dart';

class QuestionCubit extends Cubit<List<Questions>> {
  QuestionCubit() : super(<Questions>[]);
  var repo = const DaoRepository();

  Future<void> getQuestion() async {
    var list = await repo.getQuestion();
    emit(list);
  }
}
