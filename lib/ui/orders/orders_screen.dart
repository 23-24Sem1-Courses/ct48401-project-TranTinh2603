import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'order_manager.dart';
import '../shared/app_drawer.dart';
import 'order_item_card.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: const AppDrawer(),
      body: Consumer<OrdersManager>(
        builder: (context, ordersManager, child) {
          return ListView.builder(
            itemCount: ordersManager.orderCount,
            itemBuilder: (context, index) =>
                OrderItemCard(ordersManager.orders[index]),
          );
        },
      ),
    );
  }
}
