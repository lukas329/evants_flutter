import 'dart:convert';
import 'package:http/http.dart' as http;
import 'event.dart'; // Import the Event class from event.dart

class ApiService {
  final String baseUrl = "http://192.168.1.15:8000/api";

  Future<String?> login(String email, String password) async {
    try {
      final url = Uri.parse('$baseUrl/login');
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['token'];
      } else {
        print('Failed to login. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        return null;
      }
    } catch (e, stacktrace) {
      // Print the exception and the stack trace to the console
      print('Exception occurred: $e');
      print('Stack trace: $stacktrace');
      return null;
    }
  }

  Future<List<Event>> fetchEvents(String token) async {
    final url = Uri.parse('$baseUrl/events');
    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((eventJson) => Event.fromJson(eventJson)).toList();
    } else {
      throw Exception("Failed to load events");
    }
  }
}
