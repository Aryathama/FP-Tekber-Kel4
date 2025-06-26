import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:nutricore/services/local/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil AuthService dari Provider agar terhubung dengan state aplikasi
    final authService = context.read<AuthService>();
    final user = authService.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.pop(), // Gunakan GoRouter untuk kembali
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // Foto Profil
            CircleAvatar(
              radius: 56,
              backgroundColor: Colors.grey.shade200,
              // Gunakan foto profil dari akun Google jika ada, jika tidak, tampilkan ikon
              backgroundImage: user?.photoURL != null ? NetworkImage(user!.photoURL!) : null,
              child: user?.photoURL == null
                  ? Icon(Icons.person, size: 60, color: Colors.grey.shade400)
                  : null,
            ),
            const SizedBox(height: 16),

            // Nama & Email Pengguna
            Text(
              user?.displayName ?? 'Nutricore User', // Tampilkan nama dari akun
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              user?.email ?? 'user@email.com', // Tampilkan email dari akun
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const Spacer(), // Mendorong tombol logout ke bawah

            // Tombol Logout
            InkWell(
              onTap: () async {
                await authService.logout();
                // Setelah logout, kembali ke halaman paling awal (AuthWrapper)
                if (context.mounted) {
                  context.go('/');
                }
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.logout, color: Colors.red),
                    SizedBox(width: 12),
                    Text(
                      'Log Out',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios, size: 16, color: Colors.red),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40), // Jarak dari bawah
          ],
        ),
      ),
    );
  }
}
