import 'package:flutter/material.dart';
import 'checkup_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class ViewCheckupsPage extends StatefulWidget {
  final String backendUrl;

  const ViewCheckupsPage({super.key, required this.backendUrl});

  @override
  State<ViewCheckupsPage> createState() => _ViewCheckupsPageState();
}

class _ViewCheckupsPageState extends State<ViewCheckupsPage> {
  late Future<List<Checkup>> checkupsFuture;

  Future<List<Checkup>> fetchCheckups() async {
    final response = await http.get(Uri.parse(widget.backendUrl));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => Checkup.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load checkups");
    }
  }

  Future<void> deleteCheckup(int id) async {
    final url = Uri.parse("${widget.backendUrl}/$id");
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      setState(() {
        checkupsFuture = fetchCheckups();
      });
    } else {
      throw Exception("Failed to delete checkup");
    }
  }

  @override
  void initState() {
    super.initState();
    checkupsFuture = fetchCheckups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Routine Checkups",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFFE655A8),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navigate to add page (your logic)
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Checkup>>(
        future: checkupsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No checkups found"));
          } else {
            final checkups = snapshot.data!;
            return ListView.builder(
              itemCount: checkups.length,
              itemBuilder: (context, index) {
                final c = checkups[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top row: name + date
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              c.patientName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20, // Bigger name
                              ),
                            ),
                            Text(
                              c.createdAt != null
                                  ? DateFormat("dd/MM/yyyy\nhh:mm a")
                                      .format(c.createdAt!)
                                  : "Date not available",
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),

                        const SizedBox(height: 6),
                        Text(
                          "Age: ${c.age}",
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black87),
                        ),

                        const SizedBox(height: 20),

                        // Vitals row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildVital("Blood Pressure",
                                c.bloodPressure ?? "N/A"),
                            _buildVital("Heart Rate",
                                "${c.heartRate ?? 'N/A'} bpm"),
                            _buildVital("Weight",
                                "${c.weight ?? 'N/A'} kg"),
                          ],
                        ),

                        const SizedBox(height: 14),
                        const Divider(
                          thickness: 1,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),

                        const SizedBox(height: 8),

                        // Notes + Delete in one row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Notes text
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black),
                                  children: [
                                    const TextSpan(
                                      text: "Notes: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    TextSpan(
                                      text: c.notes ?? "N/A",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontStyle: FontStyle.italic,
                                        color:
                                            Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Delete button inline
                            IconButton(
                              icon: const Icon(Icons.delete,
                                  color: const Color(0xFFE655A8)),
                              onPressed: () async {
                                if (c.id != null) {
                                  await deleteCheckup(c.id!);
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          "Error: Checkup ID is missing"),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildVital(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18, // Bigger values
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
