class Product {
  final String title;
  final String description;
  final String image;
  final int price;
  final double rating;
  final int reviewCount;
  final int? discountPercentage;
  final int? originalPrice;

  const Product({
    required this.title,
    required this.description,
    required this.image,
    required this.price,
    this.rating = 4.5,
    this.reviewCount = 0,
    this.discountPercentage,
    this.originalPrice,
  });
}