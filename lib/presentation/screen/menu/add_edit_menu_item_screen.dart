// ----------------------------------------------------------------
// presentation/screens/menu/add_edit_menu_item_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../bloc/menu_mgmt/menu_mgmt_bloc.dart';
import '../../../bloc/menu_mgmt/menu_mgmt_event.dart';
import '../../../bloc/menu_mgmt/menu_mgmt_state.dart';
import '../../../data/models/menu_item_model.dart';

class AddEditMenuItemScreen extends StatefulWidget {
  final MenuItemModel? menuItem;
  final MenuMgmtBloc menuMgmtBloc;

  const AddEditMenuItemScreen({
    super.key,
    this.menuItem,
    required this.menuMgmtBloc,
  });

  @override
  State<AddEditMenuItemScreen> createState() => _AddEditMenuItemScreenState();
}

class _AddEditMenuItemScreenState extends State<AddEditMenuItemScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;

  bool get isEditing => widget.menuItem != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.menuItem?.name);
    _descriptionController = TextEditingController(
      text: widget.menuItem?.description,
    );
    _priceController = TextEditingController(
      text: widget.menuItem?.price.toString(),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final item = MenuItemModel(
        id: widget.menuItem?.id ?? '',
        name: _nameController.text,
        description: _descriptionController.text,
        price: double.tryParse(_priceController.text) ?? 0.0,
      );

      if (isEditing) {
        widget.menuMgmtBloc.add(UpdateMenuItem(item));
      } else {
        widget.menuMgmtBloc.add(AddMenuItem(item));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MenuMgmtBloc, MenuMgmtState>(
      bloc: widget.menuMgmtBloc,
      listener: (context, state) {
        if (!state.isSubmitting && state.error == null) {
          // If submission is done and there's no error, pop the screen
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            isEditing ? 'Edit Item' : 'Add Item',
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
          child: BlocBuilder<MenuMgmtBloc, MenuMgmtState>(
            bloc: widget.menuMgmtBloc,
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      _buildTextFormField(
                        controller: _nameController,
                        label: 'Name',
                        icon: Icons.fastfood,
                      ),
                      const SizedBox(height: 20),
                      _buildTextFormField(
                        controller: _descriptionController,
                        label: 'Description',
                        icon: Icons.description,
                      ),
                      const SizedBox(height: 20),
                      _buildTextFormField(
                        controller: _priceController,
                        label: 'Price',
                        icon: Icons.attach_money,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 40),
                      state.isSubmitting
                          ? const CircularProgressIndicator(color: Colors.white)
                          : SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: _submit,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.amber.shade700,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  'Save Item',
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: GoogleFonts.poppins(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white70),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white54),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.amber, width: 2),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a $label';
        }
        if (label == 'Price ₹' && double.tryParse(value) == null) {
          return 'Please enter a valid number';
        }
        return null;
      },
    );
  }
}
