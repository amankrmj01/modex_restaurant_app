import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/order_management_repository.dart';
import 'order_action_event.dart';
import 'order_action_state.dart';

class OrderActionBloc extends Bloc<OrderActionEvent, OrderActionState> {
  final OrderManagementRepository orderRepository;

  OrderActionBloc({required this.orderRepository})
    : super(OrderActionInitial()) {
    on<AcceptOrder>(_onAcceptOrder);
    on<RejectOrder>(_onRejectOrder);
  }

  Future<void> _onAcceptOrder(
    AcceptOrder event,
    Emitter<OrderActionState> emit,
  ) async {
    emit(OrderActionInProgress());
    try {
      await orderRepository.acceptOrder(event.orderId);
      emit(const OrderActionSuccess('Order Accepted'));
    } catch (e) {
      emit(OrderActionFailure(e.toString()));
    }
  }

  Future<void> _onRejectOrder(
    RejectOrder event,
    Emitter<OrderActionState> emit,
  ) async {
    emit(OrderActionInProgress());
    try {
      await orderRepository.rejectOrder(event.orderId);
      emit(const OrderActionSuccess('Order Rejected'));
    } catch (e) {
      emit(OrderActionFailure(e.toString()));
    }
  }
}
