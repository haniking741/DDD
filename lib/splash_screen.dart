import 'package:dawini/const/colors.dart';
import 'package:dawini/screens/onboardingscreen.dart';
import 'package:dawini/services/translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showLanguageDialog(context);
    });
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
        return AlertDialog(

          title: Text(
            localeProvider.translate("select_language"),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLanguageOption("english", const Locale('en')),
              _buildLanguageOption("العربية", const Locale('ar')),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(String title, Locale locale) {
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, child) {
        return ListTile(
          title: Text(title,style: Theme.of(context).textTheme.titleMedium,),
          onTap: () async {
            await localeProvider.loadLocale(locale);
            Navigator.pop(context);
            _startAnimationAndNavigate();
          },
        );
      },
    );
  }
  void _startAnimationAndNavigate() {
    Future.delayed(const Duration(seconds: 3), () {
   Navigator.pushReplacement(
  context,
  PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 700),
    pageBuilder: (context, animation, secondaryAnimation) => Onboarding(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  ),
);

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.primarycolor,
      body: Stack(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Image.asset("assets/images/splash.gif",width: 60.w,),
                    Text("Dawini App",style: Theme.of(context).textTheme.displayMedium!.copyWith(color: TColors.primarycolor2,fontSize: 30.sp),)
                  ],
                )
              ],
            ),
          )
        ],
      ) 
    );
  }
}
