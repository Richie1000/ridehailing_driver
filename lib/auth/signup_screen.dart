import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ridehailing_driver/auth/login_screen.dart';
import 'package:ridehailing_driver/providers/user_provider.dart';
import 'package:ridehailing_driver/theme/contants.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    UserProvider authProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo
                Center(
                  child: Image.asset(
                    'assets/images/Illustration.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: defaultPadding / 4),
                // Heading
                // Text(
                //   'Create an Account',
                //   style: Theme.of(context).textTheme.titleLarge?.copyWith(
                //         fontWeight: FontWeight.bold,
                //         color: blackColor,
                //       ),
                // ),
                const SizedBox(height: defaultPadding),

                // Full Name Input
                TextField(
                  controller: authProvider.name,
                  decoration: InputDecoration(
                    hintText: 'Full Name',
                    prefixIcon: Icon(Icons.person, color: primaryColor),
                  ),
                ),
                const SizedBox(height: defaultPadding),

                // Email Input
                TextField(
                  controller: authProvider.email,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.email, color: primaryColor),
                  ),
                ),
                const SizedBox(height: defaultPadding),

                // Password Input
                TextField(
                  controller: authProvider.phone,
                  //obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'phone',
                    prefixIcon: Icon(Icons.phone, color: primaryColor),
                  ),
                ),
                const SizedBox(height: defaultPadding),

                // Confirm Password Input
                TextField(
                  controller: authProvider.password,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock, color: primaryColor),
                  ),
                ),
                const SizedBox(height: defaultPadding),

                TextField(
                  controller: authProvider.Confirmedpassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'confirm Password',
                    prefixIcon: Icon(Icons.lock, color: primaryColor),
                  ),
                ),
                const SizedBox(height: defaultPadding),

                // Sign Up Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        authProvider.isLoading
                            ? null
                            : () async {
                              if (authProvider.password.text !=
                                  authProvider.Confirmedpassword.text) {
                                showSnackBar(context, "Password do not match!");
                                return;
                              }

                              bool success = await authProvider.signUp(
                                authProvider.email.text.trim(),
                                authProvider.password.text.trim(),
                                authProvider.name.text.trim(),
                                authProvider.phone.text.trim(),
                                context,
                              );

                              if (success && context.mounted) {
                                showSnackBar(
                                  context,
                                  "Account created successfully!",
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const LoginScreen();
                                    },
                                  ),
                                );
                              }
                            },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: defaultPadding),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const LoginScreen();
                            },
                          ),
                        );
                      },
                      child: const Text('Login here'),
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
