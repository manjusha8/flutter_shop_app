import 'package:flutter/material.dart';
import 'package:flutter_app/providers/products_providers.dart';

import 'package:provider/provider.dart';
import 'package:flutter_app/providers/product.dart';

class UserProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProviders>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Products !'),
          actions: [IconButton(icon: Icon(Icons.add), onPressed: null)],
        ),
        body: ListView.builder(
          itemCount: productsData.items.length,
          // itemBuilder: (_,i)=>  ),
        ));
  }
}
