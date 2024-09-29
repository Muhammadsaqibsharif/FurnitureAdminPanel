import 'package:flutter/material.dart';
import 'package:furniture/admin/components/productListPage.dart';
import 'package:furniture/admin/screens/productRating.dart';
import 'analytics_page.dart';
import 'add_product_page.dart';
import 'user_management_page.dart';

class DashboardElements extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            // Analytics Feature
            DashboardGridItem(
              icon: Icons.analytics,
              title: "Analytics",
              color: Colors.blueAccent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnalyticsPage()),
                );
              },
            ),
            // Users Feature
            DashboardGridItem(
              icon: Icons.supervised_user_circle,
              title: "Users",
              color: Colors.green,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserManagementPage()),
                );
              },
            ),
            // Add Products Feature
            DashboardGridItem(
              icon: Icons.add_circle,
              title: "Add Products",
              color: Colors.orange,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProductPage()),
                );
              },
            ),
            // Update Products Feature
            DashboardGridItem(
              icon: Icons.update,
              title: "Update Products",
              color: Colors.purple,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductUpdateListPage()),
                );
              },
            ),
            DashboardGridItem(
              icon: Icons.reviews,
              title: "Products Ratings",
              color: Colors.blueGrey,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductRatingPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Custom widget for Grid Item
class DashboardGridItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final Function() onTap;

  const DashboardGridItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: color),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
