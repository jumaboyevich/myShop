class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imgUrl;
  final bool isFavorite;

  Product(
      {
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imgUrl,
    required this.isFavorite});
}
