import 'package:equatable/equatable.dart';

abstract class OrderActionState extends Equatable {
  const OrderActionState();

  @override
  List<Object> get props => [];
}

class OrderActionInitial extends OrderActionState {}

class OrderActionInProgress extends OrderActionState {}

class OrderActionSuccess extends OrderActionState {
  final String message;

  const OrderActionSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class OrderActionFailure extends OrderActionState {
  final String error;

  const OrderActionFailure(this.error);

  @override
  List<Object> get props => [error];
}
