import 'package:flutter/material.dart';
import '../services/firebase/auth_service.dart'; // Pastikan path ini benar

class ProfileScreen extends StatelessWidget {
  final authService = AuthService();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil data user yang sedang login dari AuthService
    final user = authService.currentUser;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Header dengan tombol kembali dan judul
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  const Text(
                    'Profile',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Foto profil
            CircleAvatar(
              radius: 48,
              backgroundColor: Colors.grey.shade300,
              // Pastikan file 'assets/avatar.jpg' ada di proyek Anda
              backgroundImage: const AssetImage('assets/avatar.jpg'),
            ),
            const SizedBox(height: 16),

            // Nama & Email Pengguna
            Text(
              user?.displayName ?? 'User Name', // Tampilkan nama, atau 'User Name' jika null
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(
              user?.email ?? 'user@email.com', // Tampilkan email, atau placeholder jika null
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 40),

            // Tombol Logout
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: InkWell(
                // --- INI ADALAH BAGIAN YANG DIPERBAIKI ---
                onTap: () async {
                  // Tunggu proses logout dari AuthService selesai
                  await authService.logout();

                  // Cek apakah widget masih ada di tree sebelum navigasi (best practice)
                  if (!context.mounted) return;

                  // Pindah ke halaman login dan hapus semua halaman sebelumnya
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login', // Rute bernama untuk halaman login Anda
                    (Route<dynamic> route) => false,
                  );
                },
                // --- AKHIR BAGIAN YANG DIPERBAIKI ---
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      // Pastikan file 'assets/logout_icon.jpg' ada di proyek Anda
                      Image.asset(
                        'assets/logout_icon.jpg',
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Log Out',
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation & FAB (sesuai kode Anda sebelumnya)
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: const Icon(Icons.home_outlined), onPressed: () {
              // Mungkin navigasi kembali ke home?
              Navigator.popUntil(context, (route) => route.isFirst);
            }),
            const SizedBox(width: 48),
            IconButton(icon: const Icon(Icons.person_outline), onPressed: () {
              // Sudah di halaman profile, tidak perlu aksi
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFDCE775),
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.black),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}