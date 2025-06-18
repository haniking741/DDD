import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../const/colors.dart'; // Update path if needed

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading; // NEW

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false, // default false
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: TColors.primarycolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
        onPressed: isLoading ? null : onPressed, // disable when loading
        child: isLoading
            ? SizedBox(
                height: 24.h,
                width: 24.w,
                child: CircularProgressIndicator(
                  color: TColors.primarycolor3,
                  strokeWidth: 2.5,
                ),
              )
            : Text(
                text,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: TColors.primarycolor3,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
              ),
      ),
    );
  }
}

class PrimaryTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const PrimaryTextButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: TColors.primarycolor, // text color
        padding: EdgeInsets.zero, // optional: removes default padding
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: TColors.primarycolor,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}
