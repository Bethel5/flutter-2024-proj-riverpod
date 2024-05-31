import 'package:flutter_test/flutter_test.dart';

class User {
  final String id;
  final String email;
  final String fullName;
  final String role;

  User({
    required this.id,
    required this.email,
    required this.fullName,
    required this.role,
  });
}

void main() {
  group('User', () {
    test('User instance creation', () {
      final user = User(
        id: '123',
        email: 'test@example.com',
        fullName: 'John Doe',
        role: 'admin',
      );

      expect(user.id, '123');
      expect(user.email, 'test@example.com');
      expect(user.fullName, 'John Doe');
      expect(user.role, 'admin');
    });

    test('User inequality', () {
      final user1 = User(
        id: '123',
        email: 'test@example.com',
        fullName: 'John Doe',
        role: 'admin',
      );

      final user2 = User(
        id: '124',
        email: 'test2@example.com',
        fullName: 'Jane Doe',
        role: 'user',
      );

      expect(user1, isNot(equals(user2)));
    });
  });
}
