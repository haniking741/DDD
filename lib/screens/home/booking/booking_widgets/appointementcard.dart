import 'package:dawini/const/colors.dart';
import 'package:dawini/helpers/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import '../../../../services/translation.dart' show LocaleProvider;

class AppointmentCard extends StatelessWidget {
  final String dateTime;
  final String doctorName;
  final String location;
  final String type;
  final String bookingId;
  final String imageUrl;
  final bool remind;
  final VoidCallback onCancel;
  final VoidCallback onReschedule;
  final ValueChanged<bool> onReminderChanged;

  const AppointmentCard({
    super.key,
    required this.dateTime,
    required this.type,
    required this.doctorName,
    required this.location,
    required this.bookingId,
    required this.imageUrl,
    required this.remind,
    required this.onCancel,
    required this.onReschedule,
    required this.onReminderChanged,
  });

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);


    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 5,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(
  children: [
    Expanded(
      child: Text(
        dateTime,
        style: TextStyle(fontSize: 13.sp),
        overflow: TextOverflow.ellipsis,
      ),
    ),
    SizedBox(width: 10.w),
    Row(
      spacing: 20,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(localeProvider.translate("remind_me"), style: TextStyle(fontSize: 11.sp,color: TColors.labeltext.withOpacity(0.6))),
        
       FlutterSwitch(
  width: 40.0,
  height: 20.0,
  toggleSize: 16.0,
  value: remind,
  borderRadius: 20.0,
  padding: 4.0,
  activeColor: TColors.primarycolor,
  onToggle: onReminderChanged,
)

      ],
    ),
  ],
),

          SizedBox(height: 10.h),

          /// Doctor Row
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.asset(
                  imageUrl,
                  height: 60.h,
                  width: 60.w,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(doctorName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            color: Colors.black)),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 14, color: TColors.primarycolor),
                        SizedBox(width: 4),
                        Flexible(
                          child: Text(location,
                              style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.book_online, size: 14, color: TColors.primarycolor),
                        SizedBox(width: 4),
                        Text(localeProvider.translate("booking_id"), style: TextStyle(fontSize: 12.sp)),
                        Text("#$bookingId",
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: TColors.primarycolor,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.book_online, size: 14, color: TColors.primarycolor),
                        SizedBox(width: 4),
                        Text(localeProvider.translate("appointment_type"), style: TextStyle(fontSize: 12.sp)),
                        Text(type,
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: TColors.primarycolor,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),

          SizedBox(height: 15.h),

          /// Action Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
  final confirmed = await showCancelConfirmationDialog(context);
  if (confirmed == true) {
    onCancel();
  }
},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade50,
                    foregroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(localeProvider.translate("cancel"),), // ترجمة "Cancel"
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: onReschedule,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColors.primarycolor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(localeProvider.translate("review"),), // ترجمة "Reschedule"
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
