class Appointment {
  final String clientId;
  final String clientName;
  final String date;
  final String time;
  final String type;
  final String? doctorId; // اختياري لتتبع الموعد حسب الطبيب إذا أردت

  Appointment({
    required this.clientId,
    required this.clientName,
    required this.date,
    required this.time,
    required this.type,
    this.doctorId,
  });

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      clientId: map['client_id'] ?? '',
      clientName: map['client_name'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      type: map['type'] ?? '',
      doctorId: map['doctor_id'], // ممكن يكون null
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'client_id': clientId,
      'client_name': clientName,
      'date': date,
      'time': time,
      'type': type,
      if (doctorId != null) 'doctor_id': doctorId,
    };
  }
}
