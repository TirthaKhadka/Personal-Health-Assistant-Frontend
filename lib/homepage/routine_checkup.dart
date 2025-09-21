import 'package:flutter/material.dart';
import 'checkup_model.dart';
import 'view_checkups_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RoutineCheckupPage extends StatefulWidget {
  const RoutineCheckupPage({super.key});

  @override
  State<RoutineCheckupPage> createState() => _RoutineCheckupPageState();
}

class _RoutineCheckupPageState extends State<RoutineCheckupPage> {
  final TextEditingController patientNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController bloodPressureController = TextEditingController();
  final TextEditingController heartRateController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  final String backendUrl =
      'http://10.0.2.2:8081/api/checkups'; // Replace with your local IP

  Future<void> saveCheckup() async {
    final checkup = Checkup(
      id: null, // Provide an appropriate id value or generate one if needed
      patientName: patientNameController.text,
      age: int.tryParse(ageController.text) ?? 0,
      bloodPressure: bloodPressureController.text,
      heartRate: int.tryParse(heartRateController.text) ?? 0,
      weight: double.tryParse(weightController.text) ?? 0,
      notes: notesController.text,
      createdAt: DateTime.now(), // Added required parameter
    );

    try {
      final response = await http.post(
        Uri.parse(backendUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(checkup.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Routine checkup saved successfully!")),
        );

        // clear inputs
        patientNameController.clear();
        ageController.clear();
        bloodPressureController.clear();
        heartRateController.clear();
        weightController.clear();
        notesController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${response.statusCode}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Routine Checkup",
          style: TextStyle(
            color: Colors.white, // 👈 force white text
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFE655A8),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ), // also make icons white
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Enter Routine Checkup Details",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 20),

              // Patient Name
              TextField(
                controller: patientNameController,
                decoration: InputDecoration(
                  labelText: "Patient Name",
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Color(0xFFE655A8),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Age
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Age",
                  prefixIcon: const Icon(Icons.cake, color: Color(0xFFE655A8)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Blood Pressure
              TextField(
                controller: bloodPressureController,
                decoration: InputDecoration(
                  labelText: "Blood Pressure (e.g. 120/80 mmHg)",
                  prefixIcon: const Icon(
                    Icons.favorite,
                    color: Color(0xFFE655A8),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Heart Rate
              TextField(
                controller: heartRateController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Heart Rate (bpm)",
                  prefixIcon: const Icon(
                    Icons.monitor_heart,
                    color: Color(0xFFE655A8),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Weight
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Weight (kg)",
                  prefixIcon: const Icon(
                    Icons.fitness_center,
                    color: Color(0xFFE655A8),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Notes
              TextField(
                controller: notesController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: "Doctor Notes / Observations",
                  prefixIcon: const Icon(Icons.notes, color: Color(0xFFE655A8)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: saveCheckup,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE655A8),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Save Checkup",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ViewCheckupsPage(backendUrl: backendUrl),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE655A8),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "View All Checkups",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
