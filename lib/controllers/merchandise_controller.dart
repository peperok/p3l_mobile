import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:p3lcoba/models/merch.dart';

class MerchandiseController {
  static const String baseUrl =
      'http://10.0.2.2:8000/api/merch'; // Ganti sesuai endpoint backend kamu

  // Ambil semua merchandise dari API Laravel
  static Future<List<Merchandise>> getAllMerch() async {
    final response = await http.get(Uri.parse(baseUrl));

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

  // Cari merchandise berdasarkan ID
  static Future<Merchandise?> getMerchById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/search/$id'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final data = jsonResponse['data'];
      if (data != null) {
        return Merchandise.fromJson(data);
      } else {
        return null;
      }
    } else {
      throw Exception("Gagal cari merchandise: ${response.statusCode}");
    }
  }
}