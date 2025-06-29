import 'package:dawini/const/button.dart';
import 'package:dawini/const/colors.dart';
import 'package:dawini/const/textfield.dart';
import 'package:dawini/services/translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final TextEditingController nameController = TextEditingController(
    text: 'Esther Howard',
  );
  final TextEditingController phoneController = TextEditingController(
    text: '603.555.0123',
  );
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: TColors.primarycolor3,
        appBar: AppBar(
          title: Text(
            locale.translate("profile"),
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: TColors.labeltext,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
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
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50.r,
                      backgroundImage: AssetImage("assets/icons/doctor.png"),
                    ),
                    Container(
                      width: 28.w,
                      height: 28.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: TColors.primarycolor,
                      ),
                      child: Icon(Icons.edit, size: 16.sp, color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),

              Center(
                child: Text(
                  "Esther Howard",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 30.h),

              Text(locale.translate("name"), style: TextStyle(fontSize: 14.sp)),
              SizedBox(height: 6.h),
              CustomTextField(controller: nameController, hintText: "name"),
              SizedBox(height: 16.h),

              Text(
                locale.translate("phone"),
                style: TextStyle(fontSize: 14.sp),
              ),
              SizedBox(height: 6.h),
              CustomTextField(
                controller: phoneController,
                hintText: "phone",
                keyboardType: TextInputType.phone,
                // Add "Change" button inside the field
                suffixIcon: TextButton(
                  onPressed: () {
                    // Action to change phone number
                  },
                  child: Text(
                    locale.translate("change"),
                    style: TextStyle(color: TColors.primarycolor),
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              Text(
                locale.translate("email"),
                style: TextStyle(fontSize: 14.sp),
              ),
              SizedBox(height: 6.h),
              CustomTextField(
                controller: emailController,
                hintText: "example@gmail.com",
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.h),

              Text(locale.translate("dob"), style: TextStyle(fontSize: 14.sp)),
              SizedBox(height: 6.h),
              GestureDetector(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );

                  if (pickedDate != null) {
                    String formattedDate =
                        "${pickedDate.day.toString().padLeft(2, '0')}/"
                        "${pickedDate.month.toString().padLeft(2, '0')}/"
                        "${pickedDate.year}";
                    setState(() {
                      dobController.text = formattedDate;
                    });
                  }
                },
                child: AbsorbPointer(
                  // prevents the field from opening keyboard
                  child: CustomTextField(
                    controller: dobController,
                    hintText: "dob",
                    keyboardType: TextInputType.none,
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              Text(
                locale.translate("gender"),
                style: TextStyle(fontSize: 14.sp),
              ),
              SizedBox(height: 6.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: TColors.labeltext.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  underline: SizedBox(),
                  hint: Text(locale.translate("select")),
                  value: selectedGender,
                  items:
                      ["ذكر", "أنثى", "آخر"]
                          .map(
                            (gender) => DropdownMenuItem(
                              value: gender,
                              child: Text(gender),
                            ),
                          )
                          .toList(),
                  onChanged: (value) => setState(() => selectedGender = value),
                ),
              ),

              SizedBox(height: 32.h),
              PrimaryButton(
                text: locale.translate("update_profile"),
                onPressed: () {
                  // Handle update profile
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
