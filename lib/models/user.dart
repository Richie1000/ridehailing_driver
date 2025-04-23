import 'package:firebase_database/firebase_database.dart';

class UserModel {
  static const String ID = "id";
  static const String FullNAME = "fullName";
  static const String EMAIL = "email";
  static const String PHONE = "phone";
  static const String PASSWORD = "password";
  static const String ROLE = "role";
  static const String VEHICLEMODEL = "vehicleModel";
  static const String VEHICLECOLOR = "vehicleColor";
  static const String VEHICLEREGISTRATIONNUMBER = "vehicleRegistrationNumber";

  static const String DOCUMENTS = "documents";
  static const String GHANA_CARD = "ghanaCard";
  static const String INSURANCE = "insurance";
  static const String ROADWORTHINESS = "roadworthiness";
  static const String VIT = "vit";

  late String _id;
  late String _fullName;
  late String _email;
  late String _phone;
  late String _password;
  late String _role;
  late String _vehicleModel;
  late String _vehicleColor;
  late String _vehicleRegistrationNumber;

  String? _ghanaCardUrl;
  String? _insuranceUrl;
  String? _roadworthinessUrl;
  String? _vitUrl;

  String get id => _id;
  String get email => _email;
  String get fullName => _fullName;
  String get phone => _phone;
  String get password => _password;
  String get role => _role;
  String get vehicleModel => _vehicleModel;
  String get vehicleColor => _vehicleColor;
  String get vehicleRegistrationNumber => _vehicleRegistrationNumber;

  String? get ghanaCardUrl => _ghanaCardUrl;
  String? get insuranceUrl => _insuranceUrl;
  String? get roadworthinessUrl => _roadworthinessUrl;
  String? get vitUrl => _vitUrl;

  UserModel.fromSnapshot(DataSnapshot snapshot) {
    Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;

    _id = data[ID] ?? '';
    _fullName = data[FullNAME] ?? '';
    _email = data[EMAIL] ?? '';
    _phone = data[PHONE] ?? '';
    _password = data[PASSWORD] ?? '';
    _role = data[ROLE] ?? '';
    _vehicleModel = data[VEHICLEMODEL] ?? '';
    _vehicleColor = data[VEHICLECOLOR] ?? '';
    _vehicleRegistrationNumber = data[VEHICLEREGISTRATIONNUMBER] ?? '';

    // Handle nested document data safely
    final docs = data[DOCUMENTS] as Map<dynamic, dynamic>?;

    _ghanaCardUrl = docs?[GHANA_CARD];
    _insuranceUrl = docs?[INSURANCE];
    _roadworthinessUrl = docs?[ROADWORTHINESS];
    _vitUrl = docs?[VIT];
  }
}
