// ----------------------------------------------------------------
// bloc/menu/menu_mgmt_event.dart
import 'package:equatable/equatable.dart';
import '../../data/models/menu_item_model.dart';

abstract class MenuMgmtEvent extends Equatable {
  const MenuMgmtEvent();

  @override
  List<Object> get props => [];
}

class FetchMenu extends MenuMgmtEvent {}

class AddMenuItem extends MenuMgmtEvent {
  final MenuItemModel item;

  const AddMenuItem(this.item);

  @override
  List<Object> get props => [item];
}

class UpdateMenuItem extends MenuMgmtEvent {
  final MenuItemModel item;

  const UpdateMenuItem(this.item);

  @override
  List<Object> get props => [item];
}

class DeleteMenuItem extends MenuMgmtEvent {
  final String itemId;

  const DeleteMenuItem(this.itemId);

  @override
  List<Object> get props => [itemId];
}
