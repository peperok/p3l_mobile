import 'package:flutter/material.dart';
import 'package:p3lcoba/utils/constants.dart';

class DaftarPengirimanPage extends StatefulWidget {
  const DaftarPengirimanPage({super.key});

  @override
  State<DaftarPengirimanPage> createState() => _DaftarPengirimanPageState();
}

class _DaftarPengirimanPageState extends State<DaftarPengirimanPage> {
  List<Map<String, dynamic>> _deliveryHistory = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDeliveryHistory();
  }

  Future<void> _loadDeliveryHistory() async {
    setState(() => _isLoading = true);
    try {
      await Future.delayed(const Duration(seconds: 1)); // Simulasi API

      _deliveryHistory = [
        {"id": 1, "task": "Pengiriman Speaker Bluetooth Mini", "status": "Sedang Dikirim"},
        {"id": 2, "task": "Pengiriman Jaket Hoodie Katun", "status": "Sedang Dikirim"},
        {"id": 3, "task": "Pengiriman Meja Belajar Anak", "status": "Sedang Dikirim"},
        {"id": 4, "task": "Pengiriman Set Buku Dongeng Anak", "status": "Sedang Dikirim"},
        {"id": 5, "task": "Pengiriman Mainan Robotik Edukatif", "status": "Sedang Dikirim"},
      ];
    } catch (e) {
      print("Error: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _updateDeliveryStatus(int id) {
    setState(() {
      final index = _deliveryHistory.indexWhere((task) => task["id"] == id);
      if (index != -1 && _deliveryHistory[index]["status"] == "Sedang Dikirim") {
        _deliveryHistory[index]["status"] = "Selesai";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Pengiriman"),
        backgroundColor: colorPrimary,
      ),
      backgroundColor: colorBackgroundLight,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Riwayat Pengiriman",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: colorTertiary)),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _deliveryHistory.length,
                      itemBuilder: (context, index) {
                        final task = _deliveryHistory[index];
                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            leading: const Icon(
                              Icons.local_shipping,
                              color: Colors.orange,
                              size: 30,
                            ),
                            title: Text(task["task"],
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                            subtitle: Text(task["status"],
                                style: TextStyle(
                                    color: task["status"] == "Selesai"
                                        ? Colors.green
                                        : Colors.black87)),
                            trailing: task["status"] == "Sedang Dikirim"
                                ? IconButton(
                                    icon: const Icon(Icons.check,
                                        color: Colors.green),
                                    onPressed: () =>
                                        _updateDeliveryStatus(task["id"]),
                                  )
                                : const Icon(Icons.check_circle,
                                    color: Colors.grey),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
