import 'package:flutter/material.dart';
import '../services/firebase/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = authService.currentUser;
    final displayName = user?.displayName ?? 'User';
    final email = user?.email ?? 'user@email.com';
    final initials = _getInitials(displayName);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),

            // Header tengah
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const Center(
                    child: Text(
                      'Profile',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Avatar huruf
            CircleAvatar(
              radius: 50,
              backgroundColor: const Color(0xFFB2DFDB),
              child: Text(
                initials,
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),

            const SizedBox(height: 20),

            // Nama & email
            Text(
              displayName,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Text(
              email,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),

            const SizedBox(height: 24),

            // Tombol Edit Profile
            TextButton.icon(
              onPressed: () => _showEditProfileDialog(context, displayName, email),
              icon: const Icon(Icons.edit, size: 18),
              label: const Text('Edit Profile'),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF4CAF50),
              ),
            ),

            const SizedBox(height: 20),

            // Logout button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: InkWell(
                onTap: () async {
                  await authService.logout();
                  if (!context.mounted) return;
                  Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.logout, color: Colors.deepOrange),
                      SizedBox(width: 12),
                      Text(
                        'Log Out',
                        style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    } else if (parts.isNotEmpty && parts[0].length >= 2) {
      return parts[0].substring(0, 2).toUpperCase();
    } else {
      return 'U';
    }
  }

  void _showEditProfileDialog(BuildContext context, String currentName, String currentEmail) {
    final nameController = TextEditingController(text: currentName);
    final emailController = TextEditingController(text: currentEmail);

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Display Name'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final name = nameController.text.trim();
                final email = emailController.text.trim();

                try {
                  await authService.updateDisplayName(name);
                  await authService.updateEmail(email);

                  if (!context.mounted) return;
                  Navigator.pop(context);
                  setState(() {}); // refresh tampilan
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Gagal update: $e')),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}