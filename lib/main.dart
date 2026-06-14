import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/admin_panel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(DeviceProtectionApp());
}

class DeviceProtectionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Device Protection',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            // Check if user is admin
            return FutureBuilder<bool>(
              future: _isAdmin(snapshot.data!.email),
              builder: (context, adminSnapshot) {
                if (adminSnapshot.data == true) {
                  return AdminPanel();
                }
                return HomeScreen();
              },
            );
          }
          return LoginScreen();
        },
      ),
    );
  }

  Future<bool> _isAdmin(String? email) async {
    if (email == null) return false;
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('admins')
        .doc(email)
        .get();
    return doc.exists;
  }
}
