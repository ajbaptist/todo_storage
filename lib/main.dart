import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_storage/controller/controller.dart';
import 'package:todo_storage/routes/pages.dart';
import 'package:todo_storage/routes/route.dart';
import 'package:todo_storage/view/home_screen.dart';

import 'appInit/app_config.dart';

void main() async {
  await GetStorage.init();
  await Get.putAsync(() => AppConfigService().init());
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.home,
    defaultTransition: Transition.fade,
    getPages: AppPages.pages,

  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MyHomePage(title: 'TODO APPLICATION');
  }
}
