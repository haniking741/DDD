import 'package:dawini/const/button.dart';
import 'package:dawini/const/colors.dart';
import 'package:dawini/const/others.dart';
import 'package:dawini/const/textfield.dart';
import 'package:dawini/helpers/Validators.dart';
import 'package:dawini/screens/authentication/auth_provider/auth_provider.dart';
import 'package:dawini/screens/authentication/login/loginscreen.dart';
import 'package:dawini/screens/authentication/verificationpage.dart';
import 'package:dawini/services/translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isChecked = false; // Add this in your state class if it's not already
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late FocusNode nameFocusNode;
  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();

    // Initialize FocusNodes
    nameFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
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

  Future<bool> emailExists(String email) async {
    final response =
        await Supabase.instance.client
            .from('clients')
            .select('email')
            .eq('email', email)
            .maybeSingle();

    return response != null;
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
                    localeProvider.translate('welcome_title'),
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    textAlign: TextAlign.center,
                    localeProvider.translate('welcome_subtitle'),
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
                        // Username Label
                        Text(
                          localeProvider.translate('label_username'),
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        const SizedBox(height: 6),
                        CustomTextField(
                          controller: nameController,
                          hintText: "hint_username",
                          focusNode: nameFocusNode,
                          validator:
                              (value) => MyValidators.displayNameValidator(
                                context,
                                value,
                              ),
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(emailFocusNode);
                          },
                        ),
                        const SizedBox(height: 16),

                        // Email Label
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
                        const SizedBox(height: 16),

                        // Password Label
                        Text(
                          localeProvider.translate('label_password'),
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        const SizedBox(height: 6),
                        CustomTextField(
                          controller: passwordController,
                          isPassword: true,
                          hintText: "hint_password",
                          focusNode: passwordFocusNode,
                          onFieldSubmitted: (value) {
                            FocusScope.of(
                              context,
                            ).requestFocus(passwordFocusNode);
                          },
                          validator:
                              (value) => MyValidators.passwordValidator(
                                context,
                                value,
                              ),
                        ),
                        const SizedBox(height: 10),

                        // Terms & Conditions with Checkbox
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor: TColors.primarycolor,
                                checkboxTheme: CheckboxThemeData(
                                  fillColor: WidgetStateProperty.resolveWith<
                                    Color
                                  >((states) {
                                    if (states.contains(WidgetState.selected)) {
                                      return TColors.primarycolor;
                                    }
                                    return Colors.transparent;
                                  }),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  visualDensity: VisualDensity.compact,
                                ),
                              ),
                              child: Transform.scale(
                                scale: 1.4,
                                child: Checkbox(
                                  value: isChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      isChecked = value ?? false;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Expanded(
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Text(
                                    localeProvider.translate('hint_terms'),
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                  SizedBox(width: 6.w),
                                  PrimaryTextButton(
                                    onPressed: () {
                                      // Navigate to terms screen
                                    },
                                    text: localeProvider.translate('terms'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  PrimaryButton(
                    text: localeProvider.translate('signup_button'),
                    onPressed:
                        _isLoading
                            ? null
                            : () async {
                              final isValid = _formKey.currentState!.validate();
                              final email = emailController.text.trim();
                              final password = passwordController.text.trim();
                              final username = nameController.text.trim();

                              if (!isChecked) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      localeProvider.translate(
                                        'error_accept_terms',
                                      ),
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }

                              if (!isValid) return;

                              // ✅ Check if email already exists
                              if (await emailExists(email)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Email already registered. Try logging in.',
                                    ),
                                    backgroundColor: Colors.orange,
                                  ),
                                );
                                return;
                              }

                              setState(() => _isLoading = true);

                              try {
                                final response = await Supabase
                                    .instance
                                    .client
                                    .auth
                                    .signUp(
                                      email: email,
                                      password: password,
                                      data: {'username': username},
                                      emailRedirectTo:
                                          'https://your-app-url.com/verify',
                                    );

                                if (response.user != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              Verification(email: email),
                                    ),
                                  );
                                }
                              } catch (e) {
                                debugPrint('❌ Sign up error: $e');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Signup failed: ${e.toString()}',
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              } finally {
                                setState(() => _isLoading = false);
                              }
                            },
                    isLoading: _isLoading,
                  ),

                  SizedBox(height: 20.h),
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
                      const SizedBox(width: 16),

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
                    text: localeProvider.translate('already_account'),
                    button_text: localeProvider.translate('Login_button'),
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 500),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  LoginScreen(),
                          transitionsBuilder: (
                            context,
                            animation,
                            secondaryAnimation,
                            child,
                          ) {
                            return SlideTransition(
                              position: Tween<Offset>(
                                begin: Offset(1.0, 0.0), // From right to left
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
