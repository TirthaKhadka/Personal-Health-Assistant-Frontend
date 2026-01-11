import 'package:flutter/material.dart';
import 'package:personal_health_assistant/homepage/login.dart';
import 'package:personal_health_assistant/homepage/user.dart'; // <-- your User model

class SettingsPage extends StatelessWidget {
  final User loggedInUser;

  const SettingsPage({
    super.key,
    required this.loggedInUser,
  });

  // ================= LOGOUT CONFIRMATION =================
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            "Logout",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            "Are you sure you want to logout?",
            style: TextStyle(fontSize: 15),
          ),
          actionsPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // close dialog
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE655A8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.pop(context); // close dialog
                _logout(context); // actual logout
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }

  // ================= ACTUAL LOGOUT =================
  void _logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => LoginPage()),
      (route) => false,
    );
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF1F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text("Settings", style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // ================= USER CARD =================
            Container(
              padding: const EdgeInsets.all(16),
              decoration: _cardDecoration(),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: const Color(0xFFFFD6E8),
                    child: const Icon(
                      Icons.person,
                      size: 30,
                      color: Color(0xFFE655A8),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loggedInUser.name,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          loggedInUser.email,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Edit",
                      style: TextStyle(color: Color(0xFFE655A8)),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ================= PREFERENCES =================
            _sectionTitle("PREFERENCES"),
            _settingsTile(Icons.palette, "Theme", "Light"),
            _settingsTile(Icons.straighten, "Units", "Metric"),

            const SizedBox(height: 24),

            // ================= PRIVACY =================
            _sectionTitle("PRIVACY & SECURITY"),
            _settingsTile(Icons.lock, "Change Password"),
            _settingsTile(Icons.policy, "Privacy Policy"),

            const SizedBox(height: 24),

            // ================= HEALTH =================
            _sectionTitle("HEALTH"),
            _settingsTile(Icons.favorite, "Daily Health Tips"),
            _settingsTile(Icons.monitor_heart, "Lung Check History"),

            const SizedBox(height: 30),

            // ================= LOGOUT BUTTON =================
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                side: const BorderSide(color: Color(0xFFE655A8)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () => _showLogoutDialog(context),
              icon: const Icon(Icons.logout, color: Color(0xFFE655A8)),
              label: const Text(
                "Logout",
                style: TextStyle(color: Color(0xFFE655A8)),
              ),
            ),

            const SizedBox(height: 16),
            const Text(
              "PulmoCheck Version 2.4.1",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  // ================= HELPERS =================
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _settingsTile(IconData icon, String title, [String? trailing]) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: _cardDecoration(),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFFFD6E8),
          child: Icon(icon, color: const Color(0xFFE655A8)),
        ),
        title: Text(title),
        trailing: trailing != null
            ? Text(trailing, style: const TextStyle(color: Colors.grey))
            : const Icon(Icons.chevron_right),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
        )
      ],
    );
  }
}
