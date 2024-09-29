import 'package:flutter/material.dart';
import 'product_detail_page.dart';

class ProductListPage extends StatelessWidget {
  final List<Product> products = [
    Product(
      name: "Product 1",
      description: "This is the first product. It has some very cool features.",
      imageUrl: "images/1.jpg",
      analytics: "50 sales this month.",
    ),
    Product(
      name: "Product 2",
      description:
          "This is the second product. It's even better than the first!",
      imageUrl: "images/2.jpg",
      analytics: "70 sales this month.",
    ),
    Product(
      name: "Product 3",
      description:
          "This is the third product. It's even better than the first!",
      imageUrl: "images/3.jpg",
      analytics: "70 sales this month.",
    ),
    Product(
      name: "Product 4",
      description:
          "This is the fourth product. It's even better than the first!",
      imageUrl: "images/4.jpg",
      analytics: "70 sales this month.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            leading: Image.network(
              product.imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(product.name),
            subtitle:
                Text(product.description.split(' ').take(5).join(' ') + "..."),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailPage(product: product),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Product {
  final String name;
  final String description;
  final String imageUrl;
  final String analytics;

  Product({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.analytics,
  });
}
