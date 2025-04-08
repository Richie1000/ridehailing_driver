import 'package:firebase_database/firebase_database.dart';

class UserModel {
  static const String ID = "id";
  static const String FullNAME = "fullName";
  static const String EMAIL = "email";
  static const String PHONE = "phone";
  static const String PASSWORD = "password";

  late String _id;
  late String _fullName;
  late String _email;
  late String _phone;
  late String _password;

  String get id => _id;
  String get email => _email;
  String get fullName => _fullName;
  String get phone => _phone;
  String get password => _password;

  UserModel.fromSnapshot(DataSnapshot snapshot) {
    Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;

    _id = data[ID];
    _fullName = data[FullNAME];
    _email = data[EMAIL];
    _phone = data[PHONE];
    _password = data[PASSWORD];
  }
}
