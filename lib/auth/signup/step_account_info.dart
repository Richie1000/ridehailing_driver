import 'package:flutter/material.dart';
import 'package:ridehailing_driver/providers/user_provider.dart';
import 'package:ridehailing_driver/theme/contants.dart';

class StepAccountInfo extends StatelessWidget {
  final UserProvider provider;

  const StepAccountInfo({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _customTextField(context, provider.email, 'Email', Icons.email),
        const SizedBox(height: defaultPadding),
        _customTextField(
          context,
          provider.password,
          'Password',
          Icons.lock,
          obscure: true,
        ),
        const SizedBox(height: defaultPadding),
        _customTextField(
          context,
          provider.Confirmedpassword,
          'Confirm Password',
          Icons.lock,
          obscure: true,
        ),
      ],
    );
  }

  Widget _customTextField(
    BuildContext context,
    TextEditingController controller,
    String hint,
    IconData icon, {
    bool obscure = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: Theme.of(context).primaryColor),
      ),
    );
  }
}
