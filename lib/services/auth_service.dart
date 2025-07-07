import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  static const _url = 'https://hhgj-ds.com/api/authorize/access_token';
  static const _clientId = 'd6c33f8f55057cfd9b73eb3a76f13f1e0459554f';
  static const _clientSecret = '67c7864837f329234e52df72a09c5541a80eb7a4072f63e4a102836c5b30fd8c02ae53b661525fc8179e5bb8e5270a853ee8be1b9e2972870f6351e420570fdcdb972f60ca74d19220a52419d1440e18e175142c15f08edaf65e071eb87e1de7cdf24c04fb171520473dfc26d9798ac19de6496c75acff0e9ab87e5c2591c03';

  static String? _accessToken;
  static DateTime? _expiresAt;

  static Future<String?> getToken() async {
    try {
      if (_accessToken != null && _expiresAt != null && DateTime.now().isBefore(_expiresAt!)) {
        // Token is still valid
        return _accessToken;
      }

      // Token has expired or doesn't exist -> Call API to get new one
      final response = await http.post(
        Uri.parse(_url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'grant_type': 'client_credentials',
          'client_id': _clientId,
          'client_secret': _clientSecret,
        }),
      );

      if (response.statusCode == 200) {
        try {
          final data = jsonDecode(response.body);
          _accessToken = data['access_token'];
          final expiresIn = data['expires_in'] ?? 3600;
          _expiresAt = DateTime.now().add(Duration(seconds: expiresIn));

          return _accessToken;
        } catch (jsonError) {
          print('❌ JSON parsing error: $jsonError');
          return null;
        }
      } else {
        print('❌ Failed to fetch token: ${response.statusCode}');
        print('Body: ${response.body}');
        return null;
      }
    } catch (error) {
      print('❌ Network or general error: $error');
      return null;
    }
  }
}