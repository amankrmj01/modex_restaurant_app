// ----------------------------------------------------------------
// data/models/order_model.dart
import 'package:equatable/equatable.dart';
import 'cart_item_model.dart';

class OrderModel extends Equatable {
  final String id;
  final List<CartItemModel> items;
  final double totalPrice;
  final String status;
  final DateTime date;
  final String userId; // To know which user placed the order

  const OrderModel({
    required this.id,
    required this.items,
    required this.totalPrice,
    required this.status,
    required this.date,
    required this.userId,
  });

  @override
  List<Object?> get props => [id, items, totalPrice, status, date, userId];
}
