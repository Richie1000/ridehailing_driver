import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
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
  DatabaseReference? newTripRequestReference;
  bool isDriverAvailable = false;
  Color colorToShow = primaryColor;
  String titleToShow = "GO ONLINE NOW";

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

  goOnline() {
    Geofire.initialize("onlineDrivers");
    Geofire.setLocation(
      FirebaseAuth.instance.currentUser!.uid,
      currentPositionOfUser!.latitude,
      currentPositionOfUser!.longitude,
    );
    newTripRequestReference = FirebaseDatabase.instance
        .ref()
        .child("drivers")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child("newTripStatus");
    newTripRequestReference!.set("waiting");
    newTripRequestReference!.onValue.listen((event) {});
  }

  setAndGetLocationUpdates() {
    positionStreamHomePage = Geolocator.getPositionStream().listen((
      Position position,
    ) {
      currentPositionOfUser = position;
      if (isDriverAvailable == true) {
        Geofire.setLocation(
          FirebaseAuth.instance.currentUser!.uid,
          currentPositionOfUser!.latitude,
          currentPositionOfUser!.longitude,
        );
      }

      LatLng positionLatLng = LatLng(position.latitude, position.longitude);
      controller!.animateCamera(CameraUpdate.newLatLng(positionLatLng));
    });
  }

  goOffline() {
    Geofire.removeLocation(FirebaseAuth.instance.currentUser!.uid);
    newTripRequestReference!.onDisconnect();
    newTripRequestReference!.remove();
    newTripRequestReference = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
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

          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isDismissible: false,
                      builder: (BuildContext context) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: whiteColor,
                            boxShadow: [
                              BoxShadow(
                                color: blackColor20,
                                blurRadius: 5.0,
                                spreadRadius: 0.5,
                                offset: Offset(0.7, 0.7),
                              ),
                            ],
                          ),
                          height: 222,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 18,
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 12),
                                Text(
                                  (!isDriverAvailable)
                                      ? "GO ONLINE NOW"
                                      : "GO OFFLINE NOW",
                                  style: const TextStyle(
                                    fontSize: 22,
                                    color: blackColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: defaultPadding),

                                Text(
                                  (!isDriverAvailable)
                                      ? "You are about to go online, you will be available to receive trip request from users."
                                      : "You are about to go offline, you will be unable to receive new trip requests from users.",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: blackColor60),
                                ),

                                const SizedBox(height: defaultPadding),

                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: primaryColor,
                                        ),
                                        child: const Text("Cancel"),
                                      ),
                                    ),

                                    const SizedBox(height: defaultPadding),

                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (!isDriverAvailable) {
                                            goOnline();
                                            setAndGetLocationUpdates();
                                            Navigator.pop(context);

                                            setState(() {
                                              colorToShow = successColor;
                                              titleToShow = "GO OFFLINE NOW";
                                              isDriverAvailable = true;
                                            });
                                          } else {
                                            goOffline();
                                            Navigator.pop(context);
                                            setState(() {
                                              colorToShow = primaryColor;
                                              titleToShow = "GO ONLINE NOW";
                                              isDriverAvailable = false;
                                            });
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              (titleToShow == "GO ONLINE NOW")
                                                  ? primaryClone
                                                  : successColor,
                                        ),
                                        child: const Text("Confirm"),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: colorToShow),
                  child: Text(titleToShow),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
