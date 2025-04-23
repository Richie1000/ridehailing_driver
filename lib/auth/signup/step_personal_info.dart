import 'package:flutter/material.dart';
import 'package:ridehailing_driver/auth/signup/terms_checkbox.dart';
import 'package:ridehailing_driver/providers/user_provider.dart';

import 'package:ridehailing_driver/theme/contants.dart';

class StepPersonalInfo extends StatelessWidget {
  final UserProvider provider;
  final bool isTermsAccepted;
  final void Function(bool?) onTermsChanged;

  const StepPersonalInfo({
    super.key,
    required this.provider,
    required this.isTermsAccepted,
    required this.onTermsChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _customTextField(context, provider.name, 'Full Name', Icons.person),
        const SizedBox(height: defaultPadding),
        _customTextField(context, provider.phone, 'Phone', Icons.phone),
        const SizedBox(height: defaultPadding),
        TermsCheckbox(isChecked: isTermsAccepted, onChanged: onTermsChanged),
        const SizedBox(height: defaultPadding),
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
