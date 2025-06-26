import 'package:flutter/material.dart';
import 'package:p3lcoba/utils/constants.dart';

class TopSellerPage extends StatelessWidget {
  final List<Map<String, dynamic>> topSellers = [
    {
      'nama': 'irenevelvet',
      'totalPenjualan': 12,
      'status': 'Top Seller Bulan Juni',
    },
    {
      'nama': 'offgun',
      'totalPenjualan': 14,
      'status': 'Top Seller Bulan Mei',
    },
    {
      'nama': 'geminifourth',
      'totalPenjualan': 10,
      'status': 'Top Seller Bulan April',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Seller Bulanan'),
        backgroundColor: colorPrimary,
      ),
      body: ListView.builder(
        itemCount: topSellers.length,
        itemBuilder: (context, index) {
          final seller = topSellers[index];
          final isCurrentTop = seller['status'] == 'Top Seller Bulan Juni';

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 3,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: isCurrentTop ? Colors.orange : Colors.grey,
                child: const Icon(Icons.store, color: Colors.white),
              ),
              title: Row(
                children: [
                  Text(
                    seller['nama'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  if (isCurrentTop)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.star, color: Colors.white, size: 16),
                          SizedBox(width: 4),
                          Text(
                            'Top Seller Juni',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              subtitle: Text(
                'Penjualan: ${seller['totalPenjualan']} barang\n${seller['status']}',
                style: TextStyle(
                  color: isCurrentTop ? Colors.black : Colors.grey[700],
                ),
              ),
              isThreeLine: true,
              trailing: isCurrentTop
                  ? const Icon(Icons.verified, color: Colors.amber)
                  : null,
            ),
          );
        },
      ),
    );
  }
}
