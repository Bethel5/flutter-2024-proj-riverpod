import 'package:flutter/material.dart';
import 'package:flutter_pet_pal/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Navigation Flow Test', (WidgetTester tester) async {
    await tester.pumpWidget(ProviderScope(child: MyApp()));

    await tester.pumpAndSettle();

    expect(find.text('Get Started'), findsOneWidget);

    await tester.ensureVisible(find.text('Get Started'));

    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    expect(find.text('Sign Up'), findsOneWidget);

    await tester.ensureVisible(find.text('Sign Up'));

    await tester.tap(find.text('Sign Up'));
    await tester.pumpAndSettle();


    debugPrint('Current page: SignupPage');
    debugPrint(tester.binding.renderViewElement!.toStringDeep()); 

    expect(find.text('Enter your full name'), findsOneWidget);

    final fullNameField = find.widgetWithText(TextField, 'Enter your full name');
    final emailField = find.widgetWithText(TextField, 'Enter your email');
    final passwordField = find.widgetWithText(TextField, 'Enter your password');
    final confirmPasswordField = find.widgetWithText(TextField, 'Confirm Password');

    expect(fullNameField, findsOneWidget);
    expect(emailField, findsOneWidget);
    expect(passwordField, findsOneWidget);
    expect(confirmPasswordField, findsOneWidget);

    await tester.enterText(fullNameField, 'Joo Doe');
    await tester.enterText(emailField, 'joodoe@example.com');
    await tester.enterText(passwordField, 'password123');
    await tester.enterText(confirmPasswordField, 'password123');

    final signUpButton = find.text('Sign Up');
    await tester.ensureVisible(signUpButton);
    await tester.tap(signUpButton);
    await tester.pumpAndSettle();

    
  });
}
