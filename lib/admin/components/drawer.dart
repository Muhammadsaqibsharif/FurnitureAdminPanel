import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Auth for sign out (if using Firebase)
import 'package:furniture/admin/screens/admin_login.dart';

class AdminDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.brown,
            ),
            child: Text(
              'Admin Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Dashboard'),
            onTap: () {
              Navigator.pop(context); // Handle home navigation
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            onTap: () {
              Navigator.pop(context); // Handle notifications navigation
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () async {
              // Sign out user and clear session
              try {
                await FirebaseAuth.instance.signOut(); // Firebase sign out
                // Navigate to the login page and clear the navigation stack
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AdminLogin()), // Replace with your login page
                );
              } catch (e) {
                // Handle any errors during sign out (optional)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('Error signing out. Please try again.')),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
