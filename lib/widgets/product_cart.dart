import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final int price;
  final double rating;
  final int reviewCount;
  final int? discountPercentage;
  final int? originalPrice;

  const ProductCard({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.price,
    this.rating = 4.5,
    this.reviewCount = 0,
    this.discountPercentage,
    this.originalPrice,
  });

  Widget _buildRatingStars(double rating) {
    List<Widget> stars = [];
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;
    
    // Full stars
    for (int i = 0; i < fullStars; i++) {
      stars.add(const Icon(
        Icons.star,
        color: Color(0xFFFFD700),
        size: 12,
      ));
    }
    
    // Half star
    if (hasHalfStar) {
      stars.add(const Icon(
        Icons.star_half,
        color: Color(0xFFFFD700),
        size: 12,
      ));
    }
    
    // Empty stars
    int remainingStars = 5 - fullStars - (hasHalfStar ? 1 : 0);
    for (int i = 0; i < remainingStars; i++) {
      stars.add(const Icon(
        Icons.star_border,
        color: Color(0xFFDDDDDD),
        size: 12,
      ));
    }
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: stars,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                    color: Color(0xFFFAFAFA),
                  ),
                                      child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CachedNetworkImage(
                          imageUrl: imagePath,
                          fit: BoxFit.contain,
                          placeholder: (context, url) => Container(
                            color: const Color(0xFFF5F5F5),
                            child: const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Color(0xFF2563EB),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: const Color(0xFFF5F5F5),
                            child: const Center(
                              child: Icon(
                                Icons.error_outline,
                                color: Color(0xFF999999),
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ),
              ),
              
              // Product Info
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Title
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      const SizedBox(height: 6),
                      
                      // Price Section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Current Price
                          Text(
                            '\$${price}',
                            style: const TextStyle(
                              color: Color(0xFF2563EB),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          
                          // Original Price (if discount exists)
                          if (originalPrice != null && discountPercentage != null)
                            Text(
                              '\$${originalPrice}',
                              style: const TextStyle(
                                color: Color(0xFF999999),
                                fontSize: 12,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                        ],
                      ),
                      
                      const Spacer(),
                      
                      // Rating and Reviews
                      Row(
                        children: [
                          _buildRatingStars(rating),
                          const SizedBox(width: 4),
                          Text(
                            '($reviewCount)',
                            style: const TextStyle(
                              color: Color(0xFF999999),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          // Discount Badge
          if (discountPercentage != null)
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF2563EB),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '-${discountPercentage}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}