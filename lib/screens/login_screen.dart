import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signup_screen.dart';
import 'dashboard_screen.dart'; // Baad mein banayenge

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() => _isLoading = true);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const DashboardScreen()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 80),
              const Icon(
                Icons.security_rounded,
                size: 100,
                color: Color(0xFF6A1B9A),
              ),
              const SizedBox(height: 40),
              const Text(
                "Welcome Back!",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Login to continue",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 50),

              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6A1B9A),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Login",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                ),
              ),

              TextButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const DashboardScreen()),
                ),
                child: const Text("Don't have an account? Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
