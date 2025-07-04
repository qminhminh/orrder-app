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

    // call API after Xs
    // Future.delayed(const Duration(seconds: 1), () async {
    //   await Future.delayed(const Duration(seconds: 12));
    //   final result = await XiboService.triggerWebhook('triggerCode2');
    //
    //   if (result['success']) {
    //     print("Webhook thành công");
    //   } else {
    //     print("Webhook thất bại: ${result['message']}");
    //   }
    // });

    // Đợi vài giây rồi chuyển qua app Xibo
    Future.delayed(const Duration(seconds: 5), () async {
      await _launchXiboClient();
      if (context.mounted) {
        await Future.delayed(const Duration(seconds: 3));
        Navigator.of(context).popUntil((route) => route.isFirst);
      }

      // call API after Xs
      await Future.delayed(const Duration(seconds: 12));
      final result = await XiboService.triggerWebhook('triggerCode2');

    });
  }


  Future<void> _launchXiboClient() async {
    const packageName = 'com.signage.hrrqwiwifz';

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
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 64),
            const SizedBox(height: 20),
            const Text(
              'ご購入ありがとうございます！',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text('ホームに戻り、アプリを切り替えます...', style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}