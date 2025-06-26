import 'package:flutter/material.dart';
import 'package:p3lcoba/controllers/user_session.dart';
import 'package:p3lcoba/utils/constants.dart';

class HunterProfilePage extends StatefulWidget {
  const HunterProfilePage({super.key});

  @override
  State<HunterProfilePage> createState() => _HunterProfilePageState();
}

class _HunterProfilePageState extends State<HunterProfilePage> {
  int _huntingCount = 3;
  double _rating = 4.5;
  String _badge = "Top Hunter";
  List<Map<String, dynamic>> _huntingHistory = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
    _fetchHuntingHistory();
  }

  Future<void> _fetchProfileData() async {
    setState(() => _isLoading = true);
    try {
      await Future.delayed(
          const Duration(seconds: 1)); // nanti ganti dengan API
    } catch (e) {
      print("Error loading hunter profile: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal memuat profil.")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _fetchHuntingHistory() async {
    setState(() => _isLoading = true);
    try {
      await Future.delayed(const Duration(seconds: 1));
      _huntingHistory = [
        {"id": 1, "task": "TV LED 40 Inch", "status": "Selesai"},
        {"id": 2, "task": "Mainan Edukasi", "status": "Selesai"},
        {"id": 3, "task": "Rak Sepatu Besi", "status": "Akan Diambil"},
      ];
    } catch (e) {
      print("Error loading hunting history: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal memuat riwayat hunting.")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _updateHuntingStatus(int id) {
    setState(() {
      final index = _huntingHistory.indexWhere((task) => task["id"] == id);
      if (index != -1) {
        _huntingHistory[index]["status"] = "Selesai";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userId = UserSession.userId?.toString();
    final fullName = UserSession.userFullName ?? "Nama Hunter";
    final email = UserSession.userEmail ?? "hunter@example.com";

    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Profil Hunter", style: TextStyle(color: Colors.white)),
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
                      child: const Icon(Icons.search,
                          size: 70, color: Colors.white),
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
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoRow(Icons.person_outline, "User ID",
                              userId ?? "Tidak Tersedia"),
                          const Divider(height: 25, thickness: 1),
                          _buildInfoRow(Icons.email_outlined, "Email", email),
                          const Divider(height: 25, thickness: 1),
                          // _buildInfoRow(
                          //     Icons.workspace_premium, "Badge", _badge),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildCardSection(
                    icon: Icons.search,
                    title: "Jumlah Barang Dihunting",
                    content: "$_huntingCount Barang",
                    iconColor: Colors.teal,
                  ),
                  const SizedBox(height: 20),
                  _buildCardSection(
                    icon: Icons.star_rate,
                    title: "Rating Hunter",
                    content: "$_rating / 5",
                    iconColor: Colors.amber,
                  ),
                  const SizedBox(height: 30),
                  _buildHuntingHistory(),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await UserSession.clearSession();
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/login', (route) => false);
                      },
                      icon: const Icon(Icons.logout, color: Colors.white),
                      label: const Text("Logout",
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade600,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
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

  Widget _buildHuntingHistory() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Riwayat Hunting",
                style: TextStyle(
                    fontSize: 16, color: colorTertiary.withOpacity(0.7))),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _huntingHistory.length,
              itemBuilder: (context, index) {
                final task = _huntingHistory[index];
                return ListTile(
                  title: Text(task["task"]),
                  subtitle: Text(task["status"]),
                  trailing: task["status"] == "Sedang Dicari"
                      ? IconButton(
                          icon: const Icon(Icons.check, color: Colors.green),
                          onPressed: () => _updateHuntingStatus(task["id"]),
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