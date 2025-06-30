import 'package:dawini/screens/home/home/doctors/doctors_provider/doctors_model/doctorf_models.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DoctorProvider extends ChangeNotifier {
  final List<Doctor> _doctors = [];
  final SupabaseClient client = Supabase.instance.client;

  List<Doctor> get allDoctors => _doctors;

  List<Doctor> getDoctorsBySpecialty(String specialty) {
    return _doctors
        .where((d) => d.specialty.toLowerCase() == specialty.toLowerCase())
        .toList();
  }

  Future<void> fetchDoctorsBySpecialtyFromSupabase(String specialty) async {
  try {
    final response = await client
        .from('doctors')
        .select()
        .eq('speciality', specialty);

    if (response is List) {
      _doctors.clear();

      _doctors.addAll(response.map((json) {
        final workingHoursList = (json['working_hours'] as List?)?.map((e) => e.toString()).toList() ?? [];

        // Start & end from list if available, else fallback
        final startHour = workingHoursList.isNotEmpty ? workingHoursList.first : "08:00";
        final endHour = workingHoursList.length > 1 ? workingHoursList.last : "17:00";

        return Doctor(
          name: json['name'] ?? '',
          specialty: json['speciality'] ?? '',
          image: json['image_url'] ?? 'assets/icons/doctor.png',
          lat: (json['lat'] ?? 0).toDouble(),
          lng: (json['lng'] ?? 0).toDouble(),
          patients: json['patients'] ?? 0,
          experience: json['experience_years'] ?? 0,
          rating: (json['rating'] ?? 4.7).toDouble(),
          reviews: json['reviews'] ?? 100,
          workingDays: [1, 2, 3, 4, 6, 7], // لاحقاً يمكن جلبها من قاعدة البيانات
          workingHours: workingHoursList,
          offDates: (json['holidays'] as List?)?.map((e) => e.toString()).toList() ?? [],
          description: json['description'] ?? '',
          id: json['id'] ?? '',
        );
      }).toList());

      notifyListeners();
    }
  } catch (e) {
    debugPrint("❌ Error fetching doctors by specialty: $e");
  }
}

}
