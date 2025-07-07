import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'success.dart';
import '../models/product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  void _handleOrder(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SuccessPage()),
    );
  }

  Widget _buildRatingStars(double rating) {
    List<Widget> stars = [];
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;
    
    // Full stars
    for (int i = 0; i < fullStars; i++) {
      stars.add(const Icon(
        Icons.star,
        color: Color(0xFFFFD700),
        size: 16,
      ));
    }
    
    // Half star
    if (hasHalfStar) {
      stars.add(const Icon(
        Icons.star_half,
        color: Color(0xFFFFD700),
        size: 16,
      ));
    }
    
    // Empty stars
    int remainingStars = 5 - fullStars - (hasHalfStar ? 1 : 0);
    for (int i = 0; i < remainingStars; i++) {
      stars.add(const Icon(
        Icons.star_border,
        color: Color(0xFFDDDDDD),
        size: 16,
      ));
    }
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: stars,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.sizeOf(context).width > 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF3B82F6),
                Color(0xFF1E40AF),
              ],
            ),
          ),
        ),
        title: Text(
          product.title, 
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 4,
        shadowColor: Colors.black26,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Product Image Section
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: product.image,
                    width: isTablet ? 280 : 200,
                    height: isTablet ? 280 : 200,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => Container(
                      width: isTablet ? 280 : 200,
                      height: isTablet ? 280 : 200,
                      color: const Color(0xFFF5F5F5),
                      child: const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: Color(0xFF2563EB),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: isTablet ? 280 : 200,
                      height: isTablet ? 280 : 200,
                      color: const Color(0xFFF5F5F5),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              color: Color(0xFF999999),
                              size: 48,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Không thể tải hình ảnh',
                              style: TextStyle(
                                color: Color(0xFF999999),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            
            // Product Info Section
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Rating and Reviews
                  Row(
                    children: [
                      _buildRatingStars(product.rating),
                      const SizedBox(width: 8),
                      Text(
                        '${product.rating}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '(${product.reviewCount} reviews)',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Price Section
                  Row(
                    children: [
                      Text(
                        '\$${product.price}',
                        style: const TextStyle(
                          color: Color(0xFF2563EB),
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (product.originalPrice != null && product.discountPercentage != null) ...[
                        const SizedBox(width: 12),
                        Text(
                          '\$${product.originalPrice}',
                          style: const TextStyle(
                            color: Color(0xFF999999),
                            fontSize: 18,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2563EB),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '-${product.discountPercentage}%',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      product.description,
                      style: const TextStyle(
                        fontSize: 15, 
                        color: Colors.black87,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Purchase Button Section
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton.icon(
                onPressed: () => _handleOrder(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
                label: const Text(
                  'Purchase',
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
