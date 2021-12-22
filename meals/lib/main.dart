import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meals/Utils/app_routes.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/models/settings.dart';
import 'package:meals/screens/categories_meals_screen.dart';
import 'package:meals/screens/meal_details_screen.dart';
import 'package:meals/screens/settings_screen.dart';
import 'package:meals/screens/tab_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Settings settings = Settings();
  List<Meal> _avaliableMeals = DUMMY_MEALS;
  final List<Meal> _favoriteMeals = [];
  void _filterMeals(Settings settings) {
    this.settings = settings;
    _avaliableMeals = DUMMY_MEALS.where((element) {
      bool filtroGluten = settings.isGlutenFree && !element.isGlutenFree;
      bool filtroLactose = settings.isLactoseFree && !element.isLactoseFree;
      bool filtroVegan = settings.isVegan && !element.isVegan;
      bool filtroVegetarian = settings.isVegetarian && !element.isVegetarian;
      return !filtroGluten &&
          !filtroLactose &&
          !filtroVegan &&
          !filtroVegetarian;
    }).toList();
  }
void _toggleFavorite(Meal meal) {
    if (_containInFavorite(meal)) {
      _favoriteMeals.remove(meal);
    } else {
      _favoriteMeals.add(meal);
    }
  }

  bool _containInFavorite(Meal meal) {
    return _favoriteMeals.contains(meal);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          fontFamily: "Raleway",
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: const TextStyle(
                    fontFamily: "RobotoCondensed", fontSize: 20),
              ),
          canvasColor: const Color.fromRGBO(255, 254, 229, 1),
          colorScheme: ColorScheme(
              primary: Colors.pink,
              primaryVariant: Colors.grey[900]!,
              secondary: Colors.amber,
              secondaryVariant: Colors.pink,
              surface: Theme.of(context).colorScheme.surface,
              background: Theme.of(context).colorScheme.background,
              error: Theme.of(context).colorScheme.error,
              onPrimary: Colors.white,
              onSecondary: Colors.black,
              onSurface: Theme.of(context).colorScheme.onSurface,
              onBackground: Theme.of(context).colorScheme.onBackground,
              onError: Theme.of(context).colorScheme.onError,
              brightness: Theme.of(context).colorScheme.brightness)),
      routes: {
        AppRoutes.HOME: (_) => TabScreen(_favoriteMeals),
        AppRoutes.CATEGORIES_MEALS: (_) =>
            CategoriesMealsScreen(_avaliableMeals),
        AppRoutes.MEALS_DETAILS: (_) =>
            MealDetailsScreen(_toggleFavorite, _containInFavorite),
        AppRoutes.SETTINGS: (_) => SettingsScreen(settings, _filterMeals),
      },
    );
  }
}
