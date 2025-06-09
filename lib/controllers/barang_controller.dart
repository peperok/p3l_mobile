import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:p3lcoba/models/barang.dart';

class BarangController {
  static const String baseUrl =
      'http://10.0.2.2:8000/api/barang'; // Ganti ke IP lokal jika pakai device fisik

  // Ambil semua barang dari API Laravel
  static Future<List<Barang>> getAllBarang() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<dynamic> dataList = jsonResponse['data'];
      return dataList.map((json) => Barang.fromJson(json)).toList();
    } else {
      throw Exception('Gagal mengambil data barang');
    }
  }

  // Cari barang berdasarkan ID (jika pakai route search Laravel)
  static Future<Barang?> getBarangById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/search/$id'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final data = jsonResponse['data'];
      if (data != null) {
        return Barang.fromJson(data);
      } else {
        return null;
      }
    } else {
      throw Exception("Gagal cari barang: ${response.statusCode}");
    }
  }
}
