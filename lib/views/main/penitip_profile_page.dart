import 'package:flutter/material.dart';
import 'package:p3lcoba/controllers/user_session.dart';
import 'package:p3lcoba/utils/constants.dart';

class PenitipProfilePage extends StatefulWidget {
  const PenitipProfilePage({super.key});

  @override
  State<PenitipProfilePage> createState() => _PenitipProfilePageState();
}

class _PenitipProfilePageState extends State<PenitipProfilePage> {
  int _rewardPoints = 180;
  int _saldo = 125000;
  String _badge = "Top Seller";

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
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

  @override
  Widget build(BuildContext context) {
    final userId = UserSession.userId?.toString();
    final fullName = UserSession.userFullName ?? "Nama Penitip";
    final email = UserSession.userEmail ?? "penitip@example.com";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil Penitip", style: TextStyle(color: Colors.white)),
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
                      child: const Icon(Icons.person, size: 70, color: Colors.white),
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

                  // Saldo
                  _buildCardSection(
                    icon: Icons.account_balance_wallet,
                    title: "Saldo Anda",
                    content: "Rp $_saldo",
                    iconColor: Colors.teal,
                  ),
                  const SizedBox(height: 20),

                  // Reward
                  _buildCardSection(
                    icon: Icons.stars,
                    title: "Poin Reward",
                    content: "$_rewardPoints Poin",
                    iconColor: Colors.amber,
                  ),
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
}
