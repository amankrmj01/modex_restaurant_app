import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modex_restaurant_app/presentation/screen/auth/login_screen.dart';
import 'bloc/auth/restaurant_auth_bloc.dart';
import 'bloc/menu_mgmt/menu_mgmt_bloc.dart';
import 'bloc/order_action/order_action_bloc.dart';
import 'bloc/orders/incoming_orders_bloc.dart';
import 'bloc/orders/incoming_orders_event.dart';
import 'data/repositories/menu_management_repository.dart';
import 'data/repositories/order_management_repository.dart';
import 'data/repositories/restaurant_auth_repository.dart';

void main() {
  runApp(const RestaurantApp());
}

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => RestaurantAuthRepository()),
        RepositoryProvider(create: (context) => OrderManagementRepository()),
        RepositoryProvider(create: (context) => MenuManagementRepository()),
        // Add Menu Repo
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => RestaurantAuthBloc(
              authRepository: RepositoryProvider.of<RestaurantAuthRepository>(
                context,
              ),
            ),
          ),
          BlocProvider(
            create: (context) => OrderActionBloc(
              orderRepository: RepositoryProvider.of<OrderManagementRepository>(
                context,
              ),
            ),
          ),
          BlocProvider(
            create: (context) => MenuMgmtBloc(
              // Add Menu BLoC
              menuRepository: RepositoryProvider.of<MenuManagementRepository>(
                context,
              ),
            ),
          ),
          BlocProvider(
            create: (context) => IncomingOrdersBloc(
              orderRepository: RepositoryProvider.of<OrderManagementRepository>(
                context,
              ),
            )..add(FetchIncomingOrders()),
          ),
        ],
        child: MaterialApp(
          title: 'Restaurant Portal',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
          ),
          home: RestaurantLoginScreen(),
        ),
      ),
    );
  }
}
