import 'package:get/get.dart';

import '../controller/controller.dart';
import '../module/location_service.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    getUserLocation();
    Get.lazyPut<TodoController>(() => TodoController());
  }
}
