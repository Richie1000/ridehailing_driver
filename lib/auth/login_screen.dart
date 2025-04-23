import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ridehailing_driver/auth/auth_result.dart';
import 'package:ridehailing_driver/auth/signup/signup_screen.dart';
import 'package:ridehailing_driver/entry_point.dart';
import 'package:ridehailing_driver/providers/user_provider.dart';
import 'package:ridehailing_driver/theme/contants.dart';
import 'package:ridehailing_driver/views/home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    UserProvider authProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/Illustration.png',
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: defaultPadding),
                TextField(
                  controller: authProvider.email,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.email, color: primaryColor),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: authProvider.password,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock, color: primaryColor),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Implement forgot password if needed
                    },
                    child: const Text('Forgot Password?'),
                  ),
                ),
                const SizedBox(height: defaultPadding),
                ElevatedButton(
                  onPressed: () async {
                    final result = await authProvider.signIn('driver');
                    switch (result) {
                      case AuthSuccess():
                        if (context.mounted) {
                          showSnackBar(context, "Sign in successful");
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const EntryPoint(),
                            ),
                          );
                        }
                        break;

                      case AuthFailure(:final message):
                        if (context.mounted) {
                          showSnackBar(context, message);
                        }
                        break;
                    }
                  },
                  child: const Text('Login'),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const SignupScreen();
                            },
                          ),
                        );
                      },
                      child: const Text('Sign Up Here'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
