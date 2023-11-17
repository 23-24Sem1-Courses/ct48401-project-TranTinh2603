import 'package:ct484_project/ui/products/edit_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'user_product_list_tile.dart';
import 'products_manager.dart';
import '../shared/app_drawer.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
  const UserProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Products'),
          actions: <Widget>[
            buildAddButton(context),
          ],
        ),
        drawer: const AppDrawer(),
        body: FutureBuilder(
          future: context.read<ProductsManager>().fetchProducts(true),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return RefreshIndicator(
              onRefresh: () =>
                  context.read<ProductsManager>().fetchProducts(true),
              child: buildUserProductListView(),
            );
          },
        ));
  }

  Widget buildUserProductListView() {
    return Consumer<ProductsManager>(
      builder: (context, productsManager, child) {
        return ListView.builder(
          itemCount: productsManager.itemCount,
          itemBuilder: (context, i) => Column(
            children: [
              UserProductListTile(
                productsManager.items[i],
              ),
              const Divider(),
            ],
          ),
        );
      },
    );
  }

  Widget buildAddButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: () {
        Navigator.of(context).pushNamed(
          EditProductScreen.routeName,
        );
      },
    );
  }
}
