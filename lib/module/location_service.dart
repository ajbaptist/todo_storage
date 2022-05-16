 import 'package:geocoding/geocoding.dart' as d;
import 'package:location/location.dart';
 import 'package:flutter/services.dart';

Future getUserLocation() async {//call this async method from whereever you need
    
   late   LocationData myLocation;
      String error;
      var location = Location();
      try {
        myLocation = await location.getLocation();
      } on PlatformException catch (e) {
        if (e.code == 'PERMISSION_DENIED') {
          error = 'please grant permission';
          print(error);
        }
        if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
          error = 'permission denied- please enable it from app settings';
          print(error);
        }
      
      }
 
      var addresses =    await d.placemarkFromCoordinates(myLocation.latitude!, myLocation.longitude!,localeIdentifier: "en");
      var first = addresses.first;
    
      return first.locality;
    }