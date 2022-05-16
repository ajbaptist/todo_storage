import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
 

class AppConfigService extends GetxService {
  Future<AppConfigService> init() async {
    box = GetStorage();
     
    return this;
  }

  late GetStorage box;
 
  }

