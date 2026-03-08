import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({super.key, required this.passwordController});
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your secure password',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password can not be empty';
        }
        if (value.length < 8) {
          return 'Password must have at least 8 characters';
        }
        return null;
      },
    );
  }
}
