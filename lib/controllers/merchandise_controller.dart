import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:p3lcoba/models/merch.dart';

class MerchandiseController {
  static const String baseUrl = 'http://10.0.2.2:8000/api/merch';

  static Future<List<Merchandise>> getAllMerch() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token'); // ambil token yang disimpan waktu login

    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    print('MERCH STATUS: ${response.statusCode}');
    print('MERCH BODY: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<dynamic> dataList = jsonResponse['data'];
      return dataList.map((json) => Merchandise.fromJson(json)).toList();
    } else {
      throw Exception('Gagal mengambil data merchandise');
    }
  }
}
