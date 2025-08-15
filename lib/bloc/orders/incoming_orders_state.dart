// ----------------------------------------------------------------
// bloc/orders/incoming_orders_state.dart
import 'package:equatable/equatable.dart';
import '../../data/models/order_model.dart';

abstract class IncomingOrdersState extends Equatable {
  const IncomingOrdersState();

  @override
  List<Object?> get props => [];
}

class IncomingOrdersInitial extends IncomingOrdersState {}

class IncomingOrdersLoading extends IncomingOrdersState {}

class IncomingOrdersLoaded extends IncomingOrdersState {
  final List<OrderModel> orders;

  const IncomingOrdersLoaded({required this.orders});

  @override
  List<Object?> get props => [orders];
}

class IncomingOrdersError extends IncomingOrdersState {
  final String message;

  const IncomingOrdersError({required this.message});

  @override
  List<Object?> get props => [message];
}
