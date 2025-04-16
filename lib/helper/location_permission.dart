import 'package:permission_handler/permission_handler.dart';

class LocationPermissions {
  static Future<PermissionStatus> requestLocationPermission() async {
    var permission = await Permission.locationWhenInUse.status;
    if (permission.isDenied || permission.isPermanentlyDenied) {
      permission = await Permission.locationWhenInUse.request();
    }
    return permission;
  }
}
