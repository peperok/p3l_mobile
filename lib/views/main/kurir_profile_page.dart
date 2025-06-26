import 'package:flutter/material.dart';
import 'package:p3lcoba/controllers/user_session.dart';
import 'package:p3lcoba/utils/constants.dart';

class KurirProfilePage extends StatefulWidget {
  const KurirProfilePage({super.key});

  @override
  State<KurirProfilePage> createState() => _KurirProfilePageState();
}

class _KurirProfilePageState extends State<KurirProfilePage> {
  int _deliveryCount = 100; // Ganti dengan data pengiriman kurir
  double _rating = 4.7; // Ganti dengan rating kurir
  String _badge = "Top Courier"; // Ganti dengan badge untuk kurir
  List<Map<String, dynamic>> _deliveryHistory = []; // Riwayat pengiriman

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
    _fetchDeliveryHistory(); // Ambil riwayat pengiriman
  }

  Future<void> _fetchProfileData() async {
    setState(() => _isLoading = true);

    try {
      // Simulasi loading, ganti dengan API di kemudian hari
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      print("Error loading profile: $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Gagal memuat profil.")));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _fetchDeliveryHistory() async {
    setState(() => _isLoading = true);

    try {
      // Simulasi riwayat pengiriman, ganti dengan API di kemudian hari
      await Future.delayed(const Duration(seconds: 1));

      // Data riwayat pengiriman
      _deliveryHistory = [
        {"id": 1, "task": "Pengiriman Speaker Bluetooth Mini", "status": "Sedang Dikirim"},
        {"id": 2, "task": "Pengiriman Jaket Hoodie Katun", "status": "Sedang Dikirim"},
        {"id": 3, "task": "Pengiriman Meja Belajar Anak", "status": "Sedang Dikirim"},
        {"id": 4, "task": "Pengiriman Set Buku Dongeng Anak", "status": "Sedang Dikirim"},
        {"id": 5, "task": "Pengiriman Mainan Robotik Edukatif", "status": "Sedang Dikirim"},
      ];
    } catch (e) {
      print("Error loading delivery history: $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Gagal memuat riwayat pengiriman.")));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _updateDeliveryStatus(int id) {
    setState(() {
      // Update status pengiriman berdasarkan id
      final index = _deliveryHistory.indexWhere((task) => task["id"] == id);
      if (index != -1) {
        _deliveryHistory[index]["status"] = "Selesai";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userId = UserSession.userId?.toString();
    final fullName = UserSession.userFullName ?? "Nama Kurir";
    final email = UserSession.userEmail ?? "kurir@example.com";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil Kurir", style: TextStyle(color: Colors.white)),
        backgroundColor: colorPrimary,
      ),
      backgroundColor: colorBackgroundLight,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: colorAccent,
                      child: const Icon(Icons.delivery_dining, size: 70, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(fullName,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: colorTertiary)),
                  ),
                  const SizedBox(height: 5),
                  Center(
                    child: Text(email,
                        style: TextStyle(
                            fontSize: 16,
                            color: colorTertiary.withOpacity(0.7))),
                  ),
                  const SizedBox(height: 30),

                  // Informasi Umum
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoRow(Icons.person_outline, "User ID", userId ?? "Tidak Tersedia"),
                          const Divider(height: 25, thickness: 1),
                          _buildInfoRow(Icons.email_outlined, "Email", email),
                          const Divider(height: 25, thickness: 1),
                          _buildInfoRow(Icons.workspace_premium, "Badge", _badge),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Jumlah Pengiriman
                  _buildCardSection(
                    icon: Icons.delivery_dining,
                    title: "Jumlah Pengiriman",
                    content: "$_deliveryCount Pengiriman",
                    iconColor: Colors.blueAccent,
                  ),
                  const SizedBox(height: 20),

                  // Rating
                  _buildCardSection(
                    icon: Icons.star_rate,
                    title: "Rating Kurir",
                    content: "$_rating / 5",
                    iconColor: Colors.amber,
                  ),
                  const SizedBox(height: 30),

                  // Riwayat Pengiriman
                  _buildDeliveryHistory(),

                  const SizedBox(height: 30),

                  // Logout
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await UserSession.clearSession();
                        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                      },
                      icon: const Icon(Icons.logout, color: Colors.white),
                      label: const Text("Logout", style: TextStyle(fontSize: 18, color: Colors.white)),
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

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: colorAccent, size: 28),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: TextStyle(
                    fontSize: 14,
                    color: colorTertiary.withOpacity(0.6),
                    fontWeight: FontWeight.w500)),
            const SizedBox(height: 4),
            Text(value,
                style: TextStyle(
                    fontSize: 16,
                    color: colorTertiary,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  Widget _buildCardSection({
    required IconData icon,
    required String title,
    required String content,
    required Color iconColor,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 30),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: 16, color: colorTertiary.withOpacity(0.7))),
                const SizedBox(height: 5),
                Text(content,
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: colorAccent)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryHistory() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Riwayat Pengiriman",
                style: TextStyle(
                    fontSize: 16, color: colorTertiary.withOpacity(0.7))),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _deliveryHistory.length,
              itemBuilder: (context, index) {
                final task = _deliveryHistory[index];
                return ListTile(
                  title: Text(task["task"]),
                  subtitle: Text(task["status"]),
                  trailing: task["status"] == "Sedang Dikirim"
                      ? IconButton(
                          icon: const Icon(Icons.check, color: Colors.green),
                          onPressed: () => _updateDeliveryStatus(task["id"]),
                        )
                      : null,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}