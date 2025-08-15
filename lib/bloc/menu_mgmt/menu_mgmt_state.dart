// ----------------------------------------------------------------
// bloc/menu/menu_mgmt_state.dart
import 'package:equatable/equatable.dart';
import '../../data/models/menu_item_model.dart';

// Using a single state class to manage all menu states
class MenuMgmtState extends Equatable {
  final List<MenuItemModel> menuItems;
  final bool isLoading; // For fetching the list
  final bool isSubmitting; // For add/update/delete actions
  final String? error;

  const MenuMgmtState({
    this.menuItems = const [],
    this.isLoading = false,
    this.isSubmitting = false,
    this.error,
  });

  MenuMgmtState copyWith({
    List<MenuItemModel>? menuItems,
    bool? isLoading,
    bool? isSubmitting,
    String? error,
    bool clearError = false,
  }) {
    return MenuMgmtState(
      menuItems: menuItems ?? this.menuItems,
      isLoading: isLoading ?? this.isLoading,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      error: clearError ? null : error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [menuItems, isLoading, isSubmitting, error];
}
