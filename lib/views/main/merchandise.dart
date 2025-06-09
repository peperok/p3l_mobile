import 'package:flutter/material.dart';

class MerchandisePage extends StatelessWidget {
  const MerchandisePage({super.key});

  // Dummy data untuk sementara (nanti diganti dari backend)
  final List<Map<String, dynamic>> merchList = const [
    {
      'nama': 'Tumbler ReuseMart',
      'stok': 25,
      'image': 'https://via.placeholder.com/150?text=Tumbler',
    },
    {
      'nama': 'Totebag Ramah Lingkungan',
      'stok': 12,
      'image': 'https://via.placeholder.com/150?text=Totebag',
    },
    {
      'nama': 'Sticker Pack',
      'stok': 50,
      'image': 'https://via.placeholder.com/150?text=Sticker',
    },
    {
      'nama': 'Notebook Daur Ulang',
      'stok': 18,
      'image': 'https://via.placeholder.com/150?text=Notebook',
    },
    {
      'nama': 'Gantungan Kunci Kayu',
      'stok': 40,
      'image': 'https://via.placeholder.com/150?text=Gantungan',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Merchandise',
            style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF6D4C41),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xFFF5F0E1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: merchList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            final merch = merchList[index];
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(10)),
                      child: Image.network(
                        merch['image_url'],
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.image_not_supported, size: 50),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          merch['nama_merch'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text('Stok: ${merch['stok']}',
                            style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
