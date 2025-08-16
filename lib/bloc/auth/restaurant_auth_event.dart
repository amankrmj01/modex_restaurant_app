import 'package:equatable/equatable.dart';

abstract class RestaurantAuthEvent extends Equatable {
  const RestaurantAuthEvent();

  @override
  List<Object> get props => [];
}

class RestaurantLoginRequested extends RestaurantAuthEvent {
  final String email;
  final String password;

  const RestaurantLoginRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
