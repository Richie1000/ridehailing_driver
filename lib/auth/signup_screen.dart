import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ridehailing_driver/auth/auth_result.dart';
import 'package:ridehailing_driver/auth/login_screen.dart';
import 'package:ridehailing_driver/providers/user_provider.dart';
import 'package:ridehailing_driver/theme/contants.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isLoading = false;

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

                // Phone Input
                TextField(
                  controller: authProvider.phone,
                  decoration: InputDecoration(
                    hintText: 'Phone',
                    prefixIcon: Icon(Icons.phone, color: primaryColor),
                  ),
                ),
                const SizedBox(height: defaultPadding),

                // Password Input
                TextField(
                  controller: authProvider.password,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock, color: primaryColor),
                  ),
                ),
                const SizedBox(height: defaultPadding),

                // Confirm Password Input
                TextField(
                  controller: authProvider.Confirmedpassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    prefixIcon: Icon(Icons.lock, color: primaryColor),
                  ),
                ),
                const SizedBox(height: defaultPadding),

                // Sign Up Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        _isLoading
                            ? null
                            : () async {
                              if (authProvider.password.text !=
                                  authProvider.Confirmedpassword.text) {
                                showSnackBar(
                                  context,
                                  "Passwords do not match!",
                                );
                                return;
                              }

                              setState(() {
                                _isLoading = true;
                              });

                              // Calling the signUp method
                              AuthResult result = await authProvider.signUp(
                                authProvider.email.text.trim(),
                                authProvider.password.text.trim(),
                                authProvider.name.text.trim(),
                                authProvider.phone.text.trim(),
                              );

                              if (!mounted) return;

                              setState(() {
                                _isLoading = false;
                              });

                              if (result is AuthSuccess) {
                                if (context.mounted) {
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
                              } else if (result is AuthFailure) {
                                if (context.mounted) {
                                  showSnackBar(context, result.message);
                                }
                              }
                            },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child:
                        _isLoading
                            ? const CircularProgressIndicator(
                              color: primaryColor,
                            )
                            : const Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
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
