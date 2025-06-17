import 'package:dawini/const/button.dart';
import 'package:dawini/const/colors.dart';
import 'package:dawini/services/translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class Verification extends StatefulWidget {
  final String email; // استقبل الإيميل

  const Verification({super.key, required this.email});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: TColors.primarycolor3,
   appBar: AppBar(
  backgroundColor: TColors.primarycolor3,
  elevation: 0,
  leading: GestureDetector(
    onTap: () {
      Navigator.of(context).pop(); // يرجع للصفحة السابقة
    },
    child: Padding(
      padding: EdgeInsets.all(5.w),
      child: Container(
        width: 50.w,
        height: 50.h,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(100.r),
          border: Border.all(
            color: TColors.labeltext.withOpacity(0.3),
            width: 2.0,
          ),
        ),
        child: Icon(
          Icons.arrow_back,
          color: TColors.labeltext,
        ),
      ),
    ),
  ),
),


body: Padding(
  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 60.h),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      
                  Text(
                    textAlign: TextAlign.center,
                    localeProvider.translate('verification_title'),
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    textAlign: TextAlign.center,
          "${localeProvider.translate('verification_subtitle')} ${widget.email}",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: TColors.labeltext),
                  ),
                  SizedBox(height: 20.h),
                 Directionality(
  textDirection: TextDirection.ltr, // Force LTR
  child: Pinput(
    length: 4,
    defaultPinTheme: PinTheme(
      width: 70.w,
      height: 50.h,
      textStyle: Theme.of(context).textTheme.titleLarge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: TColors.labeltext),
      ),
    ),
    focusedPinTheme: PinTheme(
      width: 70.w,
      height: 50.h,
      textStyle: Theme.of(context).textTheme.titleLarge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: TColors.labeltext, width: 2),
      ),
    ),
    onCompleted: (pin) {
      print('Entered PIN: $pin');
    },
  ),
),

SizedBox(height: 20.h),
 Text(
                    textAlign: TextAlign.center,
          localeProvider.translate('recieve_otp'),
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: TColors.labeltext.withOpacity(0.7)),
                  ),
PrimaryTextButton(text: localeProvider.translate('resend_code'), onPressed: (){})
    ],
  ),
  ),
    );
  }
}