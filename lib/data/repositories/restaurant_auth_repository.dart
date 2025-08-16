class RestaurantAuthRepository {
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
