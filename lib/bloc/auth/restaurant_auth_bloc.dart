// ----------------------------------------------------------------
// bloc/auth/restaurant_auth_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/restaurant_auth_repository.dart';
import 'restaurant_auth_event.dart';
import 'restaurant_auth_state.dart';

class RestaurantAuthBloc
    extends Bloc<RestaurantAuthEvent, RestaurantAuthState> {
  final RestaurantAuthRepository authRepository;

  RestaurantAuthBloc({required this.authRepository})
    : super(RestaurantAuthInitial()) {
    on<RestaurantLoginRequested>(_onLoginRequested);
  }

  void _onLoginRequested(
    RestaurantLoginRequested event,
    Emitter<RestaurantAuthState> emit,
  ) async {
    emit(RestaurantAuthLoading());
    try {
      final restaurantId = await authRepository.login(
        event.email,
        event.password,
      );
      emit(RestaurantAuthSuccess(restaurantId: restaurantId));
    } catch (e) {
      emit(RestaurantAuthFailure(error: e.toString()));
    }
  }
}
