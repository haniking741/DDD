import 'package:dawini/services/translation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyValidators {
  // Validate Display Name
  static String? displayNameValidator(BuildContext context, String? displayName) {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    if (displayName == null || displayName.isEmpty) {
      return localeProvider.translate('display_name_empty');
    }
    if (displayName.length < 3 || displayName.length > 20) {
      return localeProvider.translate('display_name_length');
    }

    return null; // Return null if display name is valid
  }
// Validate Price
static String? priceValidator(BuildContext context, String? value) {
  final localeProvider = Provider.of<LocaleProvider>(context, listen: false);

  if (value == null || value.isEmpty) {
    return localeProvider.translate('price_empty');
  }

  // تحقق إذا كان الرقم صالح
  final parsedPrice = double.tryParse(value.replaceAll(',', '.'));
  if (parsedPrice == null || parsedPrice <= 0) {
    return localeProvider.translate('price_invalid');
  }

  return null;
}

  // Validate Email
  static String? emailValidator(BuildContext context, String? value) {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);

    if (value!.isEmpty) {
      return localeProvider.translate('email_empty');
    }
    if (!RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b').hasMatch(value)) {
      return localeProvider.translate('email_invalid');
    }
    return null;
  }
// Validate Phone Number
static String? phoneValidator(BuildContext context, String? value) {
  final localeProvider = Provider.of<LocaleProvider>(context, listen: false);

  if (value == null || value.isEmpty) {
    return localeProvider.translate('phone_empty');
  }

  // Basic phone pattern: starts with + or digit, 9 to 15 digits total
  final phoneRegExp = RegExp(r'^(\+?\d{9,15})$');
  if (!phoneRegExp.hasMatch(value)) {
    return localeProvider.translate('phone_invalid');
  }

  return null;
}

  // Validate Password
  static String? passwordValidator(BuildContext context, String? value) {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);

    if (value!.isEmpty) {
      return localeProvider.translate('password_empty');
    }
    if (value.length < 6) {
      return localeProvider.translate('password_length');
    }
    return null;
  }

  // Validate Repeat Password
  static String? repeatPasswordValidator(BuildContext context, {String? value, String? password}) {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);

    if (value != password) {
      return localeProvider.translate('passwords_do_not_match');
    }
    return null;
  }

  // // Validate Product Upload Texts
  // static String? uploadProdTexts(BuildContext context, String? value, { String? toBeReturnedString}) {
  //   final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
  //   if (value!.isEmpty) {
  //     return localeProvider.translate(toBeReturnedString!);
  //   }
  //   return null;
  // }
}
