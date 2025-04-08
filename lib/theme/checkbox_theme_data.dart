import 'package:flutter/material.dart';
import 'package:ridehailing_driver/theme/contants.dart';

CheckboxThemeData checkboxThemeData = CheckboxThemeData(
  checkColor: WidgetStateProperty.all(Colors.white),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadious / 2)),
  ),
  side: const BorderSide(color: whileColor40),
);
