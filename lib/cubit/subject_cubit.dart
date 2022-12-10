import 'package:flutter_application_1/entity/subject.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repo/dao_repository.dart';

class SubjectCubit extends Cubit<List<Subjects>> {
  SubjectCubit() : super(<Subjects>[]);
  var repo = const DaoRepository();

  Future<void> getSubject() async {
    var list = await repo.getSubject();
    emit(list);
  }
}
