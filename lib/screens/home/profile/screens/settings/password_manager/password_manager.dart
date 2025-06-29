import 'package:dawini/const/button.dart';
import 'package:dawini/const/colors.dart';
import 'package:dawini/const/textfield.dart';
import 'package:dawini/helpers/Validators.dart';
import 'package:dawini/services/translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PasswordManager extends StatefulWidget {
  const PasswordManager({super.key});

  @override
  State<PasswordManager> createState() => _PasswordManagerState();
}

class _PasswordManagerState extends State<PasswordManager> {
  final currentPasswordController = TextEditingController(text: "************");
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _newPasswordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: TColors.primarycolor3,
        appBar: AppBar(
          title: Text(
            localeProvider.translate("password_manager"),
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🔐 Current Password (disabled)
                Text(localeProvider.translate("current_password")),
                SizedBox(height: 8.h),
                CustomTextField(
                  controller: currentPasswordController,
                  hintText: "current_password",
                  isPassword: true,
                  keyboardType: TextInputType.visiblePassword,
                  validator:
                      (value) => MyValidators.passwordValidator(context, value),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _newPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed:
                        () => setState(
                          () => _newPasswordVisible = !_newPasswordVisible,
                        ),
                  ),
                ),

                /// Forgot Password link
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PrimaryTextButton(
                      text: localeProvider.translate("forgot_password"),
                      onPressed: () {
                        // TODO: Implement forgot password logic
                      },
                    ),
                  ],
                ),
                SizedBox(height: 24.h),

                /// 🔑 New Password
                Text(localeProvider.translate("new_password")),
                SizedBox(height: 8.h),
                CustomTextField(
                  controller: newPasswordController,
                  hintText: "new_password",
                  isPassword: true,
                  keyboardType: TextInputType.visiblePassword,
                  validator:
                      (value) => MyValidators.passwordValidator(context, value),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _newPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed:
                        () => setState(
                          () => _newPasswordVisible = !_newPasswordVisible,
                        ),
                  ),
                ),
                SizedBox(height: 24.h),

                /// 🔁 Confirm Password
                Text(localeProvider.translate("confirm_password")),
                SizedBox(height: 8.h),
                CustomTextField(
                  controller: confirmPasswordController,
                  hintText: "confirm_password",
                  isPassword: true,
                  keyboardType: TextInputType.visiblePassword,
                  validator:
                      (value) => MyValidators.repeatPasswordValidator(
                        context,
                        value: value,
                        password: newPasswordController.text,
                      ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _confirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed:
                        () => setState(
                          () =>
                              _confirmPasswordVisible =
                                  !_confirmPasswordVisible,
                        ),
                  ),
                ),
                SizedBox(height: 80.h), // add spacing for button visibility
              ],
            ),
          ),
        ),

        /// 👇 Fixed Button at Bottom
        bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
          child: PrimaryButton(
            text: localeProvider.translate("change_password"),
            onPressed: () {
              final isValid = _formKey.currentState!.validate();
              if (isValid) {
                print("password changed");
              }
            },
          ),
        ),
      ),
    );
  }
}
