import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart'; // Add this package for displaying stars

class ProductRatingPage extends StatefulWidget {
  @override
  _ProductRatingPageState createState() => _ProductRatingPageState();
}

class _ProductRatingPageState extends State<ProductRatingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Product List with Ratings",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.brown,
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // If products are available
          final products = snapshot.data!.docs;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              var product = products[index];
              double initialRating = product['rating'] != null
                  ? product['rating'] * 1.0
                  : 0.0; // Use product rating or default to 0.0

              return ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: Image.network(
                  product['imageUrl'],
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(product['name']),
                subtitle: Text("PKR ${product['price']}"),
                trailing: RatingBar.builder(
                  initialRating: initialRating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 25,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) async {
                    // Update product rating in Firestore when user changes rating
                    await FirebaseFirestore.instance
                        .collection('products')
                        .doc(product.id)
                        .update({'rating': rating});

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Rating updated to $rating')),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
