import 'package:flutter/material.dart';
import '../services/firebase/auth_service.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final usernameController = TextEditingController(); // Untuk field Username
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController(); // Untuk field Confirm Password
  final authService = AuthService();
  bool _agreeToTerms = false; // State untuk checkbox
  bool _passwordVisible = false; // State untuk ikon mata password
  bool _confirmPasswordVisible = false; // State untuk ikon mata confirm password

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background putih
      appBar: AppBar(
        backgroundColor: Colors.white, // AppBar background putih
        elevation: 0, // Tanpa shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Icon back hitam
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Back', // Tulisan 'Back'
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView( // Agar bisa discroll jika keyboard muncul
        padding: const EdgeInsets.all(24), // Padding sesuai gambar
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri
          children: [
            const Text(
              'Sign up',
              style: TextStyle(
                fontSize: 32, // Ukuran font 'Sign up'
                fontWeight: FontWeight.bold,
                color: Color(0xFF4CAF50), // Warna hijau
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Please put all your information to continue',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey, // Warna abu-abu
              ),
            ),
            const SizedBox(height: 32),

            // Field Username
            const Text(
              'Username',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                hintText: 'Your username', // Placeholder
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFF4CAF50)), // Warna hijau saat fokus
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
            const SizedBox(height: 20),

            // Field Email
            const Text(
              'Email',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress, // Keyboard email
              decoration: InputDecoration(
                hintText: 'youremail@emaildomain', // Placeholder
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFF4CAF50)),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
            const SizedBox(height: 20),

            // Field Password
            const Text(
              'Password',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: passwordController,
              obscureText: !_passwordVisible, // Mengatur visibilitas teks
              decoration: InputDecoration(
                hintText: 'Your password', // Placeholder
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFF4CAF50)),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible; // Mengubah state visibilitas
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Field Confirm Password
            const Text(
              'Confirm Password',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: confirmPasswordController,
              obscureText: !_confirmPasswordVisible, // Mengatur visibilitas teks
              decoration: InputDecoration(
                hintText: 'Your password', // Placeholder
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFF4CAF50)),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                suffixIcon: IconButton(
                  icon: Icon(
                    _confirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _confirmPasswordVisible = !_confirmPasswordVisible; // Mengubah state visibilitas
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Checkbox "Agree the terms of use and privacy policy"
            Row(
              children: [
                SizedBox(
                  width: 24, // Memperbaiki ukuran checkbox
                  height: 24, // Memperbaiki ukuran checkbox
                  child: Checkbox(
                    value: _agreeToTerms,
                    onChanged: (bool? newValue) {
                      setState(() {
                        _agreeToTerms = newValue ?? false;
                      });
                    },
                    activeColor: const Color(0xFF4CAF50), // Warna hijau saat aktif
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4), // Bentuk kotak
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Agree the terms of use and privacy policy',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Tombol Sign up
            SizedBox(
              width: double.infinity, // Lebar penuh
              height: 50, // Tinggi tombol
              child: ElevatedButton(
                onPressed: () async {
                  if (!_agreeToTerms) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Anda harus menyetujui syarat dan ketentuan')),
                    );
                    return;
                  }

                  if (passwordController.text != confirmPasswordController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Konfirmasi password tidak cocok')),
                    );
                    return;
                  }

                  // Menggunakan emailController.text dan passwordController.text untuk register
                  final user = await authService.register(emailController.text, passwordController.text);
                  if (user != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Register berhasil')),
                    );
                    Navigator.pop(context); // Kembali ke login
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Register gagal')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50), // Warna hijau
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                ),
                child: const Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Teks putih
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}