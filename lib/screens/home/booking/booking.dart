import 'package:dawini/const/colors.dart';
import 'package:dawini/screens/home/booking/booking_provider/booking_provider.dart';
import 'package:dawini/screens/home/booking/booking_widgets/appointementcard.dart';
import 'package:dawini/services/translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appointmentProvider = Provider.of<AppointmentProvider>(context);
    final appointments = appointmentProvider.appointments;
    final localeProvider = Provider.of<LocaleProvider>(context);
    return SafeArea(
  child: Scaffold(
    backgroundColor: TColors.primarycolor3,
    body: Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          /// ✅ العنوان مع أيقونة البحث
          SizedBox(
            height: 44.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                /// العنوان في الوسط
                Center(
                  child: Text(
                    localeProvider.translate("my_appointments"), // أو استخدم `localeProvider.translate("appointments")`
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      color: TColors.labeltext,
                    ),
                  ),
                ),
                
                /// أيقونة البحث في اليمين
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 44.h,
                    width: 44.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      border: Border.all(
                        color: TColors.labeltext.withOpacity(0.3),
                        width: 2.0,
                      ),
                    ),
                    child: Icon(Icons.search_outlined, color: TColors.labeltext),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 10.h),

          /// قائمة المواعيد
          Expanded(
            child: ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final appt = appointments[index];
                return AppointmentCard(
                  type: appt.type,
                  dateTime: appt.dateTime,
                  doctorName: appt.doctorName,
                  location: appt.location,
                  bookingId: appt.bookingId,
                  imageUrl: appt.imageUrl,
                  remind: appt.remind,
                  onCancel: () => appointmentProvider.cancelAppointment(appt.id),
                  onReschedule: () => appointmentProvider.rescheduleAppointment(appt.id),
                  onReminderChanged: (_) => appointmentProvider.toggleReminder(appt.id),
                );
              },
            ),
          ),
        ],
      ),
    ),
  ),
);

  }
}
