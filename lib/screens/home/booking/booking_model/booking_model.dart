class AppointmentBooking {
  final String id;
  final String doctorName;
  final String location;
  final String bookingId;
  final String imageUrl;
  final String dateTime;
  bool remind;
  final String type;

  AppointmentBooking({
    required this.type,
    required this.id,
    required this.doctorName,
    required this.location,
    required this.bookingId,
    required this.imageUrl,
    required this.dateTime,
    this.remind = false,
  });
}
