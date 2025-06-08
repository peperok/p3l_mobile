import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:p3lcoba/utils/constants.dart';
import 'package:p3lcoba/models/merch.dart';

class MerchandisePage extends StatefulWidget {
  const MerchandisePage({super.key});

  @override
  State<MerchandisePage> createState() => _MerchandisePageState();
}

class _MerchandisePageState extends State<MerchandisePage> {
  List<Merchandise> _merchList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMerchandise();
  }

  Future<void> fetchMerchandise() async {
    final url = Uri.parse('http://10.0.2.2:8000/api/merchandise');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body) as List;
        setState(() {
          _merchList =
              decoded.map((item) => Merchandise.fromJson(item)).toList();
          _isLoading = false;
        });
      } else {
        throw Exception('Gagal memuat data merchandise');
      }
    } catch (e) {
      print('Error: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> claimMerch(Merchandise merch) async {
    // TODO: Ganti dengan endpoint dan implementasi validasi poin
    final url = Uri.parse('http://10.0.2.2:8000/api/pembeli/klaim-merch');

    try {
      final response = await http.post(url, body: {
        'merch_id': merch.idMerch.toString(),
      });

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Berhasil klaim ${merch.namaMerch}!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal klaim: ${response.body}')),
        );
      }
    } catch (e) {
      print('Error saat klaim: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Terjadi kesalahan saat klaim.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackgroundLight,
      appBar: AppBar(
        backgroundColor: colorSecondary,
        title: const Text('Katalog Merchandise'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _merchList.isEmpty
              ? const Center(child: Text('Tidak ada merchandise tersedia.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: _merchList.length,
                  itemBuilder: (context, index) {
                    final merch = _merchList[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                merch.imageUrl,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    const Icon(Icons.broken_image, size: 80),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    merch.namaMerch,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: colorTertiary,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text('Stok: ${merch.stok}'),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colorAccent,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () => claimMerch(merch),
                              child: const Text('CLAIM'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
