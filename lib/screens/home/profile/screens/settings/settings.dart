import 'package:dawini/const/colors.dart';
import 'package:dawini/screens/home/profile/screens/settings/password_manager/password_manager.dart';
import 'package:dawini/services/translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: TColors.primarycolor3,
        appBar: AppBar(
          title: Text(
            localeProvider.translate("settings"),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildMenuItem(
                Icons.notifications,
                localeProvider.translate("notification"),
                () {},
              ),
              buildMenuItem(
                Icons.lock,
                localeProvider.translate("password_manager"),
                () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 400),
                      pageBuilder:
                          (context, animation, secondaryAnimation) =>
                              PasswordManager(),
                      transitionsBuilder: (
                        context,
                        animation,
                        secondaryAnimation,
                        child,
                      ) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                    ),
                  );
                },
              ),
              buildMenuItem(
                Icons.delete_forever_outlined,
                localeProvider.translate("delete_account"),
                () {},
              ),
            ],
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
