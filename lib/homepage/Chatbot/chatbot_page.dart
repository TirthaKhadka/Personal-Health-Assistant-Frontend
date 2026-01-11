import 'package:flutter/material.dart';
import 'package:personal_health_assistant/homepage/dashboard_page.dart';
import 'package:personal_health_assistant/homepage/user.dart';

class ChatbotPage extends StatelessWidget {
  final User loggedInUser;

  const ChatbotPage({super.key, required this.loggedInUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4F7),

      // ✅ AppBar with automatic back button
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF4F7),
        elevation: 0,

        // 🔴 OVERRIDE BACK BUTTON
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFFE84C88)),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => DashboardPage(
                  loggedInUser: loggedInUser, // pass your user if needed
                ),
              ),
            );
          },
        ),

        title: Row(
          children: [
            const Text(
              "Pulmo Check",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE84C88),
              ),
            ),
            const SizedBox(width: 6),
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            const Text(
              "Assistant Online",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 30),

            // Center Icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFFFD6E5),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(Icons.air, size: 40, color: Color(0xFFE84C88)),
            ),

            const SizedBox(height: 20),

            const Text(
              "Welcome to",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const Text(
              "Pulmo Check",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE84C88),
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Your personal lung health companion.\nHow can I assist you today?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),

            const SizedBox(height: 30),

            _optionCard(
              icon: Icons.medical_services,
              title: "Check Symptoms",
              subtitle: "Fast assessment of your breath",
            ),
            _optionCard(
              icon: Icons.description,
              title: "View Reports",
              subtitle: "Access your historical health data",
            ),
            _optionCard(
              icon: Icons.call,
              title: "Talk to a Doctor",
              subtitle: "Schedule a virtual consultation",
            ),

            const Spacer(),

            _chatInput(),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  static Widget _chatInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Type a message...",
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFE84C88),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_upward, color: Colors.white),
              onPressed: null,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.mic, color: Colors.grey),
        ],
      ),
    );
  }

  static Widget _optionCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFFFD6E5),
            child: Icon(icon, color: Color(0xFFE84C88)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}
