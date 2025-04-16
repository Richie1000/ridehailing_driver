import 'package:flutter/material.dart';

class TermsCheckbox extends StatelessWidget {
  final bool isChecked;
  final void Function(bool?) onChanged;

  const TermsCheckbox({
    super.key,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(value: isChecked, onChanged: onChanged),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black),
              children: [
                const TextSpan(text: "By registering, you agree to our "),
                TextSpan(
                  text: "Terms of Service",
                  style: const TextStyle(
                    color: Colors.green,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const TextSpan(text: " and "),
                TextSpan(
                  text: "Privacy Policy",
                  style: const TextStyle(
                    color: Colors.green,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const TextSpan(
                  text:
                      ", and commit to comply with applicable laws in Ghana. You also agree to provide only legal services and content on the taxi platform.",
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
