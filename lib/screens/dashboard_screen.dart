import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _theftMode = false;
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Device Protection"),
        backgroundColor: const Color(0xFF6A1B9A),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(
                context,
                '/login',
              ); // ya pop karke login pe jaye
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Header
            Card(
              color: const Color(0xFF6A1B9A),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Color(0xFF6A1B9A)),
                ),
                title: Text(
                  "Hello, ${user?.email?.split('@')[0] ?? 'User'}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text(
                  "Your device is secure",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Theft Mode Big Toggle
            Card(
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text(
                      "Theft Protection Mode",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SwitchListTile(
                      title: Text(
                        _theftMode ? "ENABLED" : "DISABLED",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _theftMode ? Colors.green : Colors.red,
                        ),
                      ),
                      value: _theftMode,
                      onChanged: (value) {
                        setState(() => _theftMode = value);
                        // Yahan baad mein GPS + Background service start hoga
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              _theftMode
                                  ? "Theft Mode Activated! GPS Tracking Started"
                                  : "Theft Mode Deactivated",
                            ),
                            backgroundColor: _theftMode
                                ? Colors.green
                                : Colors.orange,
                          ),
                        );
                      },
                      activeColor: Colors.green,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Quick Features Grid
            const Text(
              "Security Features",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  _buildFeatureCard(
                    Icons.location_on,
                    "Live GPS",
                    "Track Location",
                  ),
                  _buildFeatureCard(
                    Icons.sim_card_alert,
                    "SIM Change",
                    "Alert System",
                  ),
                  _buildFeatureCard(
                    Icons.camera_alt,
                    "Intruder Capture",
                    "Auto Photo",
                  ),
                  _buildFeatureCard(
                    Icons.history,
                    "Activity Log",
                    "View History",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(IconData icon, String title, String subtitle) {
    return Card(
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("$title clicked (Coming Soon)")),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: const Color(0xFF6A1B9A)),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
