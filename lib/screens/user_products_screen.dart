import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:flutter_app/providers/products_providers.dart';
import 'package:flutter_app/widgets/user_product_item.dart';
import 'package:flutter_app/widgets/app_drawer.dart';
import 'package:flutter_app/screens/edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProviders>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Products !'),
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).pushNamed(EditProductScreen.routeName);
                })
          ],
        ),
        drawer: AppDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (_, i) => Column(
              children: [
                UserProductItem(
                  title: productsData.items[i].title,
                  imageUrl: productsData.items[i].imageUrl,
                ),
                Divider(),
              ],
            ),
          ),
        ));
  }
}
