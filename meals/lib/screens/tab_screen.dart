import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:meals/components/main_drawer.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/favourites_screen.dart';

class TabScreen extends StatefulWidget {
  final List<Meal> _favoriteMeals;
  const TabScreen(this._favoriteMeals, {Key? key}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedIndex = 0;
  late List<Map<String, Object>> _items;
  @override
  void initState() {
    super.initState();
    _items = [
      {"title": "Lista de Categorias", "screen": CategoriesScreen()},
      {
        "title": "Meus Favoritos",
        "screen": favouritesScreen(widget._favoriteMeals)
      },
    ];
  }
  void _selectScreen(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_items[_selectedIndex]["title"] as String),
        centerTitle: true,
      ),
      drawer: MainDrawer(),
      body: _items[_selectedIndex]["screen"] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        backgroundColor: Theme.of(context).colorScheme.primary,
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: "Categorias"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Favoritos")
        ],
      ),
    );
  }
}
