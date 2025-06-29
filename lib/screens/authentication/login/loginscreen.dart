import 'package:dawini/const/button.dart';
import 'package:dawini/const/colors.dart';
import 'package:dawini/const/others.dart';
import 'package:dawini/const/textfield.dart';
import 'package:dawini/helpers/Validators.dart';
import 'package:dawini/providers/navigationbar_provider.dart';
import 'package:dawini/screens/authentication/auth_provider/auth_provider.dart';
import 'package:dawini/screens/authentication/forgotpassword/forgotpassword.dart';
import 'package:dawini/screens/authentication/signup/signupscreen.dart';
import 'package:dawini/services/translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

DateTime? lastPressed;
Future<bool> _onWillPop(BuildContext context) async {
  final now = DateTime.now();
  if (lastPressed == null ||
      now.difference(lastPressed!) > const Duration(seconds: 2)) {
    lastPressed = now;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Press again to exit'),
        backgroundColor: Colors.black54,
        duration: Duration(seconds: 2),
      ),
    );
    return false; // Prevent exit
  }
  return true; // Allow exit
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late FocusNode emailFocusNode;
  bool _isLoading = false;
  late FocusNode passwordFocusNode;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    // Initialize FocusNodes
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: TColors.primarycolor3,
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 55.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    localeProvider.translate('welcome_title2'),
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    textAlign: TextAlign.center,
                    localeProvider.translate('welcome_subtitle2'),
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge!.copyWith(color: TColors.labeltext),
                  ),
                  SizedBox(height: 20.h),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localeProvider.translate('label_email'),
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        const SizedBox(height: 6),
                        CustomTextField(
                          controller: emailController,
                          hintText: "hint_email",
                          focusNode: emailFocusNode,
                          validator:
                              (value) =>
                                  MyValidators.emailValidator(context, value),
                          onFieldSubmitted: (value) {
                            FocusScope.of(
                              context,
                            ).requestFocus(passwordFocusNode);
                          },
                        ),
                        SizedBox(height: 16.h),

                        // Email Label
                        Text(
                          localeProvider.translate('label_password'),
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        SizedBox(height: 6.h),
                        CustomTextField(
                          isPassword: true,
                          controller: passwordController,
                          hintText: "hint_password",
                          focusNode: passwordFocusNode,
                          validator:
                              (value) => MyValidators.passwordValidator(
                                context,
                                value,
                              ),
                        ),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      PrimaryTextButton(
                        text: localeProvider.translate('forgot_pass'),
                        onPressed: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 500),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      ForgotPassEmail(),
                              transitionsBuilder: (
                                context,
                                animation,
                                secondaryAnimation,
                                child,
                              ) {
                                return SlideTransition(
                                  position: Tween<Offset>(
                                    begin: Offset(1.0, 0.0), // Slide from right
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  PrimaryButton(
                    isLoading: _isLoading,
                    text: localeProvider.translate('Login_button'),
                    onPressed: () async {
  final isValid = _formKey.currentState!.validate();
  if (!isValid) return;

  setState(() => _isLoading = true);

  final authProvider = Provider.of<AuthProvider>(context, listen: false);
  final errorKey = await authProvider.signInWithEmail(
    email: emailController.text.trim(),
    password: passwordController.text.trim(),
  );

  setState(() => _isLoading = false);

  if (errorKey == null) {
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, animation, __) => const RootScreen(),
        transitionsBuilder: (_, animation, __, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
      (route) => false,
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(localeProvider.translate(errorKey)),
        backgroundColor: Colors.red,
      ),
    );
  }
}

                  ),

                  SizedBox(height: 30.h),
                  Or_login_with_email_color(context),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Google Container
                      Container(
                        padding: EdgeInsets.all(15.w),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: TColors.labeltext.withOpacity(0.3),
                          ),
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                        child: Image.asset(
                          'assets/icons/google.png', // replace with your path
                          width: 24.w,
                          height: 24.h,
                        ),
                      ),
                      SizedBox(width: 16.w),

                      // Facebook Container
                      Container(
                        padding: EdgeInsets.all(15.w),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: TColors.labeltext.withOpacity(0.3),
                          ),
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                        child: Image.asset(
                          'assets/icons/facebook.png', // replace with your path
                          width: 24.w,
                          height: 24.h,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Already_have_account(
                    context: context,
                    text: localeProvider.translate('already'),
                    button_text: localeProvider.translate('signup_button'),
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 400),
                          pageBuilder: (_, animation, __) => SignupScreen(),
                          transitionsBuilder: (_, animation, __, child) {
                            return SlideTransition(
                              position: Tween<Offset>(
                                begin: Offset(
                                  1.0,
                                  0.0,
                                ), // Slide in from the right
                                end: Offset.zero,
                              ).animate(animation),
                              child: child,
                            );
                          },
                        ),
                        (Route<dynamic> route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
