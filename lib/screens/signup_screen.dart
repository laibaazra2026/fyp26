import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'email_verification_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _altPhoneController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _altPhoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    setState(() => _isLoading = true);

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final phone = _phoneController.text.trim();
    final altPhone = _altPhoneController.text.trim();
    final name = _nameController.text.trim();

    // ✅ VALIDATIONS
    if (name.isEmpty) {
      _showMsg("Enter full name");
      return;
    }

    if (email.isEmpty || !email.contains("@")) {
      _showMsg("Enter valid email");
      return;
    }

    if (password.length < 6) {
      _showMsg("Password must be at least 6 characters");
      return;
    }

    if (phone.isEmpty) {
      _showMsg("Enter phone number");
      return;
    }

    try {
      // ✅ CREATE USER
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // ✅ SEND EMAIL VERIFICATION
      final user = credential.user;
      if (user != null) {
        await user.sendEmailVerification();
      }

      // ✅ NAVIGATE TO NEXT SCREEN
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              EmailVerificationScreen(phone: phone, altPhone: altPhone),
        ),
      );
    } on FirebaseAuthException catch (e) {
      _showMsg(e.message ?? "Firebase error");
    } catch (e) {
      _showMsg(e.toString());
    }

    setState(() => _isLoading = false);
  }

  void _showMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Account"),
        backgroundColor: const Color(0xFF6A1B9A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Full Name"),
              ),
              const SizedBox(height: 15),

              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              const SizedBox(height: 15),

              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Main Phone Number",
                ),
              ),
              const SizedBox(height: 15),

              TextField(
                controller: _altPhoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Alternative Phone Number",
                ),
              ),
              const SizedBox(height: 15),

              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _signup,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6A1B9A),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Continue to Verification"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
