import 'package:flutter/material.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/favourites_screen.dart';

class TabScreen extends StatelessWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Vamos Cozinhar?"),
          bottom: const TabBar(tabs: [
            Tab(
              icon: Icon(Icons.category),
              text: "Categorias",
            ),
            Tab(
              icon: Icon(Icons.favorite),
              text: "Favoritos",
            )
          ]),
        ),
        body: TabBarView(children: [
          CategoriesScreen(),
          favouritesScreen(),
        ]),
      ),
    );
  }
}
