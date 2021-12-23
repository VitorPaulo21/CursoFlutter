import 'package:flutter/material.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/screens/cart_screen.dart';
import 'package:shop/screens/product_details_screen.dart';
import 'package:shop/screens/products_overview_screen.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductList>(
          create: (_) => ProductList(),
        ),
        ChangeNotifierProvider<Cart>(
          create: (_) => Cart(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
            fontFamily: "Lato",
            colorScheme: const ColorScheme.light().copyWith(
              primary: Colors.purple,
              secondary: Colors.deepOrange,
            )
        ),
        routes: {
          AppRoutes.PRODUCT_ITEM: (ctx) => ProductDetails(),
          AppRoutes.CART: (ctx) => CartScreen(),
        },
        home: const ProductOverviewPage(),
      ),
    );
  }
}
