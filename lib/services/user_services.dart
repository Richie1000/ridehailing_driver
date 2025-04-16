import 'package:firebase_database/firebase_database.dart';
import 'package:ridehailing_driver/models/user.dart';

class UserServices {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref("users");

  Future<void> createUser({
    required String id,
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required String role,
    required String vehicleModel,
    required String vehicleColor,
    required String vehicleRegistrationNumber,
    required String ghanaCardUrl,
    required String insuranceUrl,
    required String roadworthinessUrl,
    required String vitUrl,
  }) async {
    await _dbRef.child(id).set({
      "id": id,
      "fullName": fullName,
      "email": email,
      "phone": phone,
      "password": password,
      "role": role,
      "vehicleModel": vehicleModel,
      "vehicleColor": vehicleColor,
      "vehicleRegistrationNumber": vehicleRegistrationNumber,
      "documents": {
        "ghanaCard": ghanaCardUrl,
        "insurance": insuranceUrl,
        "roadworthiness": roadworthinessUrl,
        "vit": vitUrl,
      },
    });
  }

  void updateUser(Map<String, dynamic> value) {
    _dbRef.child(value['id']).update(value);
  }

  Future<UserModel> getUserById(String id) async {
    final snapshot = await _dbRef.child(id).get();
    if (snapshot.exists) {
      return UserModel.fromSnapshot(snapshot);
    } else {
      throw Exception("User not found");
    }
  }

  void addDeviceToken({required String token, required String userId}) {
    _dbRef.child(userId).update({"token": token});
  }
}
