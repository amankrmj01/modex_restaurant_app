import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/menu_management_repository.dart';
import 'menu_mgmt_event.dart';
import 'menu_mgmt_state.dart';

class MenuMgmtBloc extends Bloc<MenuMgmtEvent, MenuMgmtState> {
  final MenuManagementRepository menuRepository;

  MenuMgmtBloc({required this.menuRepository}) : super(const MenuMgmtState()) {
    on<FetchMenu>(_onFetchMenu);
    on<AddMenuItem>(_onAddMenuItem);
    on<UpdateMenuItem>(_onUpdateMenuItem);
    on<DeleteMenuItem>(_onDeleteMenuItem);
  }

  Future<void> _onFetchMenu(
    FetchMenu event,
    Emitter<MenuMgmtState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final items = await menuRepository.fetchMenuItems();
      emit(state.copyWith(menuItems: items, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> _onAddMenuItem(
    AddMenuItem event,
    Emitter<MenuMgmtState> emit,
  ) async {
    emit(state.copyWith(isSubmitting: true, clearError: true));
    try {
      await menuRepository.addMenuItem(event.item);
      emit(state.copyWith(isSubmitting: false));
      add(FetchMenu());
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isSubmitting: false));
    }
  }

  Future<void> _onUpdateMenuItem(
    UpdateMenuItem event,
    Emitter<MenuMgmtState> emit,
  ) async {
    emit(state.copyWith(isSubmitting: true, clearError: true));
    try {
      await menuRepository.updateMenuItem(event.item);
      emit(state.copyWith(isSubmitting: false));
      add(FetchMenu());
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isSubmitting: false));
    }
  }

  Future<void> _onDeleteMenuItem(
    DeleteMenuItem event,
    Emitter<MenuMgmtState> emit,
  ) async {
    emit(state.copyWith(isSubmitting: true, clearError: true));
    try {
      await menuRepository.deleteMenuItem(event.itemId);
      emit(state.copyWith(isSubmitting: false));
      add(FetchMenu());
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isSubmitting: false));
    }
  }
}
