import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../services/translation.dart' show LocaleProvider;

Future<bool?> showCancelConfirmationDialog(BuildContext context) {
  final localeProvider = Provider.of<LocaleProvider>(context, listen: false);

  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text(
          localeProvider.translate("confirm_cancel_title"),
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
        content: Text(
          localeProvider.translate("confirm_cancel_message"),
          style: TextStyle(fontSize: 14.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(localeProvider.translate("no")),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(localeProvider.translate("yes_cancel")),
          ),
        ],
      );
    },
  );
}
Future<void> showLogoutConfirmationDialog(BuildContext context, VoidCallback onConfirm) async {
  final localeProvider = Provider.of<LocaleProvider>(context, listen: false);

  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(localeProvider.translate("logout_confirmation")),
      content: Text(localeProvider.translate("are_you_sure_logout")),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(), // Close dialog
          child: Text(localeProvider.translate("cancel")),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close dialog
            onConfirm(); // Execute the logout
          },
          child: Text(
            localeProvider.translate("confirm"),
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ],
    ),
  );
}
