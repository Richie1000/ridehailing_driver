import 'package:flutter/material.dart';
import 'package:ridehailing_driver/providers/user_provider.dart';
import 'package:ridehailing_driver/theme/contants.dart';

class StepVehicleInfo extends StatelessWidget {
  final UserProvider provider;

  const StepVehicleInfo({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _customTextField(
          context,
          provider.vehicleModel,
          'Vehicle Model',
          Icons.directions_car,
        ),
        const SizedBox(height: defaultPadding),
        _customTextField(
          context,
          provider.vehicleColor,
          'Vehicle Color',
          Icons.palette,
        ),
        const SizedBox(height: defaultPadding),
        _customTextField(
          context,
          provider.vehicleRegistrationNumber,
          'Licence plate',
          Icons.confirmation_number,
        ),
        const SizedBox(height: defaultPadding),
        _customTextField(
          context,
          provider.vehicleRegistrationNumber,
          'Vehicle color',
          Icons.confirmation_number,
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
