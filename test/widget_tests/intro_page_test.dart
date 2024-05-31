import 'package:flutter/material.dart';
import 'package:flutter_pet_pal/presentation/screens/intro_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('IntroPage Widget Tests', () {
    testWidgets('should display the shop name, image, title, subtitle, and button', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(MaterialApp(home: IntroPage()));

      // Act
      final shopName = find.text('PET PAL');
      final image = find.byType(Image);
      final title = find.text('FIND YOUR FURRY FRIEND!');
      final subtitle = find.textContaining("Whether you're looking for a playful puppy");
      final getStartedButton = find.text('Get Started');

      // Assert
      expect(shopName, findsOneWidget);
      expect(image, findsOneWidget);
      expect(title, findsOneWidget);
      expect(subtitle, findsOneWidget);
      expect(getStartedButton, findsOneWidget);
    });

  });
}
