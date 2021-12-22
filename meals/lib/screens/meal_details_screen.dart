import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';

class MealDetailsScreen extends StatefulWidget {
  final Function(Meal) _toggleFavorite;
  final bool Function(Meal) _isFavorite;
  const MealDetailsScreen(this._toggleFavorite, this._isFavorite, {Key? key})
      : super(key: key);

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  late final Function(Meal) _toggleFavorite;
  late final bool Function(Meal) _isFavoriteF;
  late bool _isFavorite;
  @override
  initState() {
    super.initState();
    _toggleFavorite = widget._toggleFavorite;
    _isFavoriteF = widget._isFavorite;
  }
  Widget _titlegenerator(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget _createSectionContainer(Widget child) {
    return Container(
      height: 200,
      width: 300,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: child,
    );
  }
  late final Meal meal = ModalRoute.of(context)!.settings.arguments as Meal;
  void _changeFavorite(){
    setState(() {
      _toggleFavorite(meal);
    });
  }
  @override
  Widget build(BuildContext context) {
    _isFavorite = _isFavoriteF(meal);
    return Scaffold(
        appBar: AppBar(
          title: Text(meal.title),
        ),
        body: LayoutBuilder(
          builder: (ctx, cntrsins) => SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  child: Image.network(
                    meal.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                _titlegenerator(context, "Ingredientes"),
                _createSectionContainer(ListView.builder(
                  itemCount: meal.ingredients.length,
                  itemBuilder: (ctx, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        child: Text(meal.ingredients[index]),
                      ),
                      color: Theme.of(context).colorScheme.secondary,
                    );
                  },
                )),
                _titlegenerator(context, "Passos"),
                _createSectionContainer(ListView.builder(
                    itemCount: meal.steps.length,
                    itemBuilder: (ctx, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text("${index + 1}"),
                        ),
                        title: Text(meal.steps[index]),
                      );
                    }))
              ],
            ),
          ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: _changeFavorite, 
      child: _isFavorite 
      ?const Icon(Icons.favorite,) 
      :const Icon(Icons.favorite_outline,),),
    );
  }
}
