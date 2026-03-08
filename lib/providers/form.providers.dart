import 'package:flutter/material.dart';

class FormProvider extends ChangeNotifier {
  // controllers for each field
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool acceptTerms = false;

  // methods: Validate fields
  bool validateForm(GlobalKey<FormState> formKey) {
    return (formKey.currentState!.validate() && acceptTerms) ? true : false;
  }

  // method: Change chackbox status
  void toogleAcceptTerms(bool value) {
    acceptTerms = value;
    notifyListeners();
  }

  // method: Reset form
  void resetForm() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
    acceptTerms = false;
    notifyListeners();
  }
}
