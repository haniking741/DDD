import 'package:dawini/const/button.dart';
import 'package:dawini/const/colors.dart';
import 'package:dawini/services/translation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
Widget Or_login_with_email_color(context) {
  return Row(
    children: [
      Expanded(
        child: Divider(
          color: TColors.labeltext.withOpacity(0.8), // Adjust color as needed
          thickness: 1,
          endIndent: 10, // Space between text and line
        ),
      ),
      Text(
        'Or sign up with',
        
        style: Theme.of(context).textTheme.titleSmall!.copyWith(color: TColors.labeltext.withOpacity(0.8),),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      Expanded(
        child: Divider(
          color: TColors.labeltext.withOpacity(0.2),
          thickness: 1,
          indent: 10, // Space between text and line
        ),
      ),
    ],
  );
}

RichText Already_have_account({
  required BuildContext context,
  required String text,
  required String button_text,
  required VoidCallback onPressed,
}) {
  final localeProvider = Provider.of<LocaleProvider>(context);
  return RichText(
    text: TextSpan(children: <InlineSpan>[
      TextSpan(
        text: localeProvider.translate(text),
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: PrimaryTextButton(text: localeProvider.translate(button_text), onPressed: onPressed)
      ),
    ]),
  );
}
