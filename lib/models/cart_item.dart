class CartItem {
  final String id;
  final String name;
  final int quantity;
  final String imageUrl;
  final double price;

  CartItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.imageUrl,
    required this.price,
  });

  CartItem copyWith({
    String? id,
    String? name,
    int? quantity,
    String? imageUrl,
    double? price,
  }) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
    );
  }
}
