import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'register_screen.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final authService = AuthService();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 20),
              // Login title
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Please log into your account to continue',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 32),
              // Email / Username
              const Text(
                'Username / Email',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Your username or your email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
              const SizedBox(height: 20),
              // Password
              const Text(
                'Password',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Your password',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.visibility),
                    onPressed: () {},
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
              const SizedBox(height: 12),
              // Forgot Password link
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Sign in button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    final user = await authService.login(
                      emailController.text,
                      passwordController.text,
                    );
                    if (user != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Login berhasil')),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const DashboardScreen()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Login gagal')),
                      );
                    }
                  },
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Register text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Belum punya akun? '),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => RegisterScreen()),
                      );
                    },
                    child: const Text('Register'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
