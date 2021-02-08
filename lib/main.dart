import 'package:flutter/material.dart';
import 'package:flutter_app/providers/cart.dart';
import 'package:flutter_app/providers/orders.dart';
import 'package:flutter_app/screens/orders_screen.dart';
import 'package:flutter_app/screens/products_overview_screen.dart';
import 'package:flutter_app/screens/product_detail.dart';
import 'package:flutter_app/widgets/Test.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/providers/products_providers.dart';
import 'package:flutter_app/screens/cart_screen.dart';
import 'package:flutter_app/screens/user_products_screen.dart';
import 'package:flutter_app/screens/edit_product_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            // builder: (context) => ProductsProviders(),
            builder: (context) => ProductsProviders(),
          ),
          ChangeNotifierProvider(builder: (context) => Cart()),
          ChangeNotifierProvider(builder: (context) => Orders())
        ],
        child: MaterialApp(
          title: 'Shop App',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            errorColor: Colors.red,
          ),
          routes: {
            ProductDetail.routeName: (context) => ProductDetail(),
            CartScreen.routeName: (context) => CartScreen(),
            OrdersScreen.routeName: (context) => OrdersScreen(),
            UserProductsScreen.routeName: (context) => UserProductsScreen(),
            EditProductScreen.routeName: (context) => EditProductScreen(),
          },
          home: ProductsOverviewScreen(),
          // home: ExpansionTileSampleState(),
        ));
  }
}
