import 'package:dawini/const/button.dart';
import 'package:dawini/const/colors.dart';
import 'package:dawini/const/textfield.dart';
import 'package:dawini/helpers/Validators.dart';
import 'package:dawini/screens/authentication/forgotpassword/resetpassword.dart';
import 'package:dawini/services/translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ForgotPassEmail extends StatefulWidget {
  
  const ForgotPassEmail({super.key});

  @override
  State<ForgotPassEmail> createState() => _ForgotPassEmailState();
}

class _ForgotPassEmailState extends State<ForgotPassEmail> {
  late TextEditingController emailController;
  final _formKey = GlobalKey<FormState>();
  @override
   void initState() {
   super.initState();
    emailController = TextEditingController();
  }
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
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
                    child: CustomTextField(controller: emailController, hintText: localeProvider.translate('hint_email'), validator: (value) =>
                                    MyValidators.emailValidator(context, value),),
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
          begin: Offset(1.0, 0.0), // from right to left
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