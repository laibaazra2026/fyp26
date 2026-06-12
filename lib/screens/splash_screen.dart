import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryPurple = Color(0xFF8E24AA);

    return Scaffold(
      backgroundColor: primaryPurple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shield_outlined, size: 180, color: Colors.white),

            const SizedBox(height: 20),

            Text(
              "DEVICE PROTECTION",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Secure Your Device",
              style: GoogleFonts.poppins(color: Colors.white70, fontSize: 16),
            ),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Text(
                "Developed by L&A",
                style: GoogleFonts.poppins(color: Colors.white60, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
