import 'package:get/get.dart';

import '../controller/controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    print("bind");
    Get.lazyPut<TodoController>(() => TodoController());
  }
}
