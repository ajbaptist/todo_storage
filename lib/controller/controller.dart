import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:geolocator/geolocator.dart';
import 'package:todo_storage/module/location_service.dart';

import '../appInit/app_config.dart';
import '../model/model.dart' as m;

class TodoController extends GetxController {
  late AppConfigService appConfigService;
  TextEditingController textEditingController = TextEditingController();
  RxList rxList = [].obs;
  RxString location="unknown-please on location".obs;
  RxBool check=false.obs;
  final message = ''.obs;
  final title = ''.obs;
  final key="key";
  final description = ''.obs;
  final edit = false.obs;
  final load = false.obs;
  @override
  void onInit() {
    appConfigService = Get.find<AppConfigService>();
    getAnnotations();
    getUserLocation().then((value) => location(value));
    super.onInit();
  }

  getAnnotations() async {
    var ans = appConfigService.box.read(key);

   print(ans);

   if(ans==null){}else{
      for (var e in ans) {
      rxList.add(e);
    }
   }
  }

  addTodo(value) async {
  
    rxList.add(
      {
        "title":value,
        "date":value,
        "location":location.value,
        "check":false
      }
      
      // m.Annotation(
      //   title: value, date: 'date', check: false, description: 'description')
        
        
        );

         await appConfigService.box.write(key, rxList).then((value) => Get.back());
   
   
  }

  removeTodo(index)async {
    rxList.removeAt(index);
         await appConfigService.box.write(key, rxList);
  }

  changeCheckList(index, value) async{
    rxList[index]["check"] = value;
    print(value);
    Get.forceAppUpdate();
      await appConfigService.box.write(key, rxList);
  }
}
