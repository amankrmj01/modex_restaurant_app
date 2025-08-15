// data/repositories/order_management_repository.dart
import '../models/cart_item_model.dart';
import '../models/menu_item_model.dart';
import '../models/order_model.dart';

class OrderManagementRepository {
  // Simulate fetching a live list of incoming orders
  // Future<List<OrderModel>> fetchIncomingOrders1() async {
  //   await Future.delayed(const Duration(seconds: 1));
  //
  //   // Mock data representing orders from different users
  //   return [
  //     OrderModel(
  //       id: 'ord_1001',
  //       userId: 'user_123',
  //       status: 'Pending',
  //       totalPrice: 27.49,
  //       date: DateTime.now().subtract(const Duration(minutes: 5)),
  //       items: const [
  //         CartItemModel(
  //           menuItem: MenuItemModel(
  //             id: 'm1',
  //             name: 'Margherita Pizza',
  //             description: 'Classic cheese and tomato',
  //             price: 12.99,
  //           ),
  //           quantity: 1,
  //         ),
  //         CartItemModel(
  //           menuItem: MenuItemModel(
  //             id: 'm2',
  //             name: 'Pasta Carbonara',
  //             description: 'Creamy pasta with bacon',
  //             price: 14.50,
  //           ),
  //           quantity: 1,
  //         ),
  //       ],
  //     ),
  //     OrderModel(
  //       id: 'ord_1002',
  //       userId: 'user_456',
  //       status: 'Pending',
  //       totalPrice: 19.00,
  //       date: DateTime.now().subtract(const Duration(minutes: 12)),
  //       items: const [
  //         CartItemModel(
  //           menuItem: MenuItemModel(
  //             id: 'm3',
  //             name: 'Butter Chicken',
  //             description: 'Rich and creamy chicken curry',
  //             price: 15.00,
  //           ),
  //           quantity: 1,
  //         ),
  //         CartItemModel(
  //           menuItem: MenuItemModel(
  //             id: 'm4',
  //             name: 'Garlic Naan',
  //             description: 'Soft bread with garlic',
  //             price: 4.00,
  //           ),
  //           quantity: 1,
  //         ),
  //       ],
  //     ),
  //   ];
  // }

  final List<OrderModel> _incomingOrders = [
    OrderModel(
      id: 'ord_1001',
      userId: 'user_123',
      status: 'Pending',
      totalPrice: 27.49,
      date: DateTime.now().subtract(const Duration(minutes: 5)),
      items: const [
        CartItemModel(
          menuItem: MenuItemModel(
            id: 'm1',
            name: 'Margherita Pizza',
            description: 'Classic cheese and tomato',
            price: 12.99,
          ),
          quantity: 1,
        ),
        CartItemModel(
          menuItem: MenuItemModel(
            id: 'm2',
            name: 'Pasta Carbonara',
            description: 'Creamy pasta with bacon',
            price: 14.50,
          ),
          quantity: 1,
        ),
      ],
    ),
    OrderModel(
      id: 'ord_1002',
      userId: 'user_456',
      status: 'Pending',
      totalPrice: 19.00,
      date: DateTime.now().subtract(const Duration(minutes: 12)),
      items: const [
        CartItemModel(
          menuItem: MenuItemModel(
            id: 'm3',
            name: 'Butter Chicken',
            description: 'Rich and creamy chicken curry',
            price: 15.00,
          ),
          quantity: 1,
        ),
        CartItemModel(
          menuItem: MenuItemModel(
            id: 'm4',
            name: 'Garlic Naan',
            description: 'Soft bread with garlic',
            price: 4.00,
          ),
          quantity: 1,
        ),
      ],
    ),
  ];

  Future<List<OrderModel>> fetchIncomingOrders() async {
    await Future.delayed(const Duration(seconds: 1));
    // Return only orders that are still 'Pending'
    return _incomingOrders.where((order) => order.status == 'Pending').toList();
  }

  // NEW: Method to accept an order
  Future<void> acceptOrder(String orderId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _incomingOrders.indexWhere((o) => o.id == orderId);
    if (index != -1) {
      // In a real app, you'd update the database. Here we remove it from the list.
      _incomingOrders.removeAt(index);
    } else {
      throw Exception('Order not found');
    }
  }

  // NEW: Method to reject an order
  Future<void> rejectOrder(String orderId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _incomingOrders.indexWhere((o) => o.id == orderId);
    if (index != -1) {
      _incomingOrders.removeAt(index);
    } else {
      throw Exception('Order not found');
    }
  }
}
