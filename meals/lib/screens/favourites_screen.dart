import 'package:flutter/material.dart';
import 'package:meals/components/meal_item.dart';
import 'package:meals/models/meal.dart';

class favouritesScreen extends StatelessWidget {
  final List<Meal> _favoriteMeals;
  const favouritesScreen(this._favoriteMeals, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (_favoriteMeals.isEmpty) {
      return Center(
        child: FittedBox(
          child: Text(
            "Nenhuma refeição foi selecionada como favorita!",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      );
    } else {
      return ListView.builder(
          itemCount: _favoriteMeals.length,
          itemBuilder: (ctx, index) => MealItem(_favoriteMeals[index]));
    }
  }
}
