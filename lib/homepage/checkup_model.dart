class Checkup {
  final int? id;
  final String patientName;
  final int age;
  final String? bloodPressure;
  final int? heartRate;
  final double? weight;
  final String? notes;
  final DateTime? createdAt;

  Checkup({
    this.id,
    required this.patientName,
    required this.age,
    this.bloodPressure,
    this.heartRate,
    this.weight,
    this.notes,
    this.createdAt,
  });

  factory Checkup.fromJson(Map<String, dynamic> json) {
    return Checkup(
      id: json['id'],
      patientName: json['patientName'] ?? "Unknown",
      age: json['age'] ?? 0,
      bloodPressure: json['bloodPressure'] ?? "N/A",
      heartRate: json['heartRate'],
      weight: (json['weight'] != null) ? json['weight'].toDouble() : 0.0,
      notes: json['notes'] ?? "N/A",
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null, // Safe null check
    );
  }
Map<String, dynamic> toJson() {
  return {
    if (id != null) 'id': id,
    'patientName': patientName,
    'age': age,
    'bloodPressure': bloodPressure,
    'heartRate': heartRate,
    'weight': weight,
    'notes': notes,
    'createdAt': createdAt?.toIso8601String(),
  };
}
}