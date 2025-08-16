import 'package:equatable/equatable.dart';
import 'menu_item_model.dart';

class CartItemModel extends Equatable {
  final MenuItemModel menuItem;
  final int quantity;

  const CartItemModel({required this.menuItem, this.quantity = 1});

  @override
  List<Object?> get props => [menuItem, quantity];
}
