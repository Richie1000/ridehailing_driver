// import 'dart:async';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:geolocator/geolocator.dart';

// class CustomGeofireService {
//   static final CustomGeofireService _instance =
//       CustomGeofireService._internal();
//   factory CustomGeofireService() => _instance;

//   CustomGeofireService._internal();

//   StreamSubscription<Position>? _positionStream;
//   final _db = FirebaseDatabase.instance;
//   final _auth = FirebaseAuth.instance;

//   bool _isTracking = false;

//   Future<void> startTracking() async {
//     if (_isTracking) return;

//     final userId = _auth.currentUser?.uid;
//     if (userId == null) return;

//     final locationRef = _db.ref('onlineDrivers/$userId');

//     _positionStream = Geolocator.getPositionStream(
//       locationSettings: const LocationSettings(
//         accuracy: LocationAccuracy.high,
//         distanceFilter: 10,
//       ),
//     ).listen((Position position) {
//       locationRef.set({
//         'latitude': position.latitude,
//         'longitude': position.longitude,
//         'timestamp': DateTime.now().toIso8601String(),
//       });
//     });

//     _db.ref("drivers/$userId/newTripStatus").set("waiting");
//     _isTracking = true;
//   }

//   Future<void> stopTracking() async {
//     // final userId = _auth.currentUser?.uid;
//     // if (userId == null) return;

//     await _positionStream?.cancel();
//     _positionStream = null;
//     _isTracking = false;

//     // final locationRef = _db.ref('onlineDrivers/$userId');
//     // await locationRef.remove();

//     // final tripRef = _db.ref("drivers/$userId/newTripStatus");
//     // await tripRef.remove();
//   }

//   bool get isTracking => _isTracking;
// }

import 'dart:async';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ridehailing_driver/helper/geohash_util.dart';
import 'package:ridehailing_driver/models/nearby_driver.dart';

class CustomGeofireService {
  static final CustomGeofireService _instance =
      CustomGeofireService._internal();
  factory CustomGeofireService() => _instance;
  CustomGeofireService._internal();

  final _db = FirebaseDatabase.instance;
  final _auth = FirebaseAuth.instance;

  StreamSubscription<Position>? _positionStream;
  StreamController<List<NearbyDriver>>? _nearbyStreamController;
  Stream<List<NearbyDriver>>? _currentNearbyStream;
  Timer? _pollTimer;

  bool _isTracking = false;

  /// Start sending the current user's location to Firebase in real-time
  Future<void> startTracking() async {
    if (_isTracking) return;

    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    final locationRef = _db.ref('onlineDrivers/$userId');

    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((Position position) {
      final geohash = encodeGeohash(
        position.latitude,
        position.longitude,
        precision: 7,
      );
      locationRef.set({
        'latitude': position.latitude,
        'longitude': position.longitude,
        'geohash': geohash,
        'timestamp': DateTime.now().toIso8601String(),
      });
    });

    _db.ref("drivers/$userId/newTripStatus").set("waiting");
    _isTracking = true;
  }

  /// Stop sending location updates
  Future<void> stopTracking() async {
    await _positionStream?.cancel();
    _positionStream = null;
    _isTracking = false;
    _pollTimer?.cancel();
    _pollTimer = null;
    _nearbyStreamController?.close();
    _nearbyStreamController = null;
    _currentNearbyStream = null;
  }

  bool get isTracking => _isTracking;

  /// Real-time stream of nearby drivers based on radius in KM
  Stream<List<NearbyDriver>> nearbyDriversStream(
    double centerLat,
    double centerLng,
    double radiusKm,
  ) {
    if (_nearbyStreamController != null) return _currentNearbyStream!;

    _nearbyStreamController = StreamController<List<NearbyDriver>>.broadcast();
    _currentNearbyStream = _nearbyStreamController!.stream;

    _pollNearbyDrivers(centerLat, centerLng, radiusKm); // initial fetch
    _pollTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      _pollNearbyDrivers(centerLat, centerLng, radiusKm);
    });

    return _currentNearbyStream!;
  }

  Future<void> _pollNearbyDrivers(
    double centerLat,
    double centerLng,
    double radiusKm,
  ) async {
    final centerHash = encodeGeohash(centerLat, centerLng, precision: 7);
    final neighbors = geohashNeighbors(centerHash)..add(centerHash);
    final results = <NearbyDriver>[];

    for (final hash in neighbors) {
      final snapshot =
          await _db
              .ref('onlineDrivers')
              .orderByChild('geohash')
              .startAt(hash)
              .endAt('$hash~')
              .get();

      if (snapshot.exists) {
        for (final child in snapshot.children) {
          final data = child.value as Map;
          final lat = data['latitude']?.toDouble();
          final lng = data['longitude']?.toDouble();

          if (lat == null || lng == null) continue;

          final distance = _calculateDistance(centerLat, centerLng, lat, lng);
          if (distance <= radiusKm) {
            results.add(
              NearbyDriver(
                uid: child.key ?? 'unknown',
                latitude: lat,
                longitude: lng,
                distance: distance,
              ),
            );
          }
        }
      }
    }

    _nearbyStreamController?.add(results);
  }

  double _calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const R = 6371; // Earth radius in km
    final dLat = _degToRad(lat2 - lat1);
    final dLon = _degToRad(lon2 - lon1);

    final a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(_degToRad(lat1)) *
            cos(_degToRad(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c;
  }

  double _degToRad(double deg) => deg * pi / 180;
}
