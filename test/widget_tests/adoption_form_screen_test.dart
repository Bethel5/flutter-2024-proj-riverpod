import 'package:flutter/material.dart';
import 'package:flutter_pet_pal/presentation/screens/adoption_form.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AdoptionFormScreen Widget Tests', () {
    testWidgets('should display form fields and submit button', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(MaterialApp(home: AdoptionFormScreen()));

      // Act
      final fullNameField = find.byType(TextFormField).at(0);
      final addressField = find.byType(TextFormField).at(1);
      final phoneNumberField = find.byType(TextFormField).at(2);
      final petTypeDropdown = find.byType(DropdownButtonFormField<String>).at(0);
      final genderDropdown = find.byType(DropdownButtonFormField<String>).at(1);
      final ageRangeDropdown = find.byType(DropdownButtonFormField<String>).at(2);
      final experienceField = find.byType(TextFormField).at(3);
      final submitButton = find.byType(ElevatedButton);

      // Assert
      expect(fullNameField, findsOneWidget);
      expect(addressField, findsOneWidget);
      expect(phoneNumberField, findsOneWidget);
      expect(petTypeDropdown, findsOneWidget);
      expect(genderDropdown, findsOneWidget);
      expect(ageRangeDropdown, findsOneWidget);
      expect(experienceField, findsOneWidget);
      expect(submitButton, findsOneWidget);
    });

    testWidgets('should display correct labels in form fields and dropdowns', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(MaterialApp(home: AdoptionFormScreen()));

      // Act
      final fullNameLabel = find.text('Full Name');
      final addressLabel = find.text('Address');
      final phoneNumberLabel = find.text('Phone Number');
      final petTypeLabel = find.text('Type of Pet');
      final genderLabel = find.text('Gender');
      final ageRangeLabel = find.text('Age Range');
      final experienceLabel = find.text('Previous Pet Ownership Experience');

      // Assert
      expect(fullNameLabel, findsOneWidget);
      expect(addressLabel, findsOneWidget);
      expect(phoneNumberLabel, findsOneWidget);
      expect(petTypeLabel, findsOneWidget);
      expect(genderLabel, findsOneWidget);
      expect(ageRangeLabel, findsOneWidget);
      expect(experienceLabel, findsOneWidget);
    });

    testWidgets('should be able to input text in form fields and select dropdown options', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(MaterialApp(home: AdoptionFormScreen()));

      // Act
      await tester.enterText(find.byType(TextFormField).at(0), 'John Doe');
      await tester.enterText(find.byType(TextFormField).at(1), '123 Main St');
      await tester.enterText(find.byType(TextFormField).at(2), '1234567890');
      await tester.tap(find.byType(DropdownButtonFormField<String>).at(0));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Dog').last);
      await tester.pumpAndSettle();
      await tester.tap(find.byType(DropdownButtonFormField<String>).at(1));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Male').last);
      await tester.pumpAndSettle();
      await tester.tap(find.byType(DropdownButtonFormField<String>).at(2));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Young').last);
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField).at(3), 'Yes, I have had pets before.');

      // Assert
      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('123 Main St'), findsOneWidget);
      expect(find.text('1234567890'), findsOneWidget);
      expect(find.text('Dog'), findsOneWidget);
      expect(find.text('Male'), findsOneWidget);
      expect(find.text('Young'), findsOneWidget);
      expect(find.text('Yes, I have had pets before.'), findsOneWidget);
    });
  });
}
