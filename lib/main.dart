// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:orrder_app/pages/product_detail.dart';
import 'package:orrder_app/widgets/product_cart.dart';
import 'package:orrder_app/models/product.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MyHomePage(title: '')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Image.asset('assets/images/logo.png', width: 180)),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Order App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB), // Beautiful blue
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2563EB),
          foregroundColor: Colors.white,
          elevation: 2,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

final List<Product> products = [
  Product(
    title: 'COCA-COLA',
    description:
        'Experience the refreshing taste of Coca-Cola. America\'s favorite classic carbonated soft drink.',
    image:
        'https://res.cloudinary.com/dijk9w0jo/image/upload/v1751855865/yqis6njxbdshvotl9t6k.jpg',
    price: 180,
    rating: 4.8,
    reviewCount: 1234,
  ),
  Product(
    title: 'PEPSI COLA',
    description:
        'Bold, refreshing Pepsi cola. The choice of a new generation with its distinctive taste.',
    image:
        'https://res.cloudinary.com/dijk9w0jo/image/upload/v1751855915/oj8svvgozlqkwb144zjg.jpg',
    price: 175,
    rating: 4.6,
    reviewCount: 1567,
  ),
  Product(
    title: 'SPRITE',
    description:
        'Crisp, clean, and refreshing lemon-lime soda. Obey your thirst with this caffeine-free drink.',
    image:
        'https://res.cloudinary.com/dijk9w0jo/image/upload/v1751855944/utkvcjbqmbdt2xbfylpw.jpg',
    price: 165,
    rating: 4.7,
    reviewCount: 890,
  ),
  Product(
    title: 'DR PEPPER',
    description:
        'The unique taste of Dr Pepper. 23 flavors blended into one refreshingly different soft drink.',
    image:
        'https://res.cloudinary.com/dijk9w0jo/image/upload/v1751855969/zhgtcruj9iyjadz8qiov.jpg',
    price: 170,
    rating: 4.5,
    reviewCount: 743,
  ),
  Product(
    title: 'MOUNTAIN DEW',
    description:
        'Do the Dew! High-energy citrus soda with bold flavor and caffeine kick for extreme refreshment.',
    image:
        'https://res.cloudinary.com/dijk9w0jo/image/upload/v1751855998/iowpmdg4p6cipszlhqhj.jpg',
    price: 185,
    rating: 4.9,
    reviewCount: 1456,
  ),
  Product(
    title: 'FANTA ORANGE',
    description:
        'Refreshing orange soda with natural fruit flavors. Bright, bubbly, and full of citrus goodness.',
    image:
        'https://res.cloudinary.com/dijk9w0jo/image/upload/v1751856025/t2ahlqiok9pl78efmory.jpg',
    price: 160,
    rating: 4.4,
    reviewCount: 832,
  ),
  Product(
    title: 'GATORADE SPORTS DRINK',
    description:
        'America\'s favorite sports drink. Replenish electrolytes and fuel your performance.',
    image:
        'https://res.cloudinary.com/dijk9w0jo/image/upload/v1751856050/esz9kk5xbrhbj3myz2pf.png',
    price: 190,
    rating: 4.6,
    reviewCount: 923,
  ),
  Product(
    title: 'DASANI WATER',
    description:
        'Pure, crisp Dasani water. Enhanced with minerals for a clean, refreshing taste.',
    image:
        'https://res.cloudinary.com/dijk9w0jo/image/upload/v1751856087/mwlibzst8bviufl8gwwj.jpg',
    price: 120,
    rating: 4.3,
    reviewCount: 589,
  ),
];

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF3B82F6), // Light blue
                Color(0xFF1E40AF), // Deep blue
              ],
            ),
          ),
        ),
        centerTitle: true,
        elevation: 4,
        shadowColor: Colors.black26,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.sizeOf(context).width > 600 ? 4 : 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.72,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            final screenWidth = MediaQuery.of(context).size.width;

            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailPage(product: product),
                    ),
                  );
                },
                child: ProductCard(
                  title: product.title,
                  description: product.description,
                  imagePath: product.image,
                  price: product.price,
                  rating: product.rating,
                  reviewCount: product.reviewCount,
                  discountPercentage: product.discountPercentage,
                  originalPrice: product.originalPrice,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
