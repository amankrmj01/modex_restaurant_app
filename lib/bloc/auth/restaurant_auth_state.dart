import 'package:equatable/equatable.dart';

abstract class RestaurantAuthState extends Equatable {
  const RestaurantAuthState();

  @override
  List<Object?> get props => [];
}

class RestaurantAuthInitial extends RestaurantAuthState {}

class RestaurantAuthLoading extends RestaurantAuthState {}

class RestaurantAuthSuccess extends RestaurantAuthState {
  final String restaurantId;

  const RestaurantAuthSuccess({required this.restaurantId});

  @override
  List<Object?> get props => [restaurantId];
}

class RestaurantAuthFailure extends RestaurantAuthState {
  final String error;

  const RestaurantAuthFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
