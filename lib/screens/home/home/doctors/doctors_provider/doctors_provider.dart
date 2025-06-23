import 'package:flutter/material.dart';
import 'package:dawini/screens/home/home/doctors/doctors_model/doctorf_models.dart';

class DoctorProvider extends ChangeNotifier {
  final List<Doctor> _doctors = [
    Doctor(
      name: "Dr. Aissoug Ziad",
      specialty: "Dentist",
      image: "assets/icons/doctor.png",
      lat: 35.400672,
      lng: 8.118525,
      patients: 1800,
      experience: 7,
      rating: 4.8,
      reviews: 120,
      workingDays: [1, 2, 3, 4, 6, 7],
      workingHours: ["08:00", "09:00", "10:00", "11:00"],
      offDates: [],
    ),
    Doctor(
      name: "Dr. Ramdhani Aissa",
      specialty: "Dentist",
      image: "assets/icons/doctor.png",
      lat: 35.396671,
      lng: 8.109620,
      patients: 1500,
      experience: 5,
      rating: 4.6,
      reviews: 97,
      workingDays: [1, 2, 3, 4, 6, 7],
      workingHours: ["09:00", "10:00", "14:00"],
      offDates: [],
    ),
    Doctor(
      name: "Dr. Khaled Messaoud",
      specialty: "Neurologue",
      image: "assets/icons/doctor.png",
      lat: 36.7550,
      lng: 3.0485,
      patients: 2200,
      experience: 9,
      rating: 4.9,
      reviews: 164,
      workingDays: [1, 2, 3, 4, 6, 7],

      workingHours: ["08:00", "10:00", "16:00"],
      offDates: [],
    ),
    Doctor(
      name: "Dr. Selma Djouadi",
      specialty: "Génécologue",
      image: "assets/icons/doctor.png",
      lat: 36.7577,
      lng: 3.0432,
      patients: 1700,
      experience: 6,
      rating: 4.7,
      reviews: 109,
      workingDays: [1, 2, 3, 4, 6, 7],

      workingHours: ["09:00", "13:00", "15:00"],
      offDates: [],
    ),
    Doctor(
      name: "Dr. Yasmine Bouteldja",
      specialty: "Generaliste",
      image: "assets/icons/doctor.png",
      lat: 36.7588,
      lng: 3.0466,
      patients: 1300,
      experience: 4,
      rating: 4.5,
      reviews: 88,
      workingDays: [1, 2, 3, 4, 6, 7],

      workingHours: ["08:00", "09:00", "11:00", "14:00"],
      offDates: [],
    ),
    Doctor(
      name: "Dr. Mourad Khettab",
      specialty: "Dentist",
      image: "assets/icons/doctor.png",
      lat: 36.7510,
      lng: 3.0400,
      patients: 1950,
      experience: 8,
      rating: 4.8,
      reviews: 132,
      workingDays: [1, 2, 3, 4, 6, 7],
      workingHours: ["08:30", "09:30", "10:30", "13:30"],
      offDates: [],
    ),
  ];

  List<Doctor> getDoctorsBySpecialty(String specialty) {
    return _doctors.where((d) => d.specialty == specialty).toList();
  }
  List<Doctor> get allDoctors => _doctors;
}
