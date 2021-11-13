import 'package:geolocator/geolocator.dart';

class LocationHelper{

  static Future<Position> getCurrentLocation()async{

    bool isServicesEnabled = await Geolocator.isLocationServiceEnabled();
    if(!isServicesEnabled){
      await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
}