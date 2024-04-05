import 'package:preparation/data/models/module_model.dart';

abstract class ModuleStates {}

class ModuleInitialState extends ModuleStates{}

class ModuleLoadingState extends ModuleStates{}

class ModuleDataSuccessState extends ModuleStates{
  List<ModuleModel> moduleModel;
  ModuleDataSuccessState(this.moduleModel);
}


class ModuleErrorState extends ModuleStates{
  String errorMessage;
  ModuleErrorState(this.errorMessage);
}