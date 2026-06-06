import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _zoomController;
  late AnimationController _pulseController;

  late Animation<double> _zoomAnimation;

  @override
  void initState() {
    super.initState();

    _zoomController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      lowerBound: 0.95,
      upperBound: 1.05,
    );

    _zoomAnimation = CurvedAnimation(
      parent: _zoomController,
      curve: Curves.easeOutBack,
    );

    _zoomController.forward();

    Future.delayed(const Duration(milliseconds: 1200), () {
      _pulseController.repeat(reverse: true);
    });

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
      // Navigate to Onboarding Screen here later
    });
  }

  @override
  void dispose() {
    _zoomController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: const Color(0xFF8E24AA),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: Listenable.merge([
                      _zoomController,
                      _pulseController,
                    ]),
                    builder: (context, child) {
                      double scale = _zoomController.isCompleted
                          ? _pulseController.value
                          : _zoomAnimation.value;

                      return Transform.scale(
                        scale: scale,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white24,
                                blurRadius: 50,
                                spreadRadius: 12,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.security,
                            size: 160,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 35),

                  Text(
                    "DEVICE PROTECTION",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    "Secure your device",
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                    ),
                  ),

                  const SizedBox(height: 40),

                  const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                ],
              ),
            ),

            Positioned(
              bottom: 60,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  "Developed by L&A",
                  style: GoogleFonts.poppins(
                    color: Colors.white70,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.5,
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
