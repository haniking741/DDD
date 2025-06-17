class Doctor {
  final String name;
  final String specialty;
  final String image;
  final double lat;
  final double lng;
  final int patients;
  final int experience;
  final double rating;
  final int reviews;
  final List<int> workingDays;
  final List<String> workingHours;
  final List<String> offDates;

  Doctor({
    required this.name,
    required this.specialty,
    required this.image,
    required this.lat,
    required this.lng,
    required this.patients,
    required this.experience,
    required this.rating,
    required this.reviews,
    required this.workingDays,
    required this.workingHours,
    required this.offDates,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      name: json['name'],
      specialty: json['specialty'],
      image: json['image'],
      lat: double.parse(json['lat']),
      lng: double.parse(json['lng']),
      patients: json['patients'],
      experience: json['experience'],
      rating: json['rating'],
      reviews: json['reviews'],
      workingDays: List<int>.from(json['workingDays']),
      workingHours: List<String>.from(json['workingHours']),
      offDates: List<String>.from(json['offDates']),
    );
  }
}
