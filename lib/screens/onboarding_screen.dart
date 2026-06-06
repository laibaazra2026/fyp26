import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:device_security_system/screens/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;

  final Color primaryPurple = const Color(0xFF8E24AA);

  final List<Map<String, dynamic>> pages = [
    {
      "icon": Icons.shield_outlined,
      "title": "Protect Your Device",
      "description":
          "Track your device location and keep it safe from theft and unauthorized access.",
    },
    {
      "icon": Icons.lock_outline,
      "title": "Activate Theft Mode",
      "description":
          "Enable advanced protection features to lock and secure your device automatically.",
    },
    {
      "icon": Icons.verified_user_outlined,
      "title": "Grant Permissions",
      "description":
          "Allow location, notifications and security permissions for complete protection.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),

            currentPage != 2
                ? Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Skip",
                          style: GoogleFonts.poppins(
                            color: primaryPurple,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(height: 48),

            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          pages[index]["icon"],
                          size: 180,
                          color: primaryPurple,
                        ),

                        const SizedBox(height: 40),

                        Text(
                          pages[index]["title"],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: primaryPurple,
                          ),
                        ),

                        const SizedBox(height: 20),

                        Text(
                          pages[index]["description"],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.black54,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: currentPage == index ? 22 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: currentPage == index
                        ? primaryPurple
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    if (currentPage < pages.length - 1) {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  LoginScreen(),
                        ),
                      );
                    }
                  },
                  child: Text(
                    currentPage == pages.length - 1 ? "Get Started" : "Next",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
