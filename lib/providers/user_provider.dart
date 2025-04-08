import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ridehailing_driver/models/user.dart';
import 'package:ridehailing_driver/services/user_services.dart';
import 'package:ridehailing_driver/theme/contants.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserProvider with ChangeNotifier {
  static const String LOGGED_IN = "loggedIn";
  static const String ID = "id";

  final bool _isLoading = false;
  bool get isLoading => _isLoading;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Status _status = Status.Uninitialized;
  final UserServices _userServices = UserServices();
  late UserModel _userModel;

  UserModel get userModel => _userModel;
  Status get status => _status;
  FirebaseAuth get auth => _auth;

  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController Confirmedpassword = TextEditingController();

  UserProvider.initialize() {
    _initialize();
  }

  Future<bool> signIn(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _status = Status.Authenticating;
    notifyListeners();
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
      await preferences.setString(ID, userCredential.user!.uid);
      await preferences.setBool(LOGGED_IN, true);

      _userModel = await _userServices.getUserById(userCredential.user!.uid);
      _status = Status.Authenticated;
      notifyListeners();
      if (context.mounted) {
        showSnackBar(context, "Sign in successful");
      }
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      // Check if `context` is still mounted before showing a SnackBar
      if (context.mounted) {
        showSnackBar(context, "Error during sign in: ${e.toString()}");
      }
      return false;
    }
  }

  Future<bool> signUp(
    String email,
    String password,
    String fullName,
    String phone,
    BuildContext context,
  ) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString(ID, result.user!.uid);
      await preferences.setBool(LOGGED_IN, true);
      await _userServices.createUser(
        id: result.user!.uid,
        fullName: fullName,
        email: email,
        phone: phone,
        password: password,
      );
      _userModel = await _userServices.getUserById(result.user!.uid);
      _status = Status.Authenticated;
      notifyListeners();
      if (context.mounted) {
        showSnackBar(context, "Sign-up successful");
      }
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      // print("Error during sign up: $e");
      if (context.mounted) {
        showSnackBar(context, "Sign-up failed: ${e.toString()}");
      }
      return false;
    }
  }

  Future<void> signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await _auth.signOut();
    _status = Status.Unauthenticated;
    await preferences.remove(ID);
    await preferences.setBool(LOGGED_IN, false);
    notifyListeners();
  }

  Future<void> reloadUserModel() async {
    _userModel = await _userServices.getUserById(auth.currentUser!.uid);
    notifyListeners();
  }

  updateUserData(Map<String, dynamic> data) async {
    _userServices.updateUser(data);
  }

  _initialize() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool loggedIn = preferences.getBool(LOGGED_IN) ?? false;
    if (!loggedIn) {
      _status = Status.Unauthenticated;
    } else {
      auth.authStateChanges().listen((User? currentUser) async {
        if (currentUser != null) {
          _userModel = await _userServices.getUserById(currentUser.uid);
          _status = Status.Authenticated;
        } else {
          _status = Status.Unauthenticated;
        }
        notifyListeners();
      });
    }
    notifyListeners();
  }
}
