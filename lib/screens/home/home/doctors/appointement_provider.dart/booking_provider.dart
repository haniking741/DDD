// import 'package:flutter/material.dart';

// class BookingProvider extends ChangeNotifier {
//   DateTime? selectedDate;
//   String? selectedTimeSlot;
//   bool isLoading = false;
//   bool isSuccess = false;
//   bool showTimeSlotError = false;

//   void setDate(DateTime date) {
//     selectedDate = date;
//     notifyListeners();
//   }

//   void setTimeSlot(String slot) {
//     selectedTimeSlot = slot;
//     showTimeSlotError = false;
//     notifyListeners();
//   }

//   void setLoading(bool value) {
//     isLoading = value;
//     notifyListeners();
//   }

//   void confirmBooking() {
//     if (selectedTimeSlot == null) {
//       showTimeSlotError = true;
//       notifyListeners();
//       return;
//     }

//     isLoading = true;
//     showTimeSlotError = false;
//     notifyListeners();

//     Future.delayed(const Duration(seconds: 2), () {
//       isLoading = false;
//       isSuccess = true;
//       notifyListeners();
//     });
//   }

//   void reset() {
//     selectedDate = null;
//     selectedTimeSlot = null;
//     isLoading = false;
//     isSuccess = false;
//     showTimeSlotError = false;
//     notifyListeners();
//   }
// }
