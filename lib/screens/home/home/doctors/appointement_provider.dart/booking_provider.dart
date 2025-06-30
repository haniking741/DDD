import 'package:dawini/screens/home/home/doctors/appointement_provider.dart/appointement_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppointmentProvider extends ChangeNotifier {
  final _supabase = Supabase.instance.client;
  final Map<String, List<Appointment>> _appointmentsByDoctor = {};

  List<Appointment> getAppointmentsForDoctor(String doctorId) {
    return _appointmentsByDoctor[doctorId] ?? [];
  }

  Future<void> fetchAppointmentsForDoctor(String doctorId) async {
    
    final response = await _supabase
        .from('appointements')
        .select()
        .eq('doctor_id', doctorId)
        .order('date', ascending: true);

    final data = response as List<dynamic>;
    _appointmentsByDoctor[doctorId] =
        data.map((e) => Appointment.fromMap(e as Map<String, dynamic>)).toList();
    notifyListeners();
  }

 Future<void> addAppointment(String doctorId, Appointment appointment) async {
  try {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      throw Exception("User not logged in.");
    }

    // 👤 Fetch client name from Supabase table "clients"
    final clientResponse = await _supabase
        .from('clients')
        .select('full_name')
        .eq('id', user.id)
        .maybeSingle();

    if (clientResponse == null) {
      throw Exception("Client not found in database.");
    }

    final clientName = clientResponse['full_name'] as String;

    final data = {
      'doctor_id': doctorId,
      'client_id': user.id,          // ✅ ID from Auth
      'client_name': clientName,     // ✅ Name from "clients"
      'date': appointment.date,
      'time': appointment.time,
      'type': appointment.type,
    };

    debugPrint("📤 Sending to Supabase: $data");

    final response = await _supabase
        .from('appointements')
        .insert(data)
        .select();

    debugPrint("✅ Supabase response: $response");

    // 🔁 Add locally
    final updated = Appointment(
      doctorId: doctorId,
      clientId: user.id,
      clientName: clientName,
      date: appointment.date,
      time: appointment.time,
      type: appointment.type,
    );

    _appointmentsByDoctor.putIfAbsent(doctorId, () => []);
    _appointmentsByDoctor[doctorId]!.add(updated);
    notifyListeners();
  } catch (e, s) {
    debugPrint("❌ Error inserting appointment: $e");
    debugPrint("📌 StackTrace: $s");
    rethrow;
  }
}


}
