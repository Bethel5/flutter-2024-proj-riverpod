import 'package:flutter/material.dart';
import 'package:flutter_pet_pal/presentation/screens/fav_page.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('FavoritesPage Widget Tests', () {
    testWidgets('should display the app bar with title and back button', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(MaterialApp(home: FavoritesPage()));

      // Act
      final backButton = find.byIcon(Icons.arrow_back);
      final title = find.text('Favorite Pets');

      // Assert
      expect(backButton, findsOneWidget);
      expect(title, findsOneWidget);
    });

    testWidgets('should display a list of favorite pets', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(MaterialApp(home: FavoritesPage()));

      // Act
      final petCards = find.byType(Card);

      // Assert
      expect(petCards, findsNWidgets(6));
    });

    testWidgets('should display pet details in each card', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(MaterialApp(home: FavoritesPage()));

      // Act & Assert
      expect(find.text('Fluffy'), findsOneWidget);
      expect(find.text('Breed: Siamese Cat'), findsOneWidget);
      expect(find.text('Whiskers'), findsOneWidget);
      expect(find.text('Breed: Cavalier King Charles Spaniel'), findsOneWidget);
      expect(find.text('Bunny'), findsOneWidget);
      expect(find.text('Breed: Holland Lop Rabbit'), findsOneWidget);
      expect(find.text('Max'), findsOneWidget);
      expect(find.text('Breed: German Shepherd'), findsOneWidget);
      expect(find.text('Luna'), findsOneWidget);
      expect(find.text('Breed: Maine Coon'), findsOneWidget);
    });

    testWidgets('should navigate back when back button is pressed', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(MaterialApp(home: FavoritesPage()));

      // Act
      final backButton = find.byIcon(Icons.arrow_back);
      await tester.tap(backButton);
      await tester.pumpAndSettle();

      // Assert
      // Assuming the initial route is empty, checking if there are no widgets in the tree
      expect(find.byType(FavoritesPage), findsNothing);
    });

    testWidgets('should display delete icon for each pet card', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(MaterialApp(home: FavoritesPage()));

      // Act
      final deleteIcons = find.byIcon(Icons.delete);

      // Assert
      expect(deleteIcons, findsNWidgets(6));
    });
  });
}
