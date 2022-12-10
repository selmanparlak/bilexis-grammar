import 'package:flutter_application_1/repo/dao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../entity/level.dart';

class LevelCubit extends Cubit<List<Levels>> {
  LevelCubit() : super(<Levels>[]);
  var repo = const DaoRepository();

  Future<void> getLevels() async {
    var list = await repo.getLevel();
    emit(list);
  }
}
