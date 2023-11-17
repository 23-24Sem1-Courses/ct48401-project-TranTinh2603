import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

import '../cart/cart_manager.dart';
import '../../models/cart_item.dart';
import '../shared/dialog_utils.dart';

class CartItemCard extends StatelessWidget {
  final String productId;
  final CartItem cardItem;

  const CartItemCard({
    required this.productId,
    required this.cardItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cardItem.id),
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showConfirmDialog(
          context,
          'Do you want to remove the item from the cart?',
        );
      },
      onDismissed: (direction) {
        context.read<CartManager>().clearItem(productId);
      },
      child: buildItemCard(context),
    );
  }

  Widget buildItemCard(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
            leading: CircleAvatar(
              child: FittedBox(
                child: Image.network(
                  cardItem.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(cardItem.name),
            subtitle: Row(
              children: [
                Text('x${cardItem.quantity}'),
                const SizedBox(width: 10),
                Text('Total: ${(cardItem.price * cardItem.quantity)}'),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                final cart = context.read<CartManager>();
                cart.clearItem(productId);
              },
            )),
      ),
    );
  }
}
