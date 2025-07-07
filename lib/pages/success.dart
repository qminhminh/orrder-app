import 'dart:async';
import 'package:flutter/material.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/services.dart';
import 'package:orrder_app/services/auth_service.dart';

import '../services/bi_service.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  void initState() {
    super.initState();

    // Call API after X seconds
    // Future.delayed(const Duration(seconds: 1), () async {
    //   await Future.delayed(const Duration(seconds: 12));
    //   final result = await XiboService.triggerWebhook('triggerCode2');
    //
    //   if (result['success']) {
    //     print("Webhook successful");
    //   } else {
    //     print("Webhook failed: ${result['message']}");
    //   }
    // });

    // Wait a few seconds then switch to Xibo app
    Future.delayed(const Duration(seconds: 5), () async {
      await _launchXiboClient();
      if (context.mounted) {
        await Future.delayed(const Duration(seconds: 3));
        Navigator.of(context).popUntil((route) => route.isFirst);
      }

      // Call API after X seconds
      await Future.delayed(const Duration(seconds: 12));
      final result = await XiboService.triggerWebhook('triggerCode2');

    });
  }


  Future<void> _launchXiboClient() async {
    const packageName = 'com.signage.jzvfxpsoqy';

    final intent = AndroidIntent(
      action: 'android.intent.action.MAIN',
      package: packageName,
    );

    try {
      await intent.launch();
    } on PlatformException {
      debugPrint('Could not launch application $packageName');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF3B82F6),
              Color(0xFF1E40AF),
              Color(0xFFF0F8FF),
            ],
            stops: [0.0, 0.4, 1.0],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Success Icon with Animation Effect
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.check_circle, 
                    color: Color(0xFF4CAF50), 
                    size: 80,
                  ),
                ),
                const SizedBox(height: 32),
                
                // Success Message
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 15,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Thank you for your purchase!',
                        style: TextStyle(
                          fontSize: 22, 
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Returning to home and switching apps...',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      
                      // Loading indicator
                      SizedBox(
                        width: 200,
                        child:                         LinearProgressIndicator(
                          backgroundColor: Colors.grey[200],
                          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2563EB)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}