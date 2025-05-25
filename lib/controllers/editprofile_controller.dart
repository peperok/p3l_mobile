import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class EditProfileController {
  Future<void> updateProfile(String name, String email, String dob, String address) async {
    final url = Uri.parse('http://10.0.2.2:8000/api/update-profile');
    final body = json.encode({
      'full_name': name,
      'email': email,
      'dob': dob,
      'address': address,
    });

    try {
      final response = await http.post(
        url,
        body: body,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userName', name);
        await prefs.setString('userEmail', email);
        await prefs.setString('userDOB', dob);
        await prefs.setString('userAddress', address);
      } else {
        throw Exception('Failed to update profile');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}
