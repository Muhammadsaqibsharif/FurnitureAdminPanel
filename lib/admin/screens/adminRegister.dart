import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ui'; 
import 'admin_login.dart'; 

class AdminRegister extends StatefulWidget {
  const AdminRegister({super.key});

  @override
  State<AdminRegister> createState() => _AdminRegisterState();
}

class _AdminRegisterState extends State<AdminRegister> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();
  bool hiddenPassword = true;
  bool isLoading = false; // State variable for loading

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void registerAdmin() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true; // Set loading to true
      });

      try {
        // Create the user in Firebase Auth
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        User? user = userCredential.user;

        if (user != null) {
          // Save user data in Firestore
          await _firestore.collection('Admins').doc(user.uid).set({
            'name': nameController.text.trim(),
            'email': emailController.text.trim(),
            'address': addressController.text.trim(),
            'adminId': user.uid,
          }).then((_) {
            // Show Snackbar for success
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Admin Registered Successfully")),
            );

            // Navigate to Admin Login Page
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AdminLogin()),
            );
          }).catchError((error) {
            Fluttertoast.showToast(msg: "Firestore Error: $error");
          });
        }
      } catch (e) {
        Fluttertoast.showToast(msg: "Error: ${e.toString()}");
      } finally {
        setState(() {
          isLoading = false; // Set loading to false
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.brown,
                  Colors.brown.shade900,
                ]),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 19),
                child: Text(
                  "Hello Admin\nSign up!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 160.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Colors.white,
                ),
                height: double.infinity,
                width: double.infinity,
                child: Form(
                  key: formKey,
                  child: ListView(
                    children: [
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: TextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter name";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.check),
                            labelText: "Name",
                            labelStyle: TextStyle(
                              color: Colors.brown.shade500,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: TextFormField(
                          controller: addressController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter address";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.check),
                            labelText: "Address",
                            labelStyle: TextStyle(
                              color: Colors.brown.shade500,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter email";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.check),
                            labelText: "Email",
                            labelStyle: TextStyle(
                              color: Colors.brown.shade500,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: hiddenPassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter password";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hiddenPassword = !hiddenPassword;
                                });
                              },
                              icon: hiddenPassword
                                  ? Icon(Icons.visibility_off,
                                      color: Colors.grey.withOpacity(0.6))
                                  : Icon(Icons.visibility, color: Colors.brown),
                            ),
                            labelText: "Password",
                            labelStyle: TextStyle(
                              color: Colors.brown.shade500,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Container(
                          height: 50,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(colors: [
                              Colors.brown.shade900,
                              Colors.brown,
                            ]),
                          ),
                          child: Center(
                            child: TextButton(
                              onPressed: registerAdmin,
                              child: Text(
                                "SIGN UP",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 93),
                      Padding(
                        padding: const EdgeInsets.only(right: 18.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Column(
                            children: [
                              Text(
                                "Already have an account?",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AdminLogin()), // Link to Admin Login
                                  );
                                },
                                child: Text(
                                  "Sign in",
                                  style: TextStyle(
                                      color: Colors.brown,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Blur effect and CircularProgressIndicator
            if (isLoading)
              Stack(
                children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
