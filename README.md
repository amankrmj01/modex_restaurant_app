# Modex Restaurant App

A comprehensive Flutter restaurant management application built for restaurant owners and managers
to efficiently handle their operations. This app provides an intuitive interface for managing menus,
processing incoming orders, tracking order status, and overseeing restaurant operations.

The application follows clean architecture principles with BLoC pattern for state management,
ensuring scalable and maintainable code structure for restaurant business operations.

## Folder Structure

```
lib/
├── main.dart                    # Application entry point with providers setup
├── bloc/                        # State management using BLoC pattern
│   ├── auth/                    # Restaurant authentication business logic
│   │   ├── restaurant_auth_bloc.dart
│   │   ├── restaurant_auth_event.dart
│   │   └── restaurant_auth_state.dart
│   ├── menu_mgmt/               # Menu management business logic
│   │   ├── menu_mgmt_bloc.dart
│   │   ├── menu_mgmt_event.dart
│   │   └── menu_mgmt_state.dart
│   ├── orders/                  # Incoming orders management
│   │   ├── incoming_orders_bloc.dart
│   │   ├── incoming_orders_event.dart
│   │   └── incoming_orders_state.dart
│   └── order_action/            # Order processing actions
│       ├── order_action_bloc.dart
│       ├── order_action_event.dart
│       └── order_action_state.dart
├── data/                        # Data layer containing models and repositories
│   ├── models/                  # Data models
│   │   ├── cart_item_model.dart # Cart item entity model
│   │   ├── menu_item_model.dart # Menu item entity model
│   │   └── order_model.dart     # Order entity model
│   └── repositories/            # Data access layer
│       ├── restaurant_auth_repository.dart
│       ├── menu_management_repository.dart
│       └── order_management_repository.dart
└── presentation/                # UI layer
    └── screen/                  # Application screens
        ├── auth/                # Authentication screens
        │   └── login_screen.dart
        ├── home/                # Main dashboard
        │   └── home_screen.dart
        ├── menu/                # Menu management
        │   ├── menu_management_screen.dart
        │   └── add_edit_menu_item_screen.dart
        └── dashboard/           # Order management dashboard
            ├── order_dashboard_screen.dart
            └── accepted_orders_screen.dart
```

## Screens Overview

### Authentication

- **Login Screen** (`login_screen.dart`): Secure authentication interface for restaurant owners and
  managers to access the app with credentials validation

### Main Application

- **Home Screen** (`home_screen.dart`): Main dashboard providing overview of restaurant operations,
  daily statistics, and quick access to key features

### Menu Management

- **Menu Management Screen** (`menu_management_screen.dart`): Comprehensive interface for viewing,
  organizing, and managing restaurant menu items with category-wise display
- **Add/Edit Menu Item Screen** (`add_edit_menu_item_screen.dart`): Detailed form interface for
  creating new menu items or editing existing ones with pricing, descriptions, and availability
  settings

### Order Management Dashboard

- **Order Dashboard Screen** (`order_dashboard_screen.dart`): Central hub for monitoring all
  incoming orders, order statistics, and real-time order flow management
- **Accepted Orders Screen** (`accepted_orders_screen.dart`): Dedicated interface for managing
  accepted orders, tracking preparation status, and updating order progress

## BLoC State Management

The application uses the BLoC (Business Logic Component) pattern for predictable state management
across restaurant operations:

### Restaurant Authentication BLoC

- **Purpose**: Manages restaurant owner/manager authentication, login/logout processes, and session
  management
- **Events**: Login requests, logout actions, authentication status validation, credential
  verification
- **States**: Authenticated, unauthenticated, loading states with restaurant user data
- **Repository**: `RestaurantAuthRepository` for handling authentication API calls and restaurant
  user data management

### Menu Management BLoC

- **Purpose**: Handles all menu-related operations including CRUD operations for menu items,
  category management, and availability updates
- **Events**: Fetch menu items, add new items, edit existing items, delete items, update
  availability, manage categories
- **States**: Menu loading, loaded with items, item creation/update states, error handling for menu
  operations
- **Repository**: `MenuManagementRepository` for menu data persistence and API operations

### Incoming Orders BLoC

- **Purpose**: Manages real-time incoming orders from customers, order notifications, and initial
  order processing
- **Events**: Fetch new orders, order received notifications, order filtering, refresh order list
- **States**: Orders loading, new orders available, no pending orders, connection status for
  real-time updates
- **Features**: Real-time order monitoring, order priority management, notification handling

### Order Action BLoC

- **Purpose**: Handles order processing actions including accepting, rejecting, and updating order
  status throughout the fulfillment process
- **Events**: Accept order, reject order, update order status, mark as ready, complete order, cancel
  order
- **States**: Processing action, action completed, action failed, order status updated
- **Repository**: `OrderManagementRepository` for order status updates and communication with
  delivery systems

## Data Handling

### Repository Pattern

The app implements the repository pattern for clean data access and business logic separation:

- **RestaurantAuthRepository**: Handles restaurant authentication, user session management, token
  persistence, and restaurant profile data
- **MenuManagementRepository**: Manages menu item CRUD operations, category management, pricing
  updates, and inventory synchronization with backend APIs
- **OrderManagementRepository**: Handles order lifecycle management, status updates, customer
  communication, and integration with delivery tracking systems

### Data Models

- **MenuItemModel**: Comprehensive menu item entity containing name, description, price, category,
  availability, ingredients, dietary information, and preparation time
- **OrderModel**: Complete order entity including customer details, ordered items, quantities, total
  amount, delivery address, payment status, and order timeline
- **CartItemModel**: Individual cart item entity managing item details, quantity, customizations,
  special instructions, and item-specific pricing

### Key Features

- **Secure Restaurant Authentication**: Restaurant owner/manager login with role-based access
  control
- **Real-time Order Management**: Live incoming orders with instant notifications and status updates
- **Comprehensive Menu Management**: Full CRUD operations for menu items with category organization
  and availability control
- **Order Processing Workflow**: Complete order lifecycle from receipt to completion with status
  tracking
- **Dashboard Analytics**: Restaurant performance insights and order statistics
- **Clean Architecture**: Separation of concerns with BLoC pattern and repository design for
  scalability
- **Responsive UI**: Modern restaurant management interface built with Material Design principles
- **Real-time Synchronization**: Live order updates and menu synchronization across multiple devices
- **Order Status Tracking**: Detailed order progress tracking from acceptance to delivery completion
