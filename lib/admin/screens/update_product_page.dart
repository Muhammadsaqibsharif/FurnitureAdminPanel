import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateProductPage extends StatefulWidget {
  final DocumentSnapshot product; // Product data passed from the previous screen

  UpdateProductPage({required this.product});

  @override
  _UpdateProductPageState createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    // Pre-fill the form with existing product data
    nameController.text = widget.product['name'];
    descriptionController.text = widget.product['description'];
    priceController.text = widget.product['price'];
  }

  Future<void> updateProduct() async {
    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(widget.product.id)
          .update({
        'name': nameController.text.trim(),
        'description': descriptionController.text.trim(),
        'price': priceController.text.trim(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product updated successfully')),
      );

      Navigator.pop(context); // Go back to the product list page
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating product: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Price (PKR)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: updateProduct,
              child: isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Update Product'),
            ),
          ],
        ),
      ),
    );
  }
}
