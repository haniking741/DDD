import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:dawini/const/colors.dart';
import 'package:dawini/screens/home/home/doctors/book_appointement.dart';
import 'package:dawini/screens/home/home/doctors/doctors_provider/doctors_provider.dart';
import 'package:dawini/services/translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorsFetch extends StatefulWidget {
  final String category;

  const DoctorsFetch({super.key, required this.category});

  @override
  State<DoctorsFetch> createState() => _DoctorsFetchState();
}

class _DoctorsFetchState extends State<DoctorsFetch> {
  void openGoogleMaps({
    required BuildContext context,
    required double lat,
    required double lng,
  }) async {
    final String query = '$lat,$lng';

    final intent = AndroidIntent(
      action: 'action_view',
      data: 'geo:$query?q=$query',
      flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
    );

    try {
      await intent.launch();
    } catch (e) {
      final fallbackUrl = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=$query",
      );
      if (await canLaunchUrl(fallbackUrl)) {
        await launchUrl(fallbackUrl, mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Impossible d’ouvrir Google Maps.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final doctors = context.watch<DoctorProvider>().getDoctorsBySpecialty(
      widget.category,
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: TColors.primarycolor3,
        appBar: AppBar(
          title: Text(
            widget
                .category, // أو استخدم `localeProvider.translate("appointments")`
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
              color: TColors.labeltext,
            ),
          ),
          centerTitle: true,
          backgroundColor: TColors.primarycolor3,
          elevation: 0,
          leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Padding(
              padding: EdgeInsets.all(5.w),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.r),
                  border: Border.all(
                    color: TColors.labeltext.withOpacity(0.3),
                    width: 2.0,
                  ),
                ),
                child: Icon(Icons.arrow_back, color: TColors.labeltext),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.all(5.w),
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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child:
              doctors.isEmpty
                  ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          localeProvider.translate("no_item"),
                          style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                        ),
                        Image.asset(
                          "assets/images/empty.gif",
                          width: double.infinity,
                          height: 200.w,
                        ),
                      ],
                    ),
                  )
                  : ListView.builder(
                    itemCount: doctors.length,
                    itemBuilder: (context, index) {
                      final doctor = doctors[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: _buildDoctorCard(
                          context,
                          doctor.name,
                          doctor.specialty,
                          doctor.image,
                          doctor.lat,
                          doctor.lng,
                          doctor.patients,
                          doctor.experience,
                          doctor.rating,
                          doctor.reviews,
                          doctor.workingDays,
                          doctor.workingHours,
                          doctor.offDates,
                          doctor.description,
                        ),
                      );
                    },
                  ),
        ),
      ),
    );
  }

  Widget _buildDoctorCard(
    BuildContext context,
    String name,
    String specialty,
    String imagePath,
    double lat,
    double lng,
    int patients,
    int experience,
    double rating,
    int reviews,
    List<int> workingDays,
    List<String> workingHours,
    List<String> offdates,
    String description,
  ) {
    final localeProvider = Provider.of<LocaleProvider>(context);

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundImage: AssetImage(imagePath),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.verified, color: Colors.blue, size: 16.r),
                        SizedBox(width: 4.w),
                        Text(
                          "Professional Doctor",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                    Text(
                      specialty,
                      style: TextStyle(fontSize: 13.sp, color: Colors.grey),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16.r),
                        Text(" $rating "),
                        Text(
                          "($reviews Reviews)",
                          style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                showBookingAppointmentSheet(
                  context,
                  doctorName: name,
                  doctorImagePath: imagePath,
                  specialization: specialty,
                  location: "Tebessa, Algeria",
                  patients: patients,
                  experience: experience,
                  rating: rating,
                  reviews: reviews,
                  workingDays: workingDays,
                  workingHours: workingHours,
                  offDates: offdates,
                  description: description,
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFFEEF4FF),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text(
                localeProvider.translate("make_appointement"),
                style: TextStyle(color: Colors.blue, fontSize: 14.sp),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          GestureDetector(
            onTap: () {
              openGoogleMaps(context: context, lat: lat, lng: lng);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_on, color: Colors.blue, size: 18.r),
                  SizedBox(width: 4.w),
                  Text(
                    "Open in Maps",
                    style: TextStyle(color: Colors.blue, fontSize: 12.sp),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
