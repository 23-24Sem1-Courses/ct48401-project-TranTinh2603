import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_manager.dart';
import '../orders/order_manager.dart';
import 'cart_item_card.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartManager>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          buildCartSummary(cart, context),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  'Sản phẩm(${cart.productCount})',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextButton(
                    onPressed: cart.totalAmount <= 0
                        ? () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Cart has no products',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.blue,
                              ),
                            );
                          }
                        : () {
                            context.read<OrdersManager>().addOrder(
                                  cart.products,
                                  cart.totalAmount,
                                );
                            cart.clearAllItems();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Orders successfully',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.blue,
                              ),
                            );
                          },
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    child: const Text(
                      'Order now',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: buildCartDetails(cart),
          ),
        ],
      ),
    );
  }

  Widget buildCartDetails(CartManager cart) {
    return ListView(
      children: cart.productEntries
          .map(
            (entry) => CartItemCard(
              productId: entry.key,
              cardItem: entry.value,
            ),
          )
          .toList(),
    );
  }

  Widget buildCartSummary(CartManager cart, BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              'Total',
              style: TextStyle(fontSize: 20),
            ),
            const Spacer(),
            Chip(
              label: Text(
                '${cart.totalAmount}',
                style: TextStyle(
                  color: Theme.of(context).primaryTextTheme.titleLarge?.color,
                ),
              ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
