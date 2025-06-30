import 'package:dawini/screens/home/booking/booking_model/booking_model.dart';
import 'package:flutter/material.dart';

class AppointmentProviderB with ChangeNotifier {
  final List<AppointmentBooking> _appointments = [
    AppointmentBooking(
      id: '1',
      doctorName: 'Jenny William',
      location: 'G8502 Preston Rd. Inglewood',
      bookingId: 'DR452SA54',
      imageUrl: 'assets/icons/doctor.png',
      dateTime: 'Aug 25, 2023 - 10:00 AM',
      remind: true,
      type: 'visit'
    ),
    AppointmentBooking(
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

  List<AppointmentBooking> get appointments => _appointments;

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
