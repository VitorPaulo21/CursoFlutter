import 'package:flutter/material.dart';
import 'package:meals/models/category.dart';

class CategoriesMealsScreen extends StatefulWidget {
  final Category category;
  const CategoriesMealsScreen(this.category, {Key? key}) : super(key: key);

  @override
  State<CategoriesMealsScreen> createState() => _CategoriesMealsScreenState();
}


class _CategoriesMealsScreenState extends State<CategoriesMealsScreen> {
@override
void initState(){
  print("iniciando");
}
@override
void dispose(){
  super.dispose();
  print("fechando");
}
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.category.title),
      ),
      body: Container(
        alignment: Alignment.center,
        child: const Text("Receitas por Categoria"),
      ),
    );
  }
}
