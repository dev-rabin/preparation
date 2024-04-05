import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:preparation/data/models/module_model.dart';
import 'package:preparation/data/repository/api/api.dart';

API api = API();

class ModuleRepository {
  Future<List<ModuleModel>> fetchModules(int courseId) async {
    try {
      Response response = await api.sendRequest.get("/module/$courseId");
      if (response.statusCode == 200) {
        final List<dynamic> moduleData = response.data['data'];
        List<ModuleModel> modules = moduleData.map((moduleMap) => ModuleModel.fromJson(moduleMap)).toList();
        return modules;
      }else{
        log("failed to fetch modules");
        throw Exception("failed to fetch modules:${response.statusMessage}");
      }
    } catch (ex) {
      log("Fetch modules error: $ex");
      rethrow;
    }
  }
}
