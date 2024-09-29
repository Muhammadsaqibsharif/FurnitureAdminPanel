import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserManagementPage extends StatelessWidget {
  
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User Management",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.brown,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: usersCollection.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error loading users'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No users found'));
            }

            // List of user documents from Firestore
            final userDocs = snapshot.data!.docs;

            return ListView.builder(
              itemCount: userDocs.length,
              itemBuilder: (context, index) {
                final user = userDocs[index];
                final userName = user['name'] ?? 'No Name';
                final userEmail = user['email'] ?? 'No Email';

                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Icon(Icons.person, color: Colors.blueAccent),
                    title: Text(
                      userName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(userEmail),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteUser(user.id),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  // Function to delete a user by document ID
  Future<void> _deleteUser(String userId) async {
    try {
      await usersCollection.doc(userId).delete();
      print("User deleted: $userId");
    } catch (error) {
      print("Error deleting user: $error");
    }
  }
}
