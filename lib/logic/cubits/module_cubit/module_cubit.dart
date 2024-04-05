import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preparation/data/models/module_model.dart';
import 'package:preparation/data/repository/module_repository.dart';
import 'package:preparation/logic/cubits/module_cubit/module_state.dart';

class ModuleCubit extends Cubit<ModuleStates> {
  final int courseId;

  ModuleCubit(this.courseId) : super(ModuleInitialState()) {
    fetchModules(courseId);
  }

  ModuleRepository moduleRepository = ModuleRepository();

  void fetchModules(int courseId) async {
    try {
      List<ModuleModel> modules = await moduleRepository.fetchModules(courseId);
      emit(ModuleDataSuccessState(modules));
    } catch (ex) {
      log("Failed to fetch modules $ex");
      emit(ModuleErrorState("Failed to fetch modules: $ex"));
    }
  }
}
