import 'package:flutter/material.dart';

class BloodReportInputPage extends StatefulWidget {
  const BloodReportInputPage({super.key});

  @override
  State<BloodReportInputPage> createState() => _BloodReportInputPageState();
}

class _BloodReportInputPageState extends State<BloodReportInputPage> {
  String selectedTest = '';
  Map<String, TextEditingController> controllers = {};

  final Map<String, List<String>> testParameters = {
    'Complete Blood Count (CBC)': [
      'Hemoglobin (g/dL)',
      'RBC (million/µL)',
      'WBC (cells/µL)',
      'Hematocrit (%)',
      'Platelet count',
      'MCV (fL)',
      'MCH (pg)',
      'MCHC (g/dL)',
      'Neutrophils (%)',
      'Lymphocytes (%)',
      'Monocytes (%)',
      'Eosinophils (%)',
      'Basophils (%)'
    ],
    'Lipid Profile': [
      'Total Cholesterol (mg/dL)',
      'LDL (mg/dL)',
      'HDL (mg/dL)',
      'Triglycerides (mg/dL)',
      'VLDL (mg/dL)'
    ],
    'Liver Function Test (LFT)': [
      'ALT (U/L)',
      'AST (U/L)',
      'ALP (U/L)',
      'Bilirubin Total (mg/dL)',
      'Bilirubin Direct (mg/dL)',
      'Bilirubin Indirect (mg/dL)',
      'Albumin (g/dL)',
      'Total Protein (g/dL)',
      'GGT (U/L)'
    ],
    'Kidney Function Test (KFT)': [
      'Serum Creatinine (mg/dL)',
      'BUN (mg/dL)',
      'Uric Acid (mg/dL)',
      'Sodium (mEq/L)',
      'Potassium (mEq/L)',
      'Chloride (mEq/L)',
      'eGFR (mL/min/1.73m²)'
    ],
    'Blood Sugar': [
      'Fasting Blood Sugar (mg/dL)',
      'Postprandial Blood Sugar (mg/dL)',
      'HbA1c (%)'
    ],
    'Thyroid Function Test (TFT)': [
      'TSH (µIU/mL)',
      'Free T4 (ng/dL)',
      'Free T3 (pg/mL)'
    ],
    'Vitamin & Minerals': [
      'Vitamin D (ng/mL)',
      'Vitamin B12 (pg/mL)',
      'Iron (µg/dL)',
      'Ferritin (ng/mL)',
      'TIBC (µg/dL)'
    ],
    'Inflammatory Markers': [
      'CRP (mg/L)',
      'ESR (mm/hr)'
    ],
  };

  @override
  void dispose() {
    controllers.forEach((key, value) => value.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Report Input'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Select Test Type',
                border: OutlineInputBorder(),
              ),
              value: testParameters.containsKey(selectedTest) ? selectedTest : null,
              items: testParameters.keys
                  .map((test) => DropdownMenuItem(
                        value: test,
                        child: Text(test),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedTest = value ?? '';
                  controllers.clear();
                  if (selectedTest.isNotEmpty) {
                    for (var param in testParameters[selectedTest]!) {
                      controllers[param] = TextEditingController();
                    }
                  }
                });
              },
            ),
            const SizedBox(height: 20),
            // Use Expanded for ListView only
            Expanded(
              child: selectedTest.isEmpty
                  ? const Center(child: Text('Select a test type to enter values'))
                  : ListView(
                      children: testParameters[selectedTest]!.map((param) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TextField(
                            controller: controllers[param],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: param,
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
            ),
            // Button outside Expanded
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Map<String, String> userInput = {};
                  controllers.forEach((key, controller) {
                    userInput[key] = controller.text;
                  });

                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Values Submitted'),
                      content: Text(userInput.entries
                          .map((e) => '${e.key}: ${e.value}')
                          .join('\n')),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'),
                        )
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE655A8),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Get My Insights',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
