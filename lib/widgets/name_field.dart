import 'package:flutter/material.dart';

class NameField extends StatelessWidget {
  const NameField({super.key, required this.nameController});
  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
      decoration: InputDecoration(
        labelText: 'Name',
        hintText: 'Enter your name',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Name can not be empty';
        }
        return null;
      },
    );
  }
}
