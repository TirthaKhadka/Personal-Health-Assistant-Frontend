import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dashboard_page.dart'; 

class PneumoniaDetectPage extends StatefulWidget {
  const PneumoniaDetectPage({super.key});

  @override
  State<PneumoniaDetectPage> createState() => _PneumoniaDetectPageState();
}

class _PneumoniaDetectPageState extends State<PneumoniaDetectPage> {
  File? _image;
  bool _loading = false;
  String? _diagnosis;
  double? _probability;
  final ImagePicker _picker = ImagePicker();

  // For localization visualization
  Uint8List? _localizedImage;
  List<double>? _bbox; // [x, y, width, height]

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _diagnosis = null;
        _probability = null;
        _localizedImage = null;
        _bbox = null;
      });
    }
  }

  Future<void> _predict() async {
    if (_image == null) return;
    setState(() => _loading = true);

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://10.0.2.2:8000/predict'),
      );
      request.files.add(await http.MultipartFile.fromPath('file', _image!.path));
      var response = await request.send();
      var res = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        var data = json.decode(res.body);
        setState(() {
          _diagnosis = data['diagnosis'];
          _probability = (data['probability'] ?? 0).toDouble();

          // --- CASE 1: Localized image (Base64 string) ---
          if (data['localized_image'] != null) {
            final base64Str = data['localized_image'].split(',').last;
            _localizedImage = base64Decode(base64Str);
          }

          // --- CASE 2: Bounding box coordinates ---
          if (data['bbox'] != null && data['bbox'] is List) {
            _bbox = List<double>.from(
                (data['bbox'] as List).map((v) => (v as num).toDouble()));
          }
        });
      } else {
        setState(() => _diagnosis = "Server Error ${response.statusCode}");
      }
    } catch (e) {
      setState(() => _diagnosis = "Error: $e");
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const DashboardPage()),
            );
          },
        ),
        title: Row(
          children: const [
            Icon(Icons.add_box_rounded, color: Color(0xFFE655A8)),
            SizedBox(width: 6),
            Text(
              "PneumoniaDetect",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.help_outline, color: Colors.black54),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Upload X-Ray Image",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Upload a clear chest X-ray to begin analysis.",
              style: TextStyle(fontSize: 14, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),

            // --- Image preview section ---
            Container(
              height: 280,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFE655A8).withOpacity(0.3),
                ),
                borderRadius: BorderRadius.circular(16),
                color: const Color(0xFFE655A8).withOpacity(0.03),
              ),
              child: Center(
                child: _image == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.image_outlined,
                              color: Color(0xFFE655A8), size: 48),
                          SizedBox(height: 10),
                          Text(
                            "No image selected. Upload to see preview.",
                            style: TextStyle(color: Colors.black45),
                          ),
                        ],
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: _localizedImage != null
                            ? Image.memory(_localizedImage!,
                                fit: BoxFit.contain,
                                width: double.infinity,
                                height: 280)
                            : (_bbox != null
                                ? LayoutBuilder(
                                    builder: (context, constraints) {
                                      return Stack(
                                        children: [
                                          Image.file(
                                            _image!,
                                            fit: BoxFit.contain,
                                            width: double.infinity,
                                            height: 280,
                                          ),
                                          Positioned(
                                            left: _bbox![0],
                                            top: _bbox![1],
                                            child: Container(
                                              width: _bbox![2],
                                              height: _bbox![3],
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: const Color.fromARGB(255, 54, 244, 54),
                                                    width: 3),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  )
                                : Image.file(
                                    _image!,
                                    fit: BoxFit.contain,
                                    width: double.infinity,
                                    height: 280,
                                  )),
                      ),
              ),
            ),

            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _pickImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE655A8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                icon: const Icon(Icons.upload_file_rounded, color: Colors.white),
                label: const Text(
                  "Upload from Device",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "This is an AI-powered tool and not a substitute for a\nmedical diagnosis. Always consult a healthcare professional.",
              style: TextStyle(color: Colors.black45, fontSize: 12),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (_image == null || _loading) ? null : _predict,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE655A8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Analyze Image",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 20),
            if (_diagnosis != null)
              Column(
                children: [
                  Text(
                    "Diagnosis: $_diagnosis",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  if (_probability != null)
                    Text(
                      "Confidence: ${(_probability! * 100).toStringAsFixed(2)}%",
                      style: const TextStyle(color: Colors.black54),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
