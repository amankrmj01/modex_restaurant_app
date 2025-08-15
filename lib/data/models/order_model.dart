import 'package:equatable/equatable.dart';
import 'cart_item_model.dart';

class OrderModel extends Equatable {
  final String id;
  final List<CartItemModel> items;
  final double totalPrice;
  final String status;
  final DateTime date;
  final String userId;

  const OrderModel({
    required this.id,
    required this.items,
    required this.totalPrice,
    required this.status,
    required this.date,
    required this.userId,
  });

  OrderModel copyWith({
    String? id,
    List<CartItemModel>? items,
    double? totalPrice,
    String? status,
    DateTime? date,
    String? userId,
  }) {
    return OrderModel(
      id: id ?? this.id,
      items: items ?? this.items,
      totalPrice: totalPrice ?? this.totalPrice,
      status: status ?? this.status,
      date: date ?? this.date,
      userId: userId ?? this.userId,
    );
  }

  @override
  List<Object?> get props => [id, items, totalPrice, status, date, userId];
}
