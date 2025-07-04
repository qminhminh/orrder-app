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
      body: Center(child: Image.asset('assets/images/logohhg.webp', width: 180)),
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

final List<Product> products = [
  Product(
    title: 'COCACOLA',
    description: 'コカ・コーラの爽やかな味わいを体験しよう。どんな瞬間にもぴったりの定番炭酸飲料です。',
    image: 'assets/images/cocacola.jpg',
    price: 180,
  ),
  Product(
    title: 'RAMUNE',
    description: '日本伝統のラムネ。シュワっとはじける懐かしい味で、見た目も可愛く楽しめる炭酸飲料。',
    image: 'assets/images/Ramune.jpg',
    price: 120,
  ),
  Product(
    title: 'MITSUYA CIDER',
    description: '三ツ矢サイダーは、すっきりとした優しい甘さでリフレッシュに最適な炭酸飲料です。',
    image: 'assets/images/MITSUYA_CIDER.jpg',
    price: 140,
  ),
  Product(
    title: 'MUGICHA',
    description: 'カフェインゼロで、香ばしくさっぱりとした味わいの健康的な麦茶です。',
    image: 'assets/images/mugicha.png',
    price: 120,
  ),
  Product(
    title: 'Ito En Risou',
    description: '完熟トマトをたっぷり使用した、自然な甘みと濃厚な味わいの野菜ジュースです。',
    image: 'assets/images/ITOENOOIOCHAMATCHAGREENTEA.webp',
    price: 130,
  ),
  Product(
    title: 'Lipton',
    description: 'すっきりとした後味で、いつでもどこでも楽しめる爽やかな紅茶です。',
    image: 'assets/images/lipton.webp',
    price: 110,
  ),
  Product(
    title: 'Qoo',
    description: '果実のやさしい甘さが広がるQooジュース。お子さまから大人まで楽しめるフルーツ飲料です。',
    image: 'assets/images/Qoo.webp',
    price: 120,
  ),
  Product(
    title: 'Lavie 500ml',
    description: 'ラヴィー天然水 500ml。コンパクトで持ち運びやすく、日常の水分補給に最適です。',
    image: 'assets/images/shopping.png',
    price: 100,
  ),
];

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF93C43E),
        title: Image.asset(
          'assets/images/logohhg.webp',
          height: MediaQuery.sizeOf(context).width > 600 ? 120 : 98,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.sizeOf(context).width > 600 ? 4 : 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            final screenWidth = MediaQuery.of(context).size.width;

            return Padding(
              padding: screenWidth > 600
                  ? EdgeInsets.only(
                    top: 24,
                    left: 6,
                    right: 6,
                    bottom: 24,
                  ): EdgeInsets.only(
                    top: 12,
                    left: 4,
                    right: 4,
                    bottom: 12,
                  ),
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
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

