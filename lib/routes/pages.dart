import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:todo_storage/main.dart';
import 'package:todo_storage/routes/route.dart';

import '../appInit/binding.dart';

abstract class AppPages {
  static final pages = [
    GetPage(name: Routes.home, page: () => const MyApp(), binding: HomeBinding()),
  ];
}
