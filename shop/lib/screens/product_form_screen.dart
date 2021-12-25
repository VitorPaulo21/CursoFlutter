import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop/models/product.dart';

class ProductFormScreen extends StatefulWidget {
  ProductFormScreen({Key? key}) : super(key: key);

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final FocusNode _priceFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();
  final FocusNode _ImgUrlFocus = FocusNode();
  final GlobalKey<FormState> _formData = GlobalKey<FormState>();
  final Map<String, Object> form = {};
  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _ImgUrlFocus.dispose();
  }

  void _submitForm() {
    _formData.currentState?.save();
    Product newProduct = Product(
      id: Random().nextDouble().toString(),
      title: form["name"] as String,
      description: form["description"] as String,
      price: form["price"] as double,
      imageUrl: form["url"] as String,
    );
    print(newProduct.title);
    print(newProduct.price);
    print(newProduct.description);
  }

  String url = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Formulário de Produto"),
        actions: [IconButton(onPressed: _submitForm, icon: Icon(Icons.save))],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submitForm,
        child: const Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
            key: _formData,
            child: ListView(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: "Nome"),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_priceFocus),
                  onSaved: (name) {
                    form["name"] = name ?? "";
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Preço"),
                  textInputAction: TextInputAction.next,
                  focusNode: _priceFocus,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[0-9\.]")),
                  ],
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_descriptionFocus),
                  onSaved: (price) {
                    form["price"] = double.parse(price ?? "0");
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Descrição"),
                  focusNode: _descriptionFocus,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_ImgUrlFocus),
                  onSaved: (desc) {
                    form["description"] = desc ?? "";
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        onChanged: (txt) {
                          setState(() {
                            url = txt;
                          });
                        },
                        decoration:
                            const InputDecoration(labelText: "Url da Imagem"),
                        focusNode: _ImgUrlFocus,
                        onSaved: (img) {
                          form["url"] = img ?? "";
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10, left: 10),
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      alignment: Alignment.center,
                      child: url.isEmpty
                          ? const Text("Insira a Url")
                          : Image.network(
                              url,
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                              errorBuilder: (ctx, obj, _) =>
                                  const Text("URL Invalida"),
                            ),
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
