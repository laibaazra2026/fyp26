import 'package:flutter/material.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  final List<Map<String, dynamic>> onboardingData = [
    {
      "icon": Icons.security_rounded,
      "title": "Protect Your Phone",
      "description":
          "Advanced security system that keeps your device safe from theft and unauthorized access.",
      "color": Color(0xFF6A1B9A),
    },
    {
      "icon": Icons.location_on,
      "title": "Real-Time GPS Tracking",
      "description":
          "Track your phone's live location instantly when it is lost or stolen.",
      "color": Color(0xFF4A148C),
    },
    {
      "icon": Icons.camera_alt,
      "title": "Intruder Capture",
      "description":
          "Automatically captures photos of anyone trying to unlock your phone.",
      "color": Color(0xFF2C0A4D),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip Button
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                ),
                child: const Text(
                  "Skip",
                  style: TextStyle(color: Color(0xFF6A1B9A), fontSize: 16),
                ),
              ),
            ),

            // Onboarding Pages
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value) => setState(() => currentPage = value),
                itemCount: onboardingData.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          onboardingData[index]["icon"],
                          size: 140,
                          color: onboardingData[index]["color"],
                        ),
                        const SizedBox(height: 50),
                        Text(
                          onboardingData[index]["title"],
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          onboardingData[index]["description"],
                          style: const TextStyle(
                            fontSize: 17,
                            color: Colors.black54,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Dots Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) => buildDot(index)),
            ),

            const SizedBox(height: 40),

            // Next / Get Started Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    if (currentPage == 2) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6A1B9A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    currentPage == 2 ? "Get Started" : "Next",
                    style: const TextStyle(fontSize: 18, color: Colors.white),
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

  Widget buildDot(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 10,
      width: currentPage == index ? 30 : 10,
      decoration: BoxDecoration(
        color: currentPage == index
            ? const Color(0xFF6A1B9A)
            : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
