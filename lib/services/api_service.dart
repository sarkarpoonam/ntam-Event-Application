import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://ldb-me.ve-live.com/api/AdminApiProvider";

  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    final Map<String, String> requestBody = {
      "Email": email,
      "Password": password
    };

    print("🔹 Sending Request Body: ${jsonEncode(requestBody)}");
    final response = await http.post(Uri.parse("$baseUrl/UserLogin"),
      headers: {
        "Content-Type": "application/json",
        "User-Agent": "EventApp/1.0 (Flutter)"
      },
      body: jsonEncode({"Email": email, "Password": password}),
    );
    final Map<String, dynamic> jsonResponse;
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print(jsonResponse['QrCode']);
    } else {
      throw Exception('Failed to load agenda');
    }
    return jsonResponse;
  }

  Future<bool> registerUser(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/RegisterUser"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"UserName": name, "Email": email, "Password": password}),
    );
    return response.statusCode == 200;
  }

  Future<Map<String, dynamic>> fetchAgenda() async {
    final response = await http.post(Uri.parse('$baseUrl/LoadAgenda?EventId=1'));
    final Map<String, dynamic> jsonResponse;
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
    } else {
      throw Exception('Failed to load agenda');
    }
    return jsonResponse;
  }

  Future<Map<String, dynamic>> fetchSpeakers() async {
    final response = await http.post(Uri.parse('$baseUrl/LoadSpeakers?EventId=1'));
    final Map<String, dynamic> jsonResponse;
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      jsonResponse = json.decode(response.body);
    } else {
      throw Exception('Failed to load speakers');
    }
    return jsonResponse;
  }
}