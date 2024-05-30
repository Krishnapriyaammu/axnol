import 'dart:convert';
import 'package:http/http.dart' as http;
Future<Map<String, dynamic>> login(String email, String password) async {
  final url = 'http://axnoldigitalsolutions.in/Training/api/login';
  final headers = {'Content-Type': 'application/json'};
  final body = json.encode({
    'email': email,
    'password': password,
  });

  final response = await http.post(Uri.parse(url), headers: headers, body: body);

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    return {'error': 'Failed to log in. Status code: ${response.statusCode}'};
  }
}