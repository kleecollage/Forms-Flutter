import 'package:flutter/material.dart';

class PhoneField extends StatelessWidget {
  const PhoneField({super.key, required this.phoneController});
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: phoneController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Phone',
        hintText: 'Enter your phone',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Phone can not be empty';
        }
        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
          return 'Please enter a valida phone';
        }
        if (value.length > 10) {
          return 'The phone number can not exced 10 digits';
        }
        if (value.length < 8) {
          return 'The phone number must have at least 8 digits';
        }
        return null;
      },
    );
  }
}
