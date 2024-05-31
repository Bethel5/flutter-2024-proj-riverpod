import 'package:flutter/material.dart';
import 'package:flutter_pet_pal/presentation/screens/FormScreen.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('FormScreen Widget Tests', () {
    testWidgets('should display form fields and button', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(MaterialApp(home: FormScreen()));

      // Act
      final nameField = find.byType(TextField).at(0);
      final ageField = find.byType(TextField).at(1);
      final speciesField = find.byType(TextField).at(2);
      final genderField = find.byType(TextField).at(3);
      final addButton = find.byType(ElevatedButton);

      // Assert
      expect(nameField, findsOneWidget);
      expect(ageField, findsOneWidget);
      expect(speciesField, findsOneWidget);
      expect(genderField, findsOneWidget);
      expect(addButton, findsOneWidget);
    });

    testWidgets('should display correct labels', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(MaterialApp(home: FormScreen()));

      // Act
      final nameLabel = find.text('Name');
      final ageLabel = find.text('Age');
      final speciesLabel = find.text('Species');
      final genderLabel = find.text('Gender');
      final doneButton = find.text('Done');

      // Assert
      expect(nameLabel, findsOneWidget);
      expect(ageLabel, findsOneWidget);
      expect(speciesLabel, findsOneWidget);
      expect(genderLabel, findsOneWidget);
      expect(doneButton, findsOneWidget);
    });

    testWidgets('should be able to input text in form fields', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(MaterialApp(home: FormScreen()));

      // Act
      await tester.enterText(find.byType(TextField).at(0), 'Buddy');
      await tester.enterText(find.byType(TextField).at(1), '2');
      await tester.enterText(find.byType(TextField).at(2), 'Dog');
      await tester.enterText(find.byType(TextField).at(3), 'Male');

      // Assert
      expect(find.text('Buddy'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
      expect(find.text('Dog'), findsOneWidget);
      expect(find.text('Male'), findsOneWidget);
    });
  });
}
