import 'package:dawini/const/button.dart';
import 'package:dawini/const/colors.dart';
import 'package:dawini/const/textfield.dart' show CustomTextField;
import 'package:dawini/helpers/Validators.dart';
import 'package:dawini/services/translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ResetNewPass extends StatefulWidget {
  const ResetNewPass({super.key});

  @override
  State<ResetNewPass> createState() => _ResetNewPassState();
}

class _ResetNewPassState extends State<ResetNewPass> {
  late TextEditingController PasswordController;
  late TextEditingController ConfirmPasswordController;
  final _formKey = GlobalKey<FormState>();
  @override
   void initState() {
   super.initState();
    PasswordController = TextEditingController();
    ConfirmPasswordController = TextEditingController();
  }
  @override
  void dispose() {
    PasswordController.dispose();
    ConfirmPasswordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    localeProvider.translate('enter_email'),
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    textAlign: TextAlign.center,
          localeProvider.translate('enter_email_subtitle'),
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: TColors.labeltext),
                  ),
                  SizedBox(height: 20.h),
                  Form(
                    key: _formKey,
                    child: 
                    Column(
                      spacing: 10,
                      children: [
                        CustomTextField(controller: PasswordController, hintText: localeProvider.translate('hint_password'), validator: (value) =>
                                        MyValidators.passwordValidator(context, value),),
                                        CustomTextField(controller: ConfirmPasswordController, hintText: localeProvider.translate('hint_confirm_password'), validator: (value) =>
                                        MyValidators.repeatPasswordValidator(context,password: value),),

                      ],
                    ),
                  ),
                SizedBox(height: 20.h),
                PrimaryButton(text: localeProvider.translate('confirm'), onPressed: (){
                   final isValid = _formKey.currentState!.validate();
                   if(isValid){
 Navigator.of(context).push(
  PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 400),
    pageBuilder: (_, animation, __) => ResetNewPass(),
    transitionsBuilder: (_, animation, __, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: Offset(1.0, 0.0), // Slide from right to left
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    },
  ),
);

                   }
                 
                })

    ],
  ),
  ),
    );
  }
}