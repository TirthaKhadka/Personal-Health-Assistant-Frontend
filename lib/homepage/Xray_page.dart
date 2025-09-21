import 'package:flutter/material.dart';

class XrayPage extends StatelessWidget {
  const XrayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController patientNameController = TextEditingController();
    final TextEditingController reportIdController = TextEditingController();
    final TextEditingController notesController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("X-Ray Report"),
        backgroundColor: const Color(0xFFE655A8),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Enter X-Ray Details",
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
                  prefixIcon: const Icon(Icons.person, color: Color(0xFFE655A8)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Report ID
              TextField(
                controller: reportIdController,
                decoration: InputDecoration(
                  labelText: "Report ID",
                  prefixIcon: const Icon(Icons.assignment, color: Color(0xFFE655A8)),
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
                  labelText: "Notes / Observations",
                  prefixIcon: const Icon(Icons.notes, color: Color(0xFFE655A8)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 24),

              // Upload Button
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Add file picker for X-ray image upload
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("X-Ray image upload coming soon...")),
                  );
                },
                icon: const Icon(Icons.upload_file, color: Colors.white),
                label: const Text(
                  "Upload X-Ray Image",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE655A8),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Save Button
              ElevatedButton(
                onPressed: () {
                  // TODO: Save X-ray report logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("X-Ray report saved successfully!")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFE655A8),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Save Report",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
