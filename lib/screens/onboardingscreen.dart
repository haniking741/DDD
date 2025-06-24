import 'package:dawini/const/button.dart';
import 'package:dawini/const/colors.dart';
import 'package:dawini/providers/onboarding_provider.dart';
import 'package:dawini/screens/authentication/login/loginscreen.dart';
import 'package:dawini/screens/authentication/signup/signupscreen.dart';
import 'package:dawini/services/translation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class TopWavyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    
    // Start from top-left and go down
    path.lineTo(0, size.height - 30);

    // First curve: left wave
    path.quadraticBezierTo(
      size.width * 0.25, size.height,
      size.width * 0.5, size.height - 30,
    );

    // Second curve: right wave
    path.quadraticBezierTo(
      size.width * 0.75, size.height - 60,
      size.width, size.height - 30,
    );

    // Complete the rectangle by going up to top-right
    path.lineTo(size.width, 0);
    path.close();

    return path;
  } 

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}


// ignore: must_be_immutable
class Onboarding extends StatelessWidget {
  final PageController controller = PageController(initialPage: 0);
  DateTime? lastPressed;

  Onboarding({super.key});

  Future<bool> _onWillPop(BuildContext context) async {
    final now = DateTime.now();
    if (lastPressed == null || now.difference(lastPressed!) > const Duration(seconds: 2)) {
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
  void _showSkipConfirmation(BuildContext context) {
  final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    backgroundColor: Colors.white,
    builder: (_) {
      return Padding(
        padding:  EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              textAlign: TextAlign.center,
        localeProvider.translate('modal_title'),
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w500,),
            ),
            const SizedBox(height: 20),
           Text(
             textAlign: TextAlign.center,
        localeProvider.translate('modal_subtitle'),
              style: Theme.of(context).textTheme.titleSmall!.copyWith(color: TColors.labeltext),
            ),
            const SizedBox(height: 20),
           PrimaryButton(
  text: localeProvider.translate('get_started'),
  onPressed: () {
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 400),
        pageBuilder: (context, animation, secondaryAnimation) => SignupScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: Offset(1.0, 0.0), // Slide from right
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

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                Text(
             textAlign: TextAlign.center,
        localeProvider.translate('already'),
              style: Theme.of(context).textTheme.titleSmall
            ),
           PrimaryTextButton(
  text: localeProvider.translate('Login_button'),
  onPressed: () {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 1000),
        pageBuilder: (context, animation, secondaryAnimation) => LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
  },
),

              ],
            )
          ],
        ),
      );
    },
  );
}


 @override
Widget build(BuildContext context) {
  return WillPopScope(
    onWillPop: () => _onWillPop(context),
    child: SafeArea(
      child: Scaffold(
        backgroundColor: TColors.primarycolor3,
        resizeToAvoidBottomInset: false,
        body: Consumer<OnboardingProvider>(
          builder: (context, provider, child) {
            final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
            return Stack(
              children: [
                PageView.builder(
                  controller: controller,
                  itemCount: provider.pages.length,
                  onPageChanged: (value) => provider.setCurrentIndex(value),
                  itemBuilder: (context, index) {
                    final page = provider.pages[index];
                    return _page(
                      context: context,
                      pageIndex: index,
                      imageUrl: page.imagePath,
                      title: page.title,
                      desc: page.description,
                      provider: provider,
                    );
                  },
                ),
                // Skip button at the top right
           // Skip button remains unchanged
Positioned(
  top: 40.h,
  right: 30.w,
  child: Visibility(
    visible: provider.currentIndex != provider.pages.length - 1,
    child: GestureDetector(
      onTap: () {
         _showSkipConfirmation(context);
      },
      child: Text(
        localeProvider.translate('skip'),
        style: TextStyle(fontSize: 15.sp, color: TColors.primarycolor),
      ),
    ),
  ),
),

// Bottom Row with Back, Dots, and Next
Positioned(
  bottom: 50.h,
  left: 0,
  right: 0,
  child: Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Back Button (Left)
        GestureDetector(
          onTap: () {
            if (provider.currentIndex > 0) {
              controller.previousPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.decelerate,
              );
            }
          },
          child: Container(
  width: 50.w,
  height: 50.h,
  decoration: BoxDecoration(
    color: Colors.transparent, // Transparent background
    borderRadius: BorderRadius.circular(100.r),
    border: Border.all(
      color: TColors.primarycolor, // Border color
      width: 2.0,
    ),
  ),
  child: Icon(
    Icons.arrow_back,
    color: TColors.primarycolor, // Arrow color
  ),
),

        ),

        // Dots in the center
        Expanded(
          child: Center(
            child: DotsIndicator(
              dotsCount: provider.pages.length,
              position: provider.currentIndex.toDouble(),
              decorator: DotsDecorator(
                color: Colors.grey,
                activeColor: TColors.primarycolor,
                size: Size.square(13.sp),
                activeSize: Size.square(13.sp),
              ),
            ),
          ),
        ),

        // Next Button (Right)
        GestureDetector(
         onTap: () {
  if (provider.currentIndex == provider.pages.length - 1) {
    _showSkipConfirmation(context);
  } else {
    controller.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.decelerate,
    );
  }
},
          child: Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: TColors.primarycolor,
              borderRadius: BorderRadius.circular(100.r),
            ),
            child: const Icon(Icons.arrow_forward, color: Colors.white),
          ),
        ),
      ],
    ),
  ),
),
              ],
            );
          },
        ),
      ),
    ),
  );
}
Widget _page({
  required int pageIndex,
  required String imageUrl,
  required String title,
  required String desc,
  required BuildContext context,
  required OnboardingProvider provider,
}) {
  final localeProvider = Provider.of<LocaleProvider>(context, listen: false);

  return Column(
    children: [
      // Curved Top Container
      ClipPath(
        clipper: TopWavyClipper(),
        child: Container(
          height: 300.h,
          width: double.infinity,
          color: TColors.primarycolor.withOpacity(0.4), // Or gradient if you want
          child: Center(
            child: Image.asset(
              imageUrl,
              width: 300.w,
              height: 300.h,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
      SizedBox(height: 20.h),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Text(
              localeProvider.translate(title),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SizedBox(height: 10.h),
            Text(
              localeProvider.translate(desc),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 16.sp,
                    color: TColors.labeltext,
                  ),
            ),
          ],
        ),
      ),
    ],
  );
}
}