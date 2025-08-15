// ----------------------------------------------------------------
// bloc/orders/incoming_orders_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/order_management_repository.dart';
import 'incoming_orders_event.dart';
import 'incoming_orders_state.dart';

class IncomingOrdersBloc
    extends Bloc<IncomingOrdersEvent, IncomingOrdersState> {
  final OrderManagementRepository orderRepository;

  IncomingOrdersBloc({required this.orderRepository})
    : super(IncomingOrdersInitial()) {
    on<FetchIncomingOrders>(_onFetchIncomingOrders);
  }

  void _onFetchIncomingOrders(
    FetchIncomingOrders event,
    Emitter<IncomingOrdersState> emit,
  ) async {
    emit(IncomingOrdersLoading());
    try {
      final orders = await orderRepository.fetchIncomingOrders();
      emit(IncomingOrdersLoaded(orders: orders));
    } catch (e) {
      emit(IncomingOrdersError(message: e.toString()));
    }
  }
}
