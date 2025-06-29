import 'package:dawini/const/colors.dart';
import 'package:dawini/screens/home/chat/chat_provider/chat_provider.dart';
import 'package:dawini/screens/home/chat/doctor_chat/doctor_chat_screen.dart';
import 'package:dawini/services/translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Chatpage extends StatelessWidget {
  const Chatpage({super.key});

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: TColors.primarycolor3,
        body: Column(
          children: [
            // 🔵 Blue Header with rounded bottom corners
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: TColors.primarycolor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24.r),
                  bottomRight: Radius.circular(24.r),
                ),
              ),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      localeProvider.translate("chat"),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: TColors.primarycolor3,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: localeProvider.translate("search_doctor"),
                        border: InputBorder.none,
                        icon: Icon(Icons.search, size: 20.sp),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                ],
              ),
            ),

            // ⚪ White Container with rounded top corners
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: TColors.primarycolor3,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: chatProvider.chats.length,
                      separatorBuilder: (_, __) => SizedBox(width: 12.w),
                      itemBuilder: (context, index) {
                        final chat = chatProvider.chats[index];
                        return Column(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage(chat.image),
                                  radius: 28.r,
                                ),
                                if (chat.isOnline)
                                  Positioned(
                                    bottom: 2.h,
                                    right: 2.w,
                                    child: Container(
                                      width: 10.w,
                                      height: 10.h,
                                      decoration: const BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              chat.name
                                  .split(' ')
                                  .first, // Show only first name
                              style: TextStyle(fontSize: 12.sp),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // ⬇️ Spacing before chat list
            SizedBox(height: 12.h),

            // 📝 Chat List
            // 📝 Chat List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                itemCount: chatProvider.chats.length,
                itemBuilder: (context, index) {
                  final chat = chatProvider.chats[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 400),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      DoctorChatScreen(
                                        doctorName: chat.name,
                                        doctorImage: chat.image,
                                        isOnline: chat.isOnline,
                                      ),
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

                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Stack(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(chat.image),
                                radius: 26.r,
                              ),
                              if (chat.isOnline)
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    width: 10.w,
                                    height: 10.h,
                                    decoration: const BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          title: Text(
                            chat.name,
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          subtitle: Text(
                            chat.message,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                          trailing: Text(
                            chat.time,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
