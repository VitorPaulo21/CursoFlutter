class CartItem {
  final String id;
  final String productId;
  final String name;
  int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
  });

  CartItem copyWith({
    String id = "",
    String productId = "",
    String name = "",
    int quantity = 0,
    double price = 0,
  }) {
    return CartItem(
      id: id == "" ? this.id : id,
      productId: productId == "" ? this.productId : productId,
      name: name == "" ? this.name : name,
      quantity: quantity == 0 ? this.quantity : quantity,
      price: price == 0 ? this.price : price,
    );
  }
}
