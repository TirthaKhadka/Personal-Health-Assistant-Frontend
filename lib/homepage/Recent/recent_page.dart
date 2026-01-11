import 'package:flutter/material.dart';

class RecentPage extends StatelessWidget {
  final dynamic loggedInUser;

  const RecentPage({super.key, this.loggedInUser});

  @override
  Widget build(BuildContext context) {
    // Dummy recent items
    final recentItems = List.generate(
        10, (index) => "Recent item ${index + 1}"); 

    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Dark background
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F1F1F),
        title: const Text(
          "Recent",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: recentItems.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE655A8), width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  recentItems[index],
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.pink[400],
                  size: 18,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
