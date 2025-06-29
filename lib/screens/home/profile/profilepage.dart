import 'package:dawini/const/others.dart';
import 'package:dawini/screens/home/profile/screens/myprofile/myprofile.dart';
import 'package:dawini/screens/home/profile/screens/privacy%20&%20policy/privacy.dart';
import 'package:dawini/screens/home/profile/screens/settings/settings.dart';
import 'package:dawini/services/translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dawini/const/colors.dart';
import 'package:provider/provider.dart'; // Make sure this contains the correct color codes

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: TColors.primarycolor3,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back arrow and title
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      localeProvider.translate("profile"),
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),

                // Profile picture with edit icon
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50.r,
                        backgroundImage: AssetImage(
                          "assets/icons/doctor.png",
                        ), // Replace with real image
                      ),
                      Container(
                        width: 28.w,
                        height: 28.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: TColors.primarycolor,
                        ),
                        child: Icon(
                          Icons.edit,
                          size: 16.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),

                // Name
                Center(
                  child: Text(
                    "Esther Howard",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 30.h),

                // Menu items
                buildMenuItem(
                  Icons.person,
                  localeProvider.translate("profile"),
                  () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 400),
                        pageBuilder:
                            (context, animation, secondaryAnimation) =>
                                MyProfile(),
                        transitionsBuilder: (
                          context,
                          animation,
                          secondaryAnimation,
                          child,
                        ) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                ),
                // buildMenuItem(Icons.payment, localeProvider.translate("payment")),
                buildMenuItem(
                  Icons.settings,
                  localeProvider.translate("settings"),
                  () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 400),
                        pageBuilder:
                            (context, animation, secondaryAnimation) =>
                                Settings(),
                        transitionsBuilder: (
                          context,
                          animation,
                          secondaryAnimation,
                          child,
                        ) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                ),
                buildMenuItem(
                  Icons.info_outline,
                  localeProvider.translate("help"),
                  () {},
                ),
                buildMenuItem(
                  Icons.privacy_tip_outlined,
                  localeProvider.translate("privacy"),
                  () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 400),
                        pageBuilder:
                            (context, animation, secondaryAnimation) =>
                                PrivacyScreen(),
                        transitionsBuilder: (
                          context,
                          animation,
                          secondaryAnimation,
                          child,
                        ) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                ),
               buildMenuItem(
  Icons.logout,
  localeProvider.translate("logout"),
  () {
    showLogoutConfirmationDialog(
      context,
      () {
        Navigator.of(context).pushReplacementNamed('/login');
      },
    );
  },
),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: ListTile(
          leading: Icon(icon, color: TColors.primarycolor),
          title: Text(title, style: TextStyle(fontSize: 14.sp)),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16.sp,
            color: TColors.primarycolor,
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
