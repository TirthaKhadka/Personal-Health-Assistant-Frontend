import 'package:flutter/material.dart';
import 'Xray_page.dart'; // Make sure this file exists in /lib

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  // Pages for the bottom navigation
  final List<Widget> _pages = const [
    DashboardContent(),
    InsightsPage(),
    GoalsPage(),
    AssistantPage(),
  ];

  void _onItemTapped(int index) {
    if (index == 1) {
      // Navigate directly to PneumoniaDetectPage for "Data" tab
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PneumoniaDetectPage()),
      );
      return; // Do not change _selectedIndex
    }
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: _pages[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex > 0 ? _selectedIndex : 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFE655A8),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: "Data"),
          BottomNavigationBarItem(icon: Icon(Icons.insights), label: "Insights"),
          BottomNavigationBarItem(icon: Icon(Icons.flag), label: "Goals"),
          BottomNavigationBarItem(icon: Icon(Icons.smart_toy), label: "Assistant"),
        ],
      ),
    );
  }
}

// ---------------- Dashboard Content -----------------
class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Dashboard",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.grey),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.pink.shade50,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Today's Snapshot",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                Text("Your Health Score", style: TextStyle(color: Colors.black54)),
                SizedBox(height: 8),
                Text("82",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink)),
                SizedBox(height: 8),
                Text(
                    "You're on track today! Keep walking, stay hydrated, and maintain your activity momentum.",
                    style: TextStyle(color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- Insights Page -----------------
class InsightsPage extends StatelessWidget {
  const InsightsPage({super.key});

  @override
  Widget build(BuildContext context) => const Center(
        child: Text("Insights Page", style: TextStyle(color: Colors.pink)),
      );
}

// ---------------- Goals Page -----------------
class GoalsPage extends StatelessWidget {
  const GoalsPage({super.key});

  @override
  Widget build(BuildContext context) => const Center(
        child: Text("Goals Page", style: TextStyle(color: Colors.pink)),
      );
}

// ---------------- Assistant Page -----------------
class AssistantPage extends StatelessWidget {
  const AssistantPage({super.key});

  @override
  Widget build(BuildContext context) => const Center(
        child: Text("Assistant Page", style: TextStyle(color: Colors.pink)),
      );
}
