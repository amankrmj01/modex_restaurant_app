// presentation/screens/menu/menu_management_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../bloc/menu_mgmt/menu_mgmt_bloc.dart';
import '../../../bloc/menu_mgmt/menu_mgmt_event.dart';
import '../../../bloc/menu_mgmt/menu_mgmt_state.dart';
import '../../../data/models/menu_item_model.dart';
import 'add_edit_menu_item_screen.dart';

class MenuManagementScreen extends StatelessWidget {
  const MenuManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<MenuMgmtBloc>()..add(FetchMenu()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Manage Menu',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          ),
          backgroundColor: const Color(0xFF000428),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF004e92), Color(0xFF000428)],
            ),
          ),
          child: BlocConsumer<MenuMgmtBloc, MenuMgmtState>(
            listener: (context, state) {
              if (state.error != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error!),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: state.menuItems.length,
                itemBuilder: (context, index) {
                  final item = state.menuItems[index];
                  return _buildMenuItemCard(context, item, state.isSubmitting);
                },
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => AddEditMenuItemScreen(
                  // Provide the bloc to the next screen
                  menuMgmtBloc: context.read<MenuMgmtBloc>(),
                ),
              ),
            );
          },
          backgroundColor: Colors.amber.shade700,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildMenuItemCard(
    BuildContext context,
    MenuItemModel item,
    bool isSubmitting,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.white.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 16,
        ),
        title: Text(
          item.name,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          item.description,
          style: GoogleFonts.poppins(color: Colors.white70),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '\$${item.price.toStringAsFixed(2)}',
              style: GoogleFonts.poppins(
                color: Colors.green.shade300,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.white70),
              onPressed: isSubmitting
                  ? null
                  : () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => AddEditMenuItemScreen(
                            menuItem: item,
                            menuMgmtBloc: context.read<MenuMgmtBloc>(),
                          ),
                        ),
                      );
                    },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red.shade300),
              onPressed: isSubmitting
                  ? null
                  : () {
                      context.read<MenuMgmtBloc>().add(DeleteMenuItem(item.id));
                    },
            ),
          ],
        ),
      ),
    );
  }
}
