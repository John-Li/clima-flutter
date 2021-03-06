import 'package:geolocator/geolocator.dart';

class Location {
  double latitude;
  double longitude;

  Future getCurrentLocation() async {
    Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;
    Position position = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);

    latitude = position.latitude;
    longitude = position.longitude;
  }
}
