import 'package:flutter/material.dart';
import 'package:meals/screens/categories_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
      home: const CategoriesScreen(),
    );
  }
}
