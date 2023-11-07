import 'dart:convert';

import 'package:eight_hundred_cal/backend/translator/translator_backend.dart';
import 'package:eight_hundred_cal/model/program/program_model.dart';
import 'package:get/get.dart';

import '../../services/http_service.dart';
import '../../utils/api_constants.dart';

class ProgramBackend extends GetxController {
  List<ProgramModel> programList = [];
  List<ProgramModel> tempList = [];

  fetchAllPrograms() async {
    try {
      var c = Get.put(TranslatorBackend());
      final response = await HttpServices.get(ApiConstants.program);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        List pList = data['program'];
        programList = pList.map((e) => ProgramModel.fromJSON(e)).toList();
        for (int i = 0; i < programList.length; i++) {
          programList[i].name = await c.translateText(programList[i].name);
          programList[i].description =
              await c.translateText(programList[i].description);
          programList[i].tag = await c.translateText(programList[i].tag);
        }
        tempList = programList;
        update();
      } else {
        print("${response.statusCode}");
      }
    } catch (e) {
      print("FETCH ALL PROGRAM $e");
    }
  }

  searchProgramByName(String value) {
    if (value != "") {
      tempList = programList
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    } else {
      tempList = programList;
    }
    update();
  }
}
