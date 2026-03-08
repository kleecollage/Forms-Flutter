import 'package:flutter/material.dart';
import 'package:forms/providers/form.providers.dart';
import 'package:forms/widgets/countries_widget.dart';
import 'package:forms/widgets/email_widget.dart';
import 'package:forms/widgets/name_field.dart';
import 'package:forms/widgets/password_widget.dart';
import 'package:forms/widgets/phone_widget.dart';
import 'package:forms/widgets/terms_checkbox.dart';
import 'package:provider/provider.dart';

class FormsScreen extends StatefulWidget {
  const FormsScreen({super.key});

  @override
  State<FormsScreen> createState() => _FormsScreensState();
}

class _FormsScreensState extends State<FormsScreen> {
  String? _selectedCountry;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormProvider>(context);

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
                  },
                ),
                // ##########   NAME INPUT   ########## //
                const SizedBox(height: 20),
                NameField(nameController: formProvider.nameController),
                // ##########   EMAIL INPUT   ########## //
                const SizedBox(height: 20),
                EmailField(emailController: formProvider.emailController),
                // ##########   PHONE INPUT   ########## //\
                const SizedBox(height: 20),
                PhoneField(phoneController: formProvider.phoneController),
                // ##########   PASSWORD INPUT   ########## //
                const SizedBox(height: 20),
                PasswordField(passwordController: formProvider.passwordController),
                // ##########   TERMS AND CONDITION CHECKBOX   ########## //
                const SizedBox(height: 20),
                TermsCheckbox(
                  value: formProvider.acceptTerms,
                  onChanged: (bool? value) {
                    formProvider.toogleAcceptTerms(value ?? false);
                  },
                ),
                if (!formProvider.acceptTerms)
                  const Text(
                    'First accept terms and conditions',
                    style: TextStyle(color: Colors.red),
                  ),
                // ##########   SUBMIT   ########## //
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (formProvider.validateForm(_formKey)) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('Form is OK! c:')));
                    } else if (!formProvider.acceptTerms) {
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
