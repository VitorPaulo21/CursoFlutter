import 'package:flutter/material.dart';
import 'package:meals/Utils/app_routes.dart';
import 'package:meals/models/meal.dart';

class MealItem extends StatelessWidget {
  final Meal meal;
  const MealItem(this.meal, {Key? key}) : super(key: key);

  void _selectMeal(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.MEALS_DETAILS, arguments: meal);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectMeal(context),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Image.network(
                  meal.imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 20,
                right: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  width: 300,
                  color: Colors.black54,
                  child: Text(
                    meal.title,
                    overflow: TextOverflow.fade,
                    softWrap: true,
                    style: const TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ]),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      const FittedBox(child: Icon(Icons.schedule)),
                      const SizedBox(
                        width: 6,
                      ),
                      FittedBox(
                        child: Text("${meal.duration} min"),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const FittedBox(child: Icon(Icons.work)),
                      const SizedBox(
                        width: 6,
                      ),
                      FittedBox(
                        child: Text(meal.complexityText),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const FittedBox(child: Icon(Icons.attach_money)),
                      const SizedBox(
                        width: 6,
                      ),
                      FittedBox(
                        child: Text(meal.costText),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
