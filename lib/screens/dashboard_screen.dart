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
              Navigator.pushReplacementNamed(context, '/'); // Go back to Login
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Card
            Card(
              child: ListTile(
                leading: const CircleAvatar(
                  radius: 35,
                  backgroundColor: Color(0xFF6A1B9A),
                  child: Icon(Icons.person, size: 40, color: Colors.white),
                ),
                title: Text(
                  user?.email?.split('@')[0] ?? "Welcome",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(user?.email ?? ""),
              ),
            ),

            const SizedBox(height: 25),

            // Theft Mode Toggle
            Card(
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Theft Mode",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Protect your device",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    Switch(
                      value: _theftMode,
                      onChanged: (value) {
                        setState(() => _theftMode = value);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              _theftMode
                                  ? "🛡️ Theft Mode ACTIVATED - GPS Started"
                                  : "Theft Mode OFF",
                            ),
                            backgroundColor: _theftMode
                                ? Colors.green
                                : Colors.orange,
                          ),
                        );
                      },
                      activeThumbColor: Colors.green,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Security Modules
            const Text(
              "Security Modules",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  _moduleCard(Icons.location_on, "GPS Tracking", "Live Map"),
                  _moduleCard(Icons.sim_card_alert, "SIM Change", "Alert"),
                  _moduleCard(
                    Icons.camera_alt,
                    "Intruder Capture",
                    "Auto Photo",
                  ),
                  _moduleCard(Icons.history, "Activity Log", "History"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _moduleCard(IconData icon, String title, String subtitle) {
    return Card(
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("$title - Coming Soon")));
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
