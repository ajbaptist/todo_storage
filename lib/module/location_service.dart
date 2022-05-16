import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart' as d;
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:todo_storage/config/value.dart';
import 'package:todo_storage/controller/controller.dart';

Future getUserLocation() async {
  //call this async method from whereever you need

  var error = '';
  late Position position;

  try {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // ignore: empty_catches
  } on PlatformException {}

  try {
    var addresses = await d.placemarkFromCoordinates(
        position.latitude, position.longitude,
        localeIdentifier: "en");

    var first = addresses.first;

    Fluttertoast.showToast(msg: "location stored");

    

    location = first.locality!;
  } catch (e) {
    Fluttertoast.showToast(msg: e.toString());
  }
}
