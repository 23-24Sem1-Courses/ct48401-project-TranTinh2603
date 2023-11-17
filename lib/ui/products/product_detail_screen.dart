import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../cart/cart_manager.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/product-detail';

  final Product product;

  const ProductDetailScreen(this.product, {Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                widget.product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                widget.product.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 50,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                '\$${widget.product.price}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.only(left: 10),
              width: double.infinity,
              child: Text(
                widget.product.description,
                softWrap: true,
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: 250,
              child: Row(
                children: [
                  const Text('Số lượng:'),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (quantity > 1) {
                          quantity--;
                        }
                      });
                    },
                  ),
                  Text(quantity.toString()),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  final cart = context.read<CartManager>();
                  for (int i = 0; i < quantity; i++) {
                    cart.addItem(widget.product);
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Thêm vào giỏ hàng thành công',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.blue,
                    ),
                  );
                },
                child: const Text('Add to cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
