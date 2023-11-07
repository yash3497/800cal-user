import 'package:http/http.dart' as http;

class HttpServices {
  static Future<http.Response> get(String url) async {
    return await http.get(Uri.parse(url));
  }

  static Future<http.Response> post(String url, dynamic body) async {
    return await http.post(Uri.parse(url), body: body, headers: {
      'Content-type': 'application/json',
      'Accept': '*/*',
    });
  }

  static Future<http.Response> postWithToken(
      String url, dynamic body, String token) async {
    return await http.post(Uri.parse(url), body: body, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
  }

  static Future<http.Response> getWithToken(String url, String token) async {
    return await http.get(Uri.parse(url), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
  }

  static Future<http.Response> patchWithToken(
      String url, dynamic body, String token) async {
    return await http.patch(Uri.parse(url), body: body, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
  }
}
