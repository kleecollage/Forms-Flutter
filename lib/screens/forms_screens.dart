import 'package:flutter/material.dart';

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
  List<String> countries = [
    'Argentina',
    'Venezuela',
    'Cuba',
    'Bolivia',
    'Chile',
    'Uruguay',
  ];

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
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Select your country'),
                  initialValue: _selectedCountry,
                  items: countries.map((String country) {
                    return DropdownMenuItem(
                      value: country,
                      child: Text(country),
                    );
                  }).toList(),
                  onChanged: ((String? newValue) {
                    setState(() {
                      _selectedCountry = newValue;
                    });
                  }),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your country';
                    }
                    return null;
                  },
                ),
                // ##########   NAME INPUT   ########## //
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
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
                ),
                // ##########   EMAIL INPUT   ########## //
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email can not be empty';
                    }
                    if (!RegExp(
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.'
                      r'[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
                    ).hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                // ##########   PHONE INPUT   ########## //\
                const SizedBox(height: 20),
                TextFormField(
                  controller: _phoneController,
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
                ),
                // ##########   PASSWORD INPUT   ########## //
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
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
                ),
                // ##########   TERMS AND CONDITION CHECKBOX   ########## //
                const SizedBox(height: 20),
                Row(
                  children: [
                    Checkbox(
                      value: _acceptTerms,
                      onChanged: (bool? value) {
                        setState(() {
                          _acceptTerms = !_acceptTerms;
                        });
                      },
                    ),
                    const Text('Agree with terms and conditions'),
                  ],
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
