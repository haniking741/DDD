import 'package:dawini/screens/home/booking/booking_model/booking_model.dart';
import 'package:flutter/material.dart';

class AppointmentProvider with ChangeNotifier {
  final List<Appointment> _appointments = [
    Appointment(
      id: '1',
      doctorName: 'Jenny William',
      location: 'G8502 Preston Rd. Inglewood',
      bookingId: 'DR452SA54',
      imageUrl: 'assets/icons/doctor.png',
      dateTime: 'Aug 25, 2023 - 10:00 AM',
      remind: true,
      type: 'visit'
    ),
    Appointment(
      id: '2',
      doctorName: 'Guy Hawkins',
      location: 'G8502 Preston Rd. Inglewood',
      bookingId: 'DR452SA54',
      imageUrl: 'assets/icons/doctor.png',
      dateTime: 'Aug 25, 2023 - 10:00 AM',
      remind: true,
       type: 'control',
    ),
  ];

  List<Appointment> get appointments => _appointments;

  void toggleReminder(String id) {
    final index = _appointments.indexWhere((element) => element.id == id);
    _appointments[index].remind = !_appointments[index].remind;
    notifyListeners();
  }

  void cancelAppointment(String id) {
    _appointments.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void rescheduleAppointment(String id) {
    // Implement your logic here
    notifyListeners();
  }
}
