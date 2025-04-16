import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ridehailing_driver/helper/map_controller.dart';
import 'package:ridehailing_driver/helper/map_utilities.dart';
import 'package:ridehailing_driver/services/location_service.dart';

class UserController {
  final GoogleMapController googleMapController;
  Position? userCurrentPosition;

  UserController(this.googleMapController);

  Future<void> locateUserPosition(BuildContext context) async {
    LocationService locationService = LocationService();
    Position? userPosition = await locationService.getCurrentPosition();
    if (userPosition != null) {
      userCurrentPosition = userPosition;

      MapController(googleMapController).updateCameraPosition(userPosition);

      if (context.mounted) {
        await MapUtilities.convertCoordinatesIntoHumanReadableAddress(
          userCurrentPosition!,
        );
      }
    }
  }
}
