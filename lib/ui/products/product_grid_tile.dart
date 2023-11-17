import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../cart/cart_manager.dart';
import 'product_detail_screen.dart';
import 'products_manager.dart';

class ProductGridTile extends StatelessWidget {
  const ProductGridTile(
    this.product, {
    super.key,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: GridTile(
          footer: buildGridFooterBar(context),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                ProductDetailScreen.routeName,
                arguments: product.id,
              );
            },
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildGridFooterBar(BuildContext context) {
    return GridTileBar(
      backgroundColor: Colors.white,
      leading: ValueListenableBuilder<bool>(
        valueListenable: product.isFavoriteListenable,
        builder: (context, isFavorite, child) {
          return IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () {
              context.read<ProductsManager>().toggleFavoriteStatus(product);
            },
          );
        },
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            product.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${product.price}đ',
            style: const TextStyle(
              color: Colors.red,
            ),
          )
        ],
      ),
      trailing: IconButton(
        icon: const Icon(
          Icons.shopping_cart,
        ),
        onPressed: () {
          final cart = context.read<CartManager>();
          cart.addItem(product);
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: const Text(
                  'Item added to cart',
                ),
                duration: const Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'UNDO',
                  textColor: Colors.white,
                  onPressed: () {
                    cart.removeItem(product.id!);
                  },
                ),
                backgroundColor: Colors.blue,
              ),
            );
        },
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
