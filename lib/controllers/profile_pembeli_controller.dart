// import 'package:flutter/material.dart';
// //import 'package:provider/provider.dart'; // Pastikan Anda sudah menambahkan package provider
// import 'package:p3lcoba/utils/constants.dart'; // Sesuaikan path jika perlu
// import 'package:p3lcoba/controllers/profile_pembeli_controller.dart'; // Import controller kita (nama file dan kelas diubah)

// class ProfilePembeliPage extends StatefulWidget { // Nama kelas diubah
//   const ProfilePembeliPage({Key? key}) : super(key: key);

//   @override
//   State<ProfilePembeliPage> createState() => _ProfilePembeliPageState(); // Nama state diubah
// }

// class _ProfilePembeliPageState extends State<ProfilePembeliPage> { // Nama state diubah
//   @override
//   void initState() {
//     super.initState();
//     // Panggil fungsi untuk mengambil data saat widget pertama kali dibuat
//     // WidgetsBinding.instance.addPostFrameCallback((_) {
//     //   Provider.of<ProfilePembeliController>(context, listen: false).fetchProfileData(); // Nama controller diubah
//     // });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: colorPrimary,
//       appBar: AppBar(
//         title: const Text(
//           "Profil Saya",
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: colorPrimary,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.white), // Warna ikon kembali
//       ),
//       body: Consumer<ProfilePembeliController>( // Menggunakan Consumer dari package provider (nama controller diubah)
//         builder: (context, controller, child) {
//           if (controller.isLoading) {
//             return Center(
//               child: CircularProgressIndicator(color: colorAccent),
//             );
//           }

//           if (controller.errorMessage != null) {
//             return Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       controller.errorMessage!,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(color: Colors.red[700], fontSize: 16),
//                     ),
//                     const SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: () {
//                         controller.fetchProfileData(); // Coba lagi
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: colorAccent,
//                         foregroundColor: Colors.white,
//                       ),
//                       child: const Text("Coba Lagi"),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }

//           // Jika data berhasil dimuat
//           final userProfile = controller.userProfile;
//           final transactions = controller.transactions;

//           if (userProfile == null) {
//             return const Center(
//               child: Text(
//                 "Data profil tidak ditemukan.",
//                 style: TextStyle(color: Colors.white70),
//               ),
//             );
//           }

//           return SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Bagian Profil Diri Sendiri dan Poin Reward
//                 Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Card(
//                     color: colorBackgroundLight,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     elevation: 5,
//                     child: Padding(
//                       padding: const EdgeInsets.all(20.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               CircleAvatar(
//                                 radius: 40,
//                                 backgroundColor: colorAccent,
//                                 child: Text(
//                                   userProfile.name[0].toUpperCase(),
//                                   style: const TextStyle(
//                                     fontSize: 30,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 20),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     userProfile.name,
//                                     style: TextStyle(
//                                       fontSize: 24,
//                                       fontWeight: FontWeight.bold,
//                                       color: colorTertiary,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 5),
//                                   Text(
//                                     userProfile.email,
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: colorTertiary.withOpacity(0.8),
//                                     ),
//                                   ),
//                                   Text(
//                                     userProfile.phone,
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: colorTertiary.withOpacity(0.8),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           const Divider(height: 30, thickness: 1, color: Colors.grey),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "Poin Reward:",
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w600,
//                                   color: colorTertiary,
//                                 ),
//                               ),
//                               Text(
//                                 "${userProfile.rewardPoints} Poin",
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                   color: colorAccent,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           // Tambahkan tombol untuk mengedit profil jika diperlukan
//                           const SizedBox(height: 15),
//                           SizedBox(
//                             width: double.infinity,
//                             child: ElevatedButton.icon(
//                               onPressed: () {
//                                 // Aksi edit profil
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(content: Text('Fitur Edit Profil akan datang!')),
//                                 );
//                               },
//                               icon: const Icon(Icons.edit, color: Colors.white),
//                               label: const Text(
//                                 "Edit Profil",
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: colorSecondary,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 padding: const EdgeInsets.symmetric(vertical: 12),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),

//                 // Bagian History Transaksi Pembelian
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//                   child: Text(
//                     "Riwayat Transaksi Pembelian",
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: colorTertiary,
//                     ),
//                   ),
//                 ),
//                 transactions.isEmpty
//                     ? Padding(
//                         padding: const EdgeInsets.all(20.0),
//                         child: Center(
//                           child: Text(
//                             "Belum ada riwayat transaksi.",
//                             style: TextStyle(color: colorTertiary.withOpacity(0.7), fontSize: 16),
//                           ),
//                         ),
//                       )
//                     : ListView.builder(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: transactions.length,
//                         itemBuilder: (context, index) {
//                           final transaction = transactions[index];
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
//                             child: Card(
//                               color: Colors.white,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               elevation: 3,
//                               child: ExpansionTile(
//                                 title: Text(
//                                   transaction.itemName,
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 18,
//                                     color: colorTertiary,
//                                   ),
//                                 ),
//                                 subtitle: Text(
//                                   "Total: Rp ${transaction.totalPrice.toStringAsFixed(0)}",
//                                   style: TextStyle(
//                                     color: colorAccent,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           "ID Transaksi: ${transaction.transactionId}",
//                                           style: TextStyle(color: colorTertiary.withOpacity(0.8)),
//                                         ),
//                                         Text(
//                                           "Jumlah: ${transaction.quantity}",
//                                           style: TextStyle(color: colorTertiary.withOpacity(0.8)),
//                                         ),
//                                         Text(
//                                           "Tanggal: ${transaction.transactionDate.day}/${transaction.transactionDate.month}/${transaction.transactionDate.year} ${transaction.transactionDate.hour}:${transaction.transactionDate.minute}",
//                                           style: TextStyle(color: colorTertiary.withOpacity(0.8)),
//                                         ),
//                                         const SizedBox(height: 10),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                 const SizedBox(height: 20),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }