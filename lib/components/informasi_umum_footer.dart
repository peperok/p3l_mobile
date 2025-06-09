import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InformasiUmumFooter extends StatelessWidget {
  const InformasiUmumFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFF7A00), // Warna orange ReuseMart
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Center(
        child: Wrap(
          spacing: 32,
          runSpacing: 32,
          alignment: WrapAlignment.start,
          children: [
            _buildFooterColumn("Layanan Pengaduan Konsumen", [
              const Text("Email : customersupport@reuseMart.co.id"),
              const Text(
                "Direktorat Jenderal Perlindungan Konsumen dan\nTertib Niaga Kementerian Perdagangan RI",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text("WhatsApp: +62 853 1111 1010"),
            ]),
            _buildFooterColumn("Layanan ReuseMart", [
              const Text("Informasi"),
              const Text("Pencarian Barang"),
              const Text("Layanan Kirim Barang"),
              const Text("Status Order"),
              const Text("Hubungi Kami"),
              const Text("Metode Pembayaran"),
              const Text("Konfirmasi Transfer"),
            ]),
            _buildFooterColumn("Bantuan", [
              const Text("FAQ"),
              const Text("Panduan Berbelanja"),
              const Text("Aksesibilitas"),
              const Text("Kebijakan Privasi"),
            ]),
            _buildFooterColumn("Sosial Media", [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  FaIcon(FontAwesomeIcons.instagram),
                  SizedBox(width: 12),
                  FaIcon(FontAwesomeIcons.twitter),
                  SizedBox(width: 12),
                  FaIcon(FontAwesomeIcons.facebook),
                  SizedBox(width: 12),
                  FaIcon(FontAwesomeIcons.youtube),
                ],
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterColumn(String title, List<Widget> children) {
    return SizedBox(
      width: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          ...children.map((widget) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: widget,
              )),
        ],
      ),
    );
  }
}
