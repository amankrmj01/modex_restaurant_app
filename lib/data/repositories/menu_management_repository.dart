// data/repositories/menu_management_repository.dart
import '../models/menu_item_model.dart';

class MenuManagementRepository {
  // Mock database of the restaurant's menu items
  final List<MenuItemModel> _menuItems = [
    const MenuItemModel(
      id: 'm1',
      name: 'Margherita Pizza',
      description: 'Classic cheese and tomato',
      price: 12.99,
    ),
    const MenuItemModel(
      id: 'm2',
      name: 'Pasta Carbonara',
      description: 'Creamy pasta with bacon',
      price: 14.50,
    ),
    const MenuItemModel(
      id: 'm3',
      name: 'Butter Chicken',
      description: 'Rich and creamy chicken curry',
      price: 15.00,
    ),
    const MenuItemModel(
      id: 'm4',
      name: 'Garlic Naan',
      description: 'Soft bread with garlic',
      price: 4.00,
    ),
  ];

  Future<List<MenuItemModel>> fetchMenuItems() async {
    await Future.delayed(const Duration(seconds: 1));
    return List.from(_menuItems);
  }

  Future<void> addMenuItem(MenuItemModel item) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final newItem = MenuItemModel(
      id: 'm${DateTime.now().millisecondsSinceEpoch}', // Generate a unique ID
      name: item.name,
      description: item.description,
      price: item.price,
    );
    _menuItems.add(newItem);
  }

  Future<void> updateMenuItem(MenuItemModel item) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _menuItems.indexWhere((i) => i.id == item.id);
    if (index != -1) {
      _menuItems[index] = item;
    }
  }

  Future<void> deleteMenuItem(String itemId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _menuItems.removeWhere((item) => item.id == itemId);
  }
}
