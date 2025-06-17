import 'package:dawini/const/colors.dart';
import 'package:dawini/screens/home/booking/booking.dart';
import 'package:dawini/screens/home/chat/chatpage.dart';
import 'package:dawini/screens/home/home/homescreen.dart';
import 'package:dawini/screens/home/profile/profilepage.dart';
import 'package:dawini/services/translation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late List<Widget> screens;
  int currentScreen = 0;
  late PageController controller;
  DateTime? lastPressed;

  @override
  void initState() {
    super.initState();
    screens = [
      HomeScreen(),
      const BookingPage(),
      const Chatpage(),
      const Profilepage(),
    ];
    controller = PageController(initialPage: currentScreen);

    controller.addListener(() {
      int page = controller.page?.round() ?? 0;
      if (page != currentScreen) {
        setState(() {
          currentScreen = page;
        });
      }
    });
  }

  Future<bool> _onWillPop() async {
    final now = DateTime.now();
    if (lastPressed == null || now.difference(lastPressed!) > const Duration(seconds: 2)) {
      lastPressed = now;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Press back again to exit'),
          backgroundColor: Colors.black54,
          duration: Duration(seconds: 3),
        ),
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor:  TColors.primarycolor3,
        body: PageView(
          controller: controller,
          children: screens,
        ),
       bottomNavigationBar: ClipRRect(
  borderRadius:  BorderRadius.only(
    topLeft: Radius.circular(25.r),
    topRight: Radius.circular(25.r),
  ),
  child: Container(
    decoration: BoxDecoration(
      color: TColors.primarycolor3,

    ),
    child: NavigationBar(
      backgroundColor: TColors.primarycolor3,
      selectedIndex: currentScreen,
      elevation: 10,
      height: kBottomNavigationBarHeight,
      onDestinationSelected: (index) {
        setState(() {
          currentScreen = index;
        });
        controller.jumpToPage(currentScreen);
      },
      destinations: [
        NavigationDestination(
          selectedIcon: Icon(
            CupertinoIcons.home,
            color: currentScreen == 0 ? TColors.primarycolor : Colors.grey,
          ),
          icon: Icon(
            CupertinoIcons.home,
            color: currentScreen == 0 ? TColors.primarycolor : Colors.grey,
          ),
          label: localeProvider.translate("home"),
        ),
        NavigationDestination(
          selectedIcon: Icon(
            CupertinoIcons.calendar_circle_fill,
            color: currentScreen == 1 ? TColors.primarycolor : Colors.grey,
          ),
          icon: Icon(
            CupertinoIcons.calendar,
            color: currentScreen == 1 ? TColors.primarycolor : Colors.grey,
          ),
          label: localeProvider.translate("bookings"),
        ),
        NavigationDestination(
          selectedIcon: Icon(
            CupertinoIcons.chat_bubble_2_fill,
            color: currentScreen == 2 ? TColors.primarycolor : Colors.grey,
          ),
          icon: Icon(
            CupertinoIcons.chat_bubble_2_fill,
            color: currentScreen == 2 ? TColors.primarycolor : Colors.grey,
          ),
          label: localeProvider.translate("chat"),
        ),
        NavigationDestination(
          selectedIcon: Icon(
            CupertinoIcons.person_fill,
            color: currentScreen == 3 ? TColors.primarycolor : Colors.grey,
          ),
          icon: Icon(
            CupertinoIcons.person_fill,
            color: currentScreen == 3 ? TColors.primarycolor : Colors.grey,
          ),
          label: localeProvider.translate("profile"),
        ),
      ],
    ),
  ),
),

      ),
    );
  }
}
