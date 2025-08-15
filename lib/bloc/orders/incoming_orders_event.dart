// ----------------------------------------------------------------
// bloc/orders/incoming_orders_event.dart
import 'package:equatable/equatable.dart';

abstract class IncomingOrdersEvent extends Equatable {
  const IncomingOrdersEvent();

  @override
  List<Object> get props => [];
}

class FetchIncomingOrders extends IncomingOrdersEvent {}
