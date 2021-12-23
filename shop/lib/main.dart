import 'package:flutter/material.dart';
import 'package:shop/screens/product_details_screen.dart';
import 'package:shop/screens/products_overview_screen.dart';
import 'package:shop/utils/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      },
      home: const ProductOverviewPage(),
    );
  }
}
