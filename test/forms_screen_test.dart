import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forms/screens/forms_screens.dart';

Widget buildTestApp() {
  return const MaterialApp(home: FormsScreen());
}

void main() {
  group('FormsScreen initial state', () {
    testWidgets('fields are empty and terms checkbox is unchecked',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildTestApp());

      // All text fields should be empty
      final nameField = tester.widget<TextFormField>(
        find.byWidgetPredicate(
          (w) => w is TextFormField && w.controller?.text == '',
        ).first,
      );
      expect(nameField.controller?.text, '');

      expect(find.text('Enter your name'), findsOneWidget);
      expect(find.text('Enter your email'), findsOneWidget);
      expect(find.text('Enter your phone'), findsOneWidget);
      expect(find.text('Enter your secure password'), findsOneWidget);

      // Checkbox should be unchecked
      final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
      expect(checkbox.value, false);

      // Terms warning should be visible since checkbox is unchecked
      expect(find.text('First accept terms and conditions'), findsOneWidget);
    });
  });

  group('Name field validation', () {
    testWidgets('shows error when name is empty', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestApp());

      // Check the terms checkbox so only field validation matters
      await tester.tap(find.byType(Checkbox));
      await tester.pump();

      // Tap submit without entering a name
      await tester.tap(find.text('Send'));
      await tester.pump();

      expect(find.text('Name can not be empty'), findsOneWidget);
    });
  });

  group('Email field validation', () {
    testWidgets('shows error when email is empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildTestApp());

      await tester.tap(find.byType(Checkbox));
      await tester.pump();

      await tester.tap(find.text('Send'));
      await tester.pump();

      expect(find.text('Email can not be empty'), findsOneWidget);
    });

    testWidgets('shows error for invalid email format',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildTestApp());

      await tester.tap(find.byType(Checkbox));
      await tester.pump();

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Name'),
        'John',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Email'),
        'not-an-email',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Phone'),
        '12345678',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'),
        'password123',
      );

      await tester.tap(find.text('Send'));
      await tester.pump();

      expect(find.text('Please enter a valid email'), findsOneWidget);
    });
  });

  group('Phone field validation', () {
    Future<void> fillAndSubmitWithPhone(
      WidgetTester tester,
      String phone,
    ) async {
      await tester.pumpWidget(buildTestApp());

      await tester.tap(find.byType(Checkbox));
      await tester.pump();

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Name'),
        'John',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Email'),
        'john@example.com',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Phone'),
        phone,
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'),
        'password123',
      );

      await tester.tap(find.text('Send'));
      await tester.pump();
    }

    testWidgets('shows error when phone is empty',
        (WidgetTester tester) async {
      await fillAndSubmitWithPhone(tester, '');

      expect(find.text('Phone can not be empty'), findsOneWidget);
    });

    testWidgets('shows error for non-numeric phone',
        (WidgetTester tester) async {
      await fillAndSubmitWithPhone(tester, 'abcdefgh');

      expect(find.text('Please enter a valida phone'), findsOneWidget);
    });

    testWidgets('shows error for phone shorter than 8 digits',
        (WidgetTester tester) async {
      await fillAndSubmitWithPhone(tester, '1234567');

      expect(
        find.text('The phone number must have at least 8 digits'),
        findsOneWidget,
      );
    });

    testWidgets('shows error for phone longer than 10 digits',
        (WidgetTester tester) async {
      await fillAndSubmitWithPhone(tester, '12345678901');

      expect(
        find.text('The phone number can not exced 10 digits'),
        findsOneWidget,
      );
    });
  });

  group('Password field validation', () {
    Future<void> fillAndSubmitWithPassword(
      WidgetTester tester,
      String password,
    ) async {
      await tester.pumpWidget(buildTestApp());

      await tester.tap(find.byType(Checkbox));
      await tester.pump();

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Name'),
        'John',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Email'),
        'john@example.com',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Phone'),
        '12345678',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'),
        password,
      );

      await tester.tap(find.text('Send'));
      await tester.pump();
    }

    testWidgets('shows error when password is empty',
        (WidgetTester tester) async {
      await fillAndSubmitWithPassword(tester, '');

      expect(find.text('Password can not be empty'), findsOneWidget);
    });

    testWidgets('shows error for password shorter than 8 characters',
        (WidgetTester tester) async {
      await fillAndSubmitWithPassword(tester, 'short');

      expect(
        find.text('Password must have at least 8 characters'),
        findsOneWidget,
      );
    });
  });
}
