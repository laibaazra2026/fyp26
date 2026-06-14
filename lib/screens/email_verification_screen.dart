import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'otp_verification_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String phone;
  final String altPhone;

  const EmailVerificationScreen({
    super.key,
    required this.phone,
    required this.altPhone,
  });

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool _isLoading = false;

  Future<void> _checkVerification() async {
    setState(() => _isLoading = true);

    await FirebaseAuth.instance.currentUser?.reload();

    final user = FirebaseAuth.instance.currentUser;

    if (user != null && user.emailVerified) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => OtpVerificationScreen(
            phone: widget.phone,
            altPhone: widget.altPhone,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please verify your email first.")),
      );
    }

    setState(() => _isLoading = false);
  }

  Future<void> _resendEmail() async {
    await FirebaseAuth.instance.currentUser?.sendEmailVerification();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Verification email sent again.")),
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF6A1B9A);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Email Verification"),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.email_outlined, size: 100, color: primaryColor),

            const SizedBox(height: 20),

            const Text(
              "Verify Your Email",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            const Text(
              "A verification email has been sent to your email address. Open your inbox and verify your account.",
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _checkVerification,
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("I've Verified My Email"),
              ),
            ),

            const SizedBox(height: 15),

            TextButton(
              onPressed: _resendEmail,
              child: const Text("Resend Email"),
            ),
          ],
        ),
      ),
    );
  }
}
