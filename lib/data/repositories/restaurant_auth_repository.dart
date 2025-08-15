// data/repositories/restaurant_auth_repository.dart
class RestaurantAuthRepository {
  // Simulate a login for a restaurant owner
  Future<String> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (email == 'restaurant@test.com' && password == 'password') {
      // On success, return a mock restaurant ID
      return 'restaurant_123';
    } else {
      throw Exception('Invalid credentials. Please try again.');
    }
  }
}
