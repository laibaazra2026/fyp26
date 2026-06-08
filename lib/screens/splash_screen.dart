import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4A148C), Color(0xFF6A1B9A)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.scale(
                    scale: 0.9 + _controller.value * 0.15,
                    child: Container(
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 6),
                      ),
                      child: const Icon(
                        Icons.security_rounded,
                        size: 130,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),
              const Text(
                "THEFT PROTECTION",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Secure Your Phone",
                style: TextStyle(fontSize: 20, color: Colors.white70),
              ),
              const SizedBox(height: 60),
              const CircularProgressIndicator(color: Colors.white),
              const SizedBox(height: 40),
              const Text(
                "Powered by Firebase",
                style: TextStyle(color: Colors.white54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
