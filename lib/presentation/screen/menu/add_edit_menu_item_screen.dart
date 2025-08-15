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
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF000428),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            isEditing ? 'Edit Menu Item' : 'Add Menu Item',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 24),
                // Header image/icon
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.amber.shade700,
                  child: Icon(Icons.fastfood, size: 48, color: Colors.white),
                ),
                const SizedBox(height: 16),
                Text(
                  isEditing
                      ? 'Update your menu item details below.'
                      : 'Fill in the details to add a new menu item.',
                  style: GoogleFonts.poppins(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.white.withAlpha((0.08 * 255).toInt()),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: BlocBuilder<MenuMgmtBloc, MenuMgmtState>(
                        bloc: widget.menuMgmtBloc,
                        builder: (context, state) {
                          return Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                  icon: Icons.currency_rupee,
                                  keyboardType: TextInputType.number,
                                ),
                                const SizedBox(height: 32),
                                Stack(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton.icon(
                                            onPressed: state.isSubmitting
                                                ? null
                                                : _submit,
                                            icon: const Icon(
                                              Icons.save,
                                              color: Colors.white,
                                            ),
                                            label: Text(
                                              isEditing
                                                  ? 'Update Item'
                                                  : 'Save Item',
                                              style: GoogleFonts.poppins(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.amber.shade700,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 16,
                                                  ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: OutlinedButton.icon(
                                            onPressed: state.isSubmitting
                                                ? null
                                                : () => Navigator.of(
                                                    context,
                                                  ).pop(),
                                            icon: const Icon(
                                              Icons.cancel,
                                              color: Colors.white70,
                                            ),
                                            label: Text(
                                              'Cancel',
                                              style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white70,
                                              ),
                                            ),
                                            style: OutlinedButton.styleFrom(
                                              side: const BorderSide(
                                                color: Colors.white38,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 16,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (state.isSubmitting)
                                      Positioned.fill(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.black.withAlpha(
                                              (0.3 * 255).toInt(),
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: const Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white.withAlpha((0.12 * 255).toInt()),
          labelText: label,
          labelStyle: GoogleFonts.poppins(color: Colors.white70),
          prefixIcon: Icon(icon, color: Colors.amber.shade700),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.white38),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.amber.shade700, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.redAccent, width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.redAccent, width: 2),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a $label';
          }
          if (label == 'Price' && double.tryParse(value) == null) {
            return 'Please enter a valid number';
          }
          return null;
        },
      ),
    );
  }
}
