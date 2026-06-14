import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'permission_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phone;
  final String altPhone;

  const OtpVerificationScreen({
    super.key,
    required this.phone,
    required this.altPhone,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();

  String verificationId = "";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    sendOtp();
  }

  Future<void> sendOtp() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: widget.phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.message ?? "OTP Failed")));
      },
      codeSent: (String verId, int? resendToken) {
        verificationId = verId;
      },
      codeAutoRetrievalTimeout: (String verId) {
        verificationId = verId;
      },
    );
  }

  Future<void> verifyOtp() async {
    setState(() => isLoading = true);

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: _otpController.text.trim(),
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const PermissionScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Invalid OTP")));
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF6A1B9A);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Phone Verification"),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.sms_outlined, size: 100, color: primaryColor),

            const SizedBox(height: 20),

            Text("OTP sent to ${widget.phone}", textAlign: TextAlign.center),

            const SizedBox(height: 30),

            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Enter OTP",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: isLoading ? null : verifyOtp,
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Verify OTP"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
