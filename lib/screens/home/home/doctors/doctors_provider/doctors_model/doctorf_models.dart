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
  final List<String> offDates; // Use List<DateTime> if needed
  final String description;

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
    required this.description,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      name: json['name'],
      specialty: json['specialty'],
      image: json['image'],
      lat:
          json['lat'] is String
              ? double.parse(json['lat'])
              : json['lat'].toDouble(),
      lng:
          json['lng'] is String
              ? double.parse(json['lng'])
              : json['lng'].toDouble(),
      patients: json['patients'],
      experience: json['experience'],
      rating: json['rating'].toDouble(),
      reviews: json['reviews'],
      workingDays: List<int>.from(json['workingDays']),
      workingHours: List<String>.from(json['workingHours']),
      offDates: List<String>.from(json['offDates']),
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
