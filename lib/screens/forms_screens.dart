import 'package:flutter/material.dart';
import 'package:forms/widgets/countries_widget.dart';
import 'package:forms/widgets/email_widget.dart';
import 'package:forms/widgets/name_field.dart';
import 'package:forms/widgets/password_widget.dart';
import 'package:forms/widgets/phone_widget.dart';
import 'package:forms/widgets/terms_checkbox.dart';

class FormsScreen extends StatefulWidget {
  const FormsScreen({super.key});

  @override
  State<FormsScreen> createState() => _FormsScreensState();
}

class _FormsScreensState extends State<FormsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _acceptTerms = false;
  String? _selectedCountry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text('My Form')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsetsGeometry.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // ##########   INPUT SELECTOR   ########## //
                CountriesSelector(
                  selectedCountry: _selectedCountry,
                  onChanged: (newValue) {
                    setState(() => _selectedCountry = newValue);
                  }
                ),
                // ##########   NAME INPUT   ########## //
                const SizedBox(height: 20),
                NameField(nameController: _nameController),
                // ##########   EMAIL INPUT   ########## //
                const SizedBox(height: 20),
                EmailField(emailController: _emailController),
                // ##########   PHONE INPUT   ########## //\
                const SizedBox(height: 20),
                PhoneField(phoneController: _phoneController),
                // ##########   PASSWORD INPUT   ########## //
                const SizedBox(height: 20),
                PasswordField(passwordController: _passwordController),
                // ##########   TERMS AND CONDITION CHECKBOX   ########## //
                const SizedBox(height: 20),
                TermsCheckbox(
                  value: _acceptTerms,
                  onChanged: (bool? value) {
                    setState(() {
                      _acceptTerms = value ?? false;
                    });
                  },
                ),
                if (!_acceptTerms)
                  const Text(
                    'First accept terms and conditions',
                    style: TextStyle(color: Colors.red),
                  ),
                // ##########   SUBMIT   ########## //
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() && _acceptTerms) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('Form is OK! c:')));
                    } else if (!_acceptTerms) {
                      setState(() {});
                    }
                  },
                  child: const Text('Send'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
