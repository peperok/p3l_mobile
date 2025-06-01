import 'package:flutter/material.dart';
import 'package:p3lcoba/controllers/user_session.dart';
import 'package:p3lcoba/utils/constants.dart';

class BuyerProfilePage extends StatefulWidget {
  const BuyerProfilePage({super.key});

  @override
  State<BuyerProfilePage> createState() => _BuyerProfilePageState();
}

class _BuyerProfilePageState extends State<BuyerProfilePage> {
  int _rewardPoints = 0;
  List<Map<String, String>> _purchaseHistory = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }

  Future<void> _fetchProfileData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Dummy data simulation - Replace with actual API calls when backend is ready
      await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
      setState(() {
        _rewardPoints = 250;
        _purchaseHistory = [
          {
            'id': 'ABC1',
            'date': '2025-05-30',
            'item': 'Produk A Daur Ulang',
            'price': 'Rp 100.000',
            'status': 'Selesai',
          },
          {
            'id': 'DEF2',
            'date': '2025-05-25',
            'item': 'Produk B Bekas',
            'price': 'Rp 70.000',
            'status': 'Selesai',
          },
          {
            'id': 'GHI3',
            'date': '2025-05-20',
            'item': 'Produk C Ramah Lingkungan',
            'price': 'Rp 120.000',
            'status': 'Pending', // Contoh status pending
          },
        ];
      });
    } catch (e) {
      print("Error fetching profile data: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Gagal memuat data profil.")));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final String? userId = UserSession.userId?.toString();
    final String? fullName = UserSession.userFullName;
    final String? email = UserSession.userEmail;
    final String? userType = UserSession.userType;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil Pembeli", style: TextStyle(color: Colors.white)),
        backgroundColor: colorPrimary,
      ),
      backgroundColor: colorBackgroundLight,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: colorAccent,
                      child: Icon(
                        Icons.person,
                        size: 70,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      fullName ?? "Nama Pengguna",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: colorTertiary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Center(
                    child: Text(
                      email ?? "email@example.com",
                      style: TextStyle(
                        fontSize: 16,
                        color: colorTertiary.withOpacity(0.7),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildProfileInfoRow(
                            icon: Icons.person_outline,
                            label: "User ID",
                            value: userId ?? "Tidak Tersedia",
                          ),
                          const Divider(height: 25, thickness: 1),
                          _buildProfileInfoRow(
                            icon: Icons.email_outlined,
                            label: "Email",
                            value: email ?? "Tidak Tersedia",
                          ),
                          const Divider(height: 25, thickness: 1),
                          _buildProfileInfoRow(
                            icon: Icons.badge_outlined,
                            label: "Tipe Akun",
                            value: (userType != null && userType.isNotEmpty)
                                ? userType.capitalizeFirstOfEachWord()
                                : "Tidak Tersedia",
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  Text(
                    "Poin Reward",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: colorTertiary,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 30),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Poin Anda:",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: colorTertiary.withOpacity(0.7),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "${_rewardPoints} Poin",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: colorAccent,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  Text(
                    "Riwayat Pembelian",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: colorTertiary,
                    ),
                  ),
                  const SizedBox(height: 15),
                  _purchaseHistory.isEmpty
                      ? Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Center(
                              child: Text(
                                "Belum ada riwayat pembelian.",
                                style: TextStyle(fontSize: 16, color: colorTertiary.withOpacity(0.7)),
                              ),
                            ),
                          ),
                        )
                      : Column(
                          children: _purchaseHistory.map((history) {
                            return Card(
                              margin: const EdgeInsets.only(bottom: 15),
                              elevation: 2,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Pesanan ID: ${history['id']}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: colorTertiary,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "Tanggal: ${history['date']}",
                                      style: TextStyle(color: colorTertiary.withOpacity(0.8)),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "Item: ${history['item']}",
                                      style: TextStyle(color: colorTertiary.withOpacity(0.8)),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "Harga: ${history['price']}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: colorAccent,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Chip(
                                        label: Text(
                                          history['status']!,
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor: history['status'] == 'Selesai' ? Colors.green : Colors.orange,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await UserSession.clearSession();
                        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                      },
                      icon: const Icon(Icons.logout, color: Colors.white),
                      label: const Text(
                        "Logout",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade600,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildProfileInfoRow({required IconData icon, required String label, required String value}) {
    return Row(
      children: [
        Icon(icon, color: colorAccent, size: 28),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: colorTertiary.withOpacity(0.6),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: colorTertiary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

extension StringExtension on String {
  String capitalizeFirstOfEachWord() {
    if (isEmpty) return this;
    return split(' ').map((word) => word[0].toUpperCase() + word.substring(1)).join(' ');
  }
}