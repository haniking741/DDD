import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:dawini/const/button.dart';
import 'package:dawini/const/colors.dart';
import 'package:dawini/services/translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void showBookingAppointmentSheet(
  BuildContext context, {
  required String description,
  required String doctorName,
  required String doctorImagePath,
  required String specialization,
  required String location,
  required int patients,
  required int experience,
  required double rating,
  required int reviews,
  required List<int> workingDays,
  required List<String> workingHours,
  required List<String> offDates,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    backgroundColor: Colors.white,
    builder:
        (_) => BookingAppointmentSheet(
          doctorName: doctorName,
          doctorImagePath: doctorImagePath,
          specialization: specialization,
          location: location,
          patients: patients,
          experience: experience,
          rating: rating,
          reviews: reviews,
          workingDays: workingDays,
          workingHours: workingHours,
          offDates: offDates,
          description: description,
        ),
  );
}

class BookingAppointmentSheet extends StatefulWidget {
  final String doctorName;
  final String doctorImagePath;
  final String specialization;
  final String location;
  final String description;
  final int patients;
  final int experience;
  final double rating;
  final int reviews;
  final List<int> workingDays;
  final List<String> workingHours;
  final List<String> offDates;

  const BookingAppointmentSheet({
    super.key,
    required this.description,
    required this.doctorName,
    required this.doctorImagePath,
    required this.specialization,
    required this.location,
    required this.patients,
    required this.experience,
    required this.rating,
    required this.reviews,
    required this.workingDays,
    required this.workingHours,
    this.offDates = const [],
  });

  @override
  _BookingAppointmentSheetState createState() =>
      _BookingAppointmentSheetState();
}

class _BookingAppointmentSheetState extends State<BookingAppointmentSheet> {
  DateTime? _selectedDate;
  String? _selectedTimeSlot;

  late final List<String> _timeSlots;
  late final List<int> doctorWorkingWeekdays;
  late final List<DateTime> _availableDates;
  late final List<DateTime> _disabledDates;
  bool _showTimeSlotError = false;

  @override
  void initState() {
    super.initState();

    _timeSlots = widget.workingHours;
    doctorWorkingWeekdays = widget.workingDays;

    _disabledDates = widget.offDates.map((e) => DateTime.parse(e)).toList();
    _availableDates = generateAvailableDates(
      doctorWorkingWeekdays,
      _disabledDates,
    );
  }

  List<DateTime> generateAvailableDates(
    List<int> weekdays,
    List<DateTime> disabledDates,
  ) {
    final today = DateTime.now();
    final end = DateTime(today.year, today.month + 2, 0);

    List<DateTime> dates = [];

    for (DateTime d = today; !d.isAfter(end); d = d.add(Duration(days: 1))) {
      final isDisabled = disabledDates.any((off) => isSameDate(off, d));
      final isInWeek = weekdays.contains(d.weekday);
      final isFriday = d.weekday == DateTime.friday;

      if (isInWeek && !isFriday && !isDisabled) {
        dates.add(d);
      }
    }

    return dates;
  }

  bool isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleProvider>(context);

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
        top: 20.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 32.r,
                backgroundImage: AssetImage(widget.doctorImagePath),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.doctorName,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.specialization,
                      style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 14.sp,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            widget.location,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(Icons.verified, color: Colors.blue, size: 20.sp),
            ],
          ),
          SizedBox(height: 20.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStat(Icons.people, "${widget.patients}+", "Patients"),
              _buildStat(Icons.work, "${widget.experience}+", "Years Exp."),
              _buildStat(Icons.star, "${widget.rating}", "Rating"),
              _buildStat(Icons.chat, "${widget.reviews}", "Review"),
            ],
          ),
          SizedBox(height: 20.h),

          Center(
            child: Column(
              children: [
                Text(
                  locale.translate("make_appointement"),
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: TColors.labeltext,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Text(
                        locale.translate("About"),
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: TColors.primarycolor,
                        ),
                      ),
                      Text(
                        widget.description,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: TColors.labeltext,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),

          PrimaryButton(
            text:
                _selectedDate == null
                    ? locale.translate("choose_date")
                    : BoardDateFormat('yyyy/MM/dd').format(_selectedDate!),
            onPressed: () async {
              final firstAvailableDate = _availableDates.first;

              final res = await showDatePicker(
                context: context,
                initialDate: firstAvailableDate,
                firstDate: firstAvailableDate,
                lastDate: firstAvailableDate.add(Duration(days: 60)),
                selectableDayPredicate: (day) {
                  return _availableDates.any((d) => isSameDate(d, day));
                },
              );

              if (res != null) {
                setState(() => _selectedDate = res);
              }
            },
          ),

          if (_selectedDate != null) ...[
            SizedBox(height: 20.h),
            Directionality(
              textDirection:
                  locale.locale.languageCode == 'ar'
                      ? TextDirection.rtl
                      : TextDirection.ltr,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    locale.translate("available_times"),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Wrap(
                    spacing: 10.w,
                    runSpacing: 10.h,
                    children:
                        _timeSlots.map((slot) {
                          bool isSelected = slot == _selectedTimeSlot;
                          return ChoiceChip(
                            label: Text(slot),
                            selected: isSelected,
                            onSelected:
                                (_) => setState(() => _selectedTimeSlot = slot),
                            selectedColor: TColors.primarycolor.withOpacity(
                              0.4,
                            ),
                            backgroundColor: Colors.grey.shade200,
                            labelStyle: TextStyle(
                              color:
                                  isSelected
                                      ? TColors.primarycolor
                                      : Colors.black,
                            ),
                          );
                        }).toList(),
                  ),
                  SizedBox(height: 10.h),
                  if (_showTimeSlotError)
                    Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: Text(
                        locale.translate("please_select_time"),
                        style: TextStyle(color: Colors.red, fontSize: 13.sp),
                      ),
                    ),
                  SizedBox(height: 15.h),
                  if (_selectedTimeSlot != null)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: Text(
                        "${locale.translate("you_selected")}: ${BoardDateFormat('yyyy/MM/dd').format(_selectedDate!)} - $_selectedTimeSlot",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                  PrimaryButton(
                    text: locale.translate("confirm"),
                    onPressed: () {
                      if (_selectedTimeSlot == null) {
                        setState(() {
                          _showTimeSlotError = true;
                        });
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStat(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, size: 24.sp, color: Colors.blue),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
        ),
        Text(label, style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
      ],
    );
  }
}
