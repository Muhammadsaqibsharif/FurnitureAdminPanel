import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:furniture/admin/screens/adminRegister.dart';
import 'package:furniture/admin/screens/admin_dashboard.dart';
import 'package:furniture/admin/screens/admin_login.dart';
import 'package:furniture/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(FurnitureApp());
}

class FurnitureApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Furniture',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => AdminLogin(),
        'admin_Register': (context) => AdminRegister(),
        '/admin_Dashboard': (context) => AdminDashboard(),
      },
    );
  }
}
