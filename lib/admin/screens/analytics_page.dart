import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Furniture Sales Analytics"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Overview",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),

              // Row showing key percentages with Circular Percent Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildCircularIndicator(
                    title: "Sales Growth",
                    percentage: 0.75,
                    percentLabel: "75%",
                    color: Colors.green,
                  ),
                  _buildCircularIndicator(
                    title: "Income Growth",
                    percentage: 0.60,
                    percentLabel: "60%",
                    color: Colors.blue,
                  ),
                  _buildCircularIndicator(
                    title: "Profit Increase",
                    percentage: 0.85,
                    percentLabel: "85%",
                    color: Colors.orange,
                  ),
                ],
              ),

              SizedBox(height: 40),

              Text(
                "Key Metrics",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),

              // Metrics summary cards
              _buildSummaryCard(
                title: "Total Sales",
                value: "\RS.100,000",
                icon: Icons.shopping_cart_outlined,
                color: Colors.purple,
              ),
              SizedBox(height: 10),
              _buildSummaryCard(
                title: "Total Income",
                value: "\RS.75,000",
                icon: Icons.monetization_on_outlined,
                color: Colors.teal,
              ),
              SizedBox(height: 10),
              _buildSummaryCard(
                title: "Total Profit",
                value: "\RS.25,000",
                icon: Icons.attach_money,
                color: Colors.blue,
              ),

              SizedBox(height: 40),

              Text(
                "Monthly Trends",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),

              // Placeholder for future graph or trend analysis
              Container(
                height: 200,
                color: Colors.grey[200],
                child: Center(
                  child: Text(
                    "Graph Placeholder (e.g., Line Chart)",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget to build a circular percent indicator
  Widget _buildCircularIndicator({
    required String title,
    required double percentage,
    required String percentLabel,
    required Color color,
  }) {
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 75.0,
          lineWidth: 10.0,
          percent: percentage,
          center: Text(
            percentLabel,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
          progressColor: color,
        ),
        SizedBox(height: 10),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }

  // Widget to build a summary card with an icon and a value
  Widget _buildSummaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              icon,
              size: 40,
              color: color,
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  value,
                  style: TextStyle(fontSize: 24, color: Colors.grey[700]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
