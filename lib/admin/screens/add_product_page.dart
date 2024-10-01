import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  String? selectedCategory;
  bool isLoading = false;
  File? _image;
  final picker = ImagePicker();

  // List of product categories
  final List<String> categories = [
    'All',
    'Bed',
    'Tables',
    'Chairs',
    'Sofa',
  ];

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        Fluttertoast.showToast(msg: 'No image selected.');
      }
    });
  }

  Future<void> uploadProduct() async {
    if (formKey.currentState!.validate()) {
      if (_image == null) {
        Fluttertoast.showToast(msg: 'Please select an image.');
        return;
      }
      if (selectedCategory == null) {
        Fluttertoast.showToast(msg: 'Please select a category.');
        return;
      }

      setState(() {
        isLoading = true;
      });

      try {
        // Upload image to Firebase Storage
        String imageUrl = '';
        Reference ref = FirebaseStorage.instance.ref().child(
            'product_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
        UploadTask uploadTask = ref.putFile(_image!);
        TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
        imageUrl = await snapshot.ref.getDownloadURL();

        // Add product to Firestore
        await FirebaseFirestore.instance.collection('products').add({
          'name': nameController.text.trim(),
          'description': descriptionController.text.trim(),
          'price': priceController.text.trim(),
          'category': selectedCategory,
          'imageUrl': imageUrl,
        });

        // Show success snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product added successfully')),
        );

        // Reset fields
        nameController.clear();
        descriptionController.clear();
        priceController.clear();
        setState(() {
          _image = null;
          selectedCategory = null;
        });
      } catch (e) {
        Fluttertoast.showToast(msg: 'Error adding product: $e');
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Product",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.brown,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    GestureDetector(
                      onTap: pickImage,
                      child: _image != null
                          ? Image.file(_image!, height: 200, fit: BoxFit.cover)
                          : Container(
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(Icons.add_a_photo, size: 100),
                            ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Product Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter product name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter product description';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    // Dropdown for product category
                    DropdownButtonFormField<String>(
                      value: selectedCategory,
                      hint: Text('Select Category'),
                      items: categories.map((category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a category';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Price (PKR)',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter price';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: uploadProduct,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        primary: Colors.brown, // Button color
                      ),
                      child: Text(
                        'Add Product',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (isLoading)
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
