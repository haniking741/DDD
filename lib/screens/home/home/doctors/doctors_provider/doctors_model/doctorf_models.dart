class Doctor {
  final String id;
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
  final String description;

  Doctor({
    required this.id,
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
    required this.description,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
  return Doctor(
    id: json['id'] ?? '',
    name: json['name'] ?? '',
    specialty: json['speciality'] ?? '',
    image: json['image'] ?? '',
    lat: json['lat'] is String ? double.tryParse(json['lat']) ?? 0.0 : (json['lat'] ?? 0.0).toDouble(),
    lng: json['lng'] is String ? double.tryParse(json['lng']) ?? 0.0 : (json['lng'] ?? 0.0).toDouble(),
    patients: int.tryParse(json['patients'].toString()) ?? 0,
    experience: int.tryParse(json['experience'].toString()) ?? 0,
    rating: double.tryParse(json['rating'].toString()) ?? 0.0,
    reviews: int.tryParse(json['reviews'].toString()) ?? 0,
    workingDays: (json['workingDays'] as List).map((e) => int.tryParse(e.toString()) ?? 0).toList(),
    workingHours: (json['workingHours'] as List).map((e) => e.toString()).toList(),
    offDates: (json['offDates'] as List).map((e) => e.toString()).toList(),
    description: json['description'] ?? '',
  );
}



  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialty': specialty,
      'image': image,
      'lat': lat,
      'lng': lng,
      'patients': patients,
      'experience': experience,
      'rating': rating,
      'reviews': reviews,
      'workingDays': workingDays,
      'workingHours': workingHours,
      'offDates': offDates,
      'description': description,
    };
  }
}
