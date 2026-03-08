import 'package:flutter/material.dart';

class CountriesSelector extends StatelessWidget {
  const CountriesSelector({
    super.key,
    required this.selectedCountry,
    required this.onChanged
  });

  final String? selectedCountry;
  final ValueChanged<String?> onChanged;
  final List<String> countries = const [
    'Argentina', 'Venezuela', 'Cuba', 'Bolivia', 'Chile', 'Uruguay'
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(labelText: 'Select your country'),
      initialValue: selectedCountry,
      items: countries.map((String country) {
        return DropdownMenuItem(value: country, child: Text(country));
      }).toList(),
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select your country';
        }
        return null;
      },
    );
  }
}
