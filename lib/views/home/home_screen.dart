import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ridehailing_driver/helper/locate_user_position.dart';
import 'package:ridehailing_driver/helper/location_permission.dart';
import 'package:ridehailing_driver/theme/contants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> googleMapCompleterController =
      Completer<GoogleMapController>();

  Position? currentPositionOfUser;
  GoogleMapController? controller;

  Future<void> locateUser() async {
    await LocationPermissions.requestLocationPermission();
    if (controller == null || !mounted) return;
    UserController userController = UserController(controller!);

    await userController.locateUserPosition(context);
    if (!mounted) return;
    setState(() {
      currentPositionOfUser = userController.userCurrentPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        padding: const EdgeInsets.only(top: 26),
        mapType: MapType.normal,
        myLocationEnabled: true,
        initialCameraPosition: kGooglePlex,
        onMapCreated: (GoogleMapController mapController) {
          googleMapCompleterController.complete(mapController);
          setState(() {
            controller = mapController;
          });
          locateUser();
        },
      ),
    );
  }
}
