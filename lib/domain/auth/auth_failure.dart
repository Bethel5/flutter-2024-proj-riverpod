
class AuthFailure {
  final String message;

  const AuthFailure(this.message);

  factory AuthFailure.serverError() => AuthFailure("Server error occurred");
  factory AuthFailure.invalidEmailPassword() => AuthFailure("Invalid email or password");
  factory AuthFailure.emailAlreadyInUse() => AuthFailure("Email already in use");
  factory AuthFailure.weakPassword() => AuthFailure("The password is too weak");
  factory AuthFailure.userNotFound() => AuthFailure("User not found");
  factory AuthFailure.networkError() => AuthFailure("Network error occurred");
}
