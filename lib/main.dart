import 'package:flutter/material.dart';
import 'package:forms/providers/form.providers.dart';
import 'package:forms/screens/forms_screens.dart';
import 'package:provider/provider.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => FormProvider())
    ],
    child: MyApp(),
  )
);


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange
      ),
      home: const FormsScreen(),
    );
  }
}