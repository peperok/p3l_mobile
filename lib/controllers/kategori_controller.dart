import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:p3lcoba/models/kategori.dart';

class KategoriController {
  static const String baseUrl = 'http://10.0.2.2:8000/api/kategori';

  static Future<List<Kategori>> getAllKategori() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final List<dynamic> data = jsonResponse['data'];
      return data.map((e) => Kategori.fromJson(e)).toList();
    } else {
      throw Exception('Gagal memuat data kategori');
    }
  }
}
