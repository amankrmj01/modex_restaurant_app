import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../bloc/menu_mgmt/menu_mgmt_bloc.dart';
import '../../../bloc/orders/incoming_orders_bloc.dart';
import '../../../bloc/orders/incoming_orders_event.dart';
import '../../../bloc/orders/incoming_orders_state.dart';
import '../../../data/models/order_model.dart';
import '../../../data/repositories/order_management_repository.dart';
import '../menu/menu_management_screen.dart';

class OrderDashboardScreen extends StatelessWidget {
  const OrderDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IncomingOrdersBloc(
        orderRepository: RepositoryProvider.of<OrderManagementRepository>(
          context,
        ),
      )..add(FetchIncomingOrders()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Incoming Orders',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color(0xFF000428),
          // Dark blue to match gradient
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                // Allow manual refresh
                context.read<IncomingOrdersBloc>().add(FetchIncomingOrders());
              },
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF004e92), Color(0xFF000428)],
            ),
          ),
          child: BlocBuilder<IncomingOrdersBloc, IncomingOrdersState>(
            builder: (context, state) {
              if (state is IncomingOrdersLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              }
              if (state is IncomingOrdersLoaded) {
                if (state.orders.isEmpty) {
                  return Center(
                    child: Text(
                      'No pending orders.',
                      style: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: state.orders.length,
                  itemBuilder: (context, index) {
                    final order = state.orders[index];
                    return _buildOrderCard(context, order);
                  },
                );
              }
              if (state is IncomingOrdersError) {
                return Center(
                  child: Text(
                    'Error: ${state.message}',
                    style: GoogleFonts.poppins(color: Colors.red.shade300),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xFF000428),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white54,
          currentIndex: 0,
          // This is the 'Orders' screen
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.restaurant_menu),
              label: 'Menu',
            ),
          ],
          onTap: (index) {
            if (index == 1) {
              // Tapped on 'Menu'
              Navigator.of(context).push(
                MaterialPageRoute(
                  // We need to provide the MenuMgmtBloc to the new route
                  builder: (_) => BlocProvider.value(
                    value: context.read<MenuMgmtBloc>(),
                    child: const MenuManagementScreen(),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context, OrderModel order) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border(
          top: BorderSide(color: Colors.white, width: 1),
          left: BorderSide(color: Colors.white, width: 1),
        ),
        boxShadow: [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order #${order.id.split('_').last}',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$${order.totalPrice.toStringAsFixed(2)}',
                style: GoogleFonts.poppins(
                  color: Colors.green.shade300,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Status: ${order.status}',
            style: GoogleFonts.poppins(
              color: Colors.amber.shade300,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Divider(color: Colors.white24, height: 24),

          // Item List
          ...order.items.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  Text(
                    '${item.quantity}x',
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      item.menuItem.name,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(color: Colors.white24, height: 24),

          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Dispatch AcceptOrder event
                },
                icon: const Icon(Icons.check_circle, color: Colors.white),
                label: Text(
                  'Accept',
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.withOpacity(0.8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Dispatch RejectOrder event
                },
                icon: const Icon(Icons.cancel, color: Colors.white),
                label: Text(
                  'Reject',
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.withOpacity(0.8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
