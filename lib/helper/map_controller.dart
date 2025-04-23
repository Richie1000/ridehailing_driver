import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController {
  final GoogleMapController? googleMapController;

  MapController(this.googleMapController);

  void updateCameraPosition(Position position) {
    LatLng latLngPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition = CameraPosition(
      target: latLngPosition,
      zoom: 15,
    );
    googleMapController?.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
  }
}
