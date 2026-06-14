import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dashboard_screen.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({super.key});

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  bool _locationGranted = false;
  bool _cameraGranted = false;
  bool _isLoading = false;

  Future<void> _requestPermissions() async {
    setState(() => _isLoading = true);

    // Request Location
    final locationStatus = await Permission.location.request();
    _locationGranted = locationStatus.isGranted;

    // Request Camera
    final cameraStatus = await Permission.camera.request();
    _cameraGranted = cameraStatus.isGranted;

    setState(() => _isLoading = false);

    // Check if both are granted
    if (_locationGranted && _cameraGranted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please grant ALL permissions to continue"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.security_rounded,
              size: 100,
              color: Color(0xFF6A1B9A),
            ),
            const SizedBox(height: 40),
            const Text(
              "Required Permissions",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              "This app needs the following permissions to work properly:",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 40),

            // Location
            ListTile(
              leading: const Icon(Icons.location_on, color: Color(0xFF6A1B9A)),
              title: const Text("Location"),
              subtitle: const Text("For GPS Tracking"),
              trailing: Icon(
                _locationGranted ? Icons.check_circle : Icons.circle_outlined,
                color: _locationGranted ? Colors.green : Colors.grey,
              ),
            ),

            // Camera
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Color(0xFF6A1B9A)),
              title: const Text("Camera"),
              subtitle: const Text("For Intruder Capture"),
              trailing: Icon(
                _cameraGranted ? Icons.check_circle : Icons.circle_outlined,
                color: _cameraGranted ? Colors.green : Colors.grey,
              ),
            ),

            const SizedBox(height: 50),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _requestPermissions,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6A1B9A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Grant Permissions",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
