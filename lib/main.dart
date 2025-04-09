import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ridehailing_driver/auth/login_screen.dart';
import 'package:ridehailing_driver/providers/app_provider.dart';
import 'package:ridehailing_driver/providers/user_provider.dart';
import 'package:ridehailing_driver/theme/app_theme.dart';
import 'package:ridehailing_driver/views/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    //await LocationPermissions.requestLocationPermission();
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<AppProvider>.value(value: AppProvider()),
          ChangeNotifierProvider<UserProvider>(
            create: (_) => UserProvider.initialize(),
          ),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MyApp(),
        ),
      ),
    );
  } catch (e) {
    throw (" Firebase initialization failed: $e");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider auth = Provider.of<UserProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(),
      home: _getScreen(auth),
    );
  }

  Widget _getScreen(UserProvider auth) {
    switch (auth.status) {
      //   // case Status.Uninitialized:
      //   //   return const Splash();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return LoginScreen();
      case Status.Authenticated:
        return HomeScreen();
      default:
        return LoginScreen();
    }
  }
}
