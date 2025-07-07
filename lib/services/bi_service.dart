import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:orrder_app/services/auth_service.dart';

class XiboService {
  static Future<Map<String, dynamic>> triggerWebhook(String triggerCode) async {
    try {
      final token = await AuthService.getToken();

      if (token == null) {
        return {
          'success': false,
          'message': 'Could not obtain token',
          'status': 401,
        };
      }

      const url = 'https://hhgj-ds.com/api/displaygroup/18/action/triggerWebhook';

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'triggerCode': triggerCode,
        },
      );

      if (response.statusCode == 204) {
        return {
          'success': true,
          'message': 'Webhook triggered successfully',
          'status': 204,
        };
      } else {
        return {
          'success': false,
          'message': 'Failed to trigger webhook',
          'status': response.statusCode,
          'body': response.body,
        };
      }
    } catch (error) {
      print('❌ Webhook trigger error: $error');
      return {
        'success': false,
        'message': 'Network or connection error: $error',
        'status': 500,
      };
    }
  }
}