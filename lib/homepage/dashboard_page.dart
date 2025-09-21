import 'package:flutter/material.dart';
import 'Blood_test_input.dart' as blood_test_input;
import 'Routine_checkup.dart';
import 'Xray_page.dart';



// ---------------- Main Dashboard -----------------
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  // Pages for each bottom nav item
  final List<Widget> _pages = const [
    DashboardContent(),
    MedicalReportsPage(),
    InsightsPage(),
    GoalsPage(),
    AssistantPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: _pages[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFE655A8),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: "Data"),
          BottomNavigationBarItem(
            icon: Icon(Icons.insights),
            label: "Insights",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.flag), label: "Goals"),
          BottomNavigationBarItem(
            icon: Icon(Icons.smart_toy),
            label: "Assistant",
          ),
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
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Dashboard",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.grey),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Today's Snapshot
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.pink.shade50,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Today's Snapshot",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  "Your Health Score",
                  style: TextStyle(color: Colors.black54),
                ),
                SizedBox(height: 8),
                Text(
                  "82",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "You're on track today! Keep walking, stay hydrated, and maintain your activity momentum.",
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Key Metrics
          const Text(
            "Key Metrics",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildMetricCard(
                "Steps",
                "8,532",
                "Last 7 Days +12%",
                Icons.directions_walk,
              ),
              _buildMetricCard(
                "Distance",
                "6.2 km",
                "Last 7 Days +9%",
                Icons.map,
              ),
              _buildMetricCard(
                "Calories Burned",
                "520 cal",
                "Last 7 Days +7%",
                Icons.local_fire_department,
              ),
              _buildMetricCard(
                "Heart Rate",
                "75 bpm",
                "Last 7 Days +3%",
                Icons.favorite,
              ),
              _buildMetricCard(
                "Sleep",
                "7.1 hrs",
                "Last 7 Days +5%",
                Icons.bed,
              ),
              _buildMetricCard(
                "Exercise",
                "140 min",
                "Last 7 Days +8%",
                Icons.fitness_center,
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _buildMetricCard(
    String title,
    String value,
    String change,
    IconData icon,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.pink, size: 28),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(color: Colors.black54)),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Text(
            change,
            style: const TextStyle(color: Colors.pink, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

// ---------------- Medical Reports Page -----------------
class MedicalReportsPage extends StatelessWidget {
  const MedicalReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Upload Reports",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildReportCard(
            context,
            title: "X-Ray",
            description:
                "Upload your X-ray reports for detecting pneumonia",
            imagePath: "assets/xray.jpeg",
            buttonText: "Upload",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => XrayPage()),
              );
            },
          ),
          const SizedBox(height: 16),
          _buildReportCard(
            context,
            title: "Blood Test Results",
            description:
                "Upload your blood test results for analysis and record-keeping.",
            imagePath: "assets/blood_test.jpeg",
            buttonText: "Check Blood Test Results",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const blood_test_input.BloodReportInputPage(),
                ),
              );
            },
          ),

          const SizedBox(height: 16),
          _buildReportCard(
            context,
            title: "Routine Checkups",
            description:
                "Upload your routine checkup reports for analysis and record-keeping.",
            imagePath: "assets/routine_checkup.jpeg",
            buttonText: "Check Routine Checkups",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RoutineCheckupPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReportCard(
    BuildContext context, {
    required String title,
    required String description,
    required String imagePath,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.pink.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
            child: Image.asset(
              imagePath,
              width: 100,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: onPressed,
                    icon: const Icon(Icons.upload, color: Colors.white),
                    label: Text(
                      buttonText,
                      style: const TextStyle(
                        color: Colors.white,
                      ), // text in white
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFE655A8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- Other Pages -----------------
class InsightsPage extends StatelessWidget {
  const InsightsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Insights Page",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.pink,
        ),
      ),
    );
  }
}

class GoalsPage extends StatelessWidget {
  const GoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Goals Page",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.pink,
        ),
      ),
    );
  }
}

class AssistantPage extends StatelessWidget {
  const AssistantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Assistant Page",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.pink,
        ),
      ),
    );
  }
}
