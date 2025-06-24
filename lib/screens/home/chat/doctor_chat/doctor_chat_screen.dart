import 'package:dawini/const/colors.dart';
import 'package:dawini/services/translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DoctorChatScreen extends StatefulWidget {
  final String doctorName;
  final String doctorImage;
  final bool isOnline;

  const DoctorChatScreen({
    super.key,
    required this.doctorName,
    required this.doctorImage,
    required this.isOnline,
  });

  @override
  State<DoctorChatScreen> createState() => _DoctorChatScreenState();
}

class _DoctorChatScreenState extends State<DoctorChatScreen> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textController = TextEditingController();
  bool _isTextFieldFocused = false;
  bool _showMicTemporarily = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isTextFieldFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);

    final messages = [
      {
        'text': "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        'isMe': false,
        'type': 'text',
        'time': "08:04 pm"
      },
      {
        'text': "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        'isMe': true,
        'type': 'text',
        'time': "08:04 pm"
      },
      {
        'text': "assets/icons/doctor.png",
        'isMe': false,
        'type': 'image',
        'time': "08:04 pm"
      },
      {
        'text': "0:13",
        'isMe': true,
        'type': 'audio',
        'time': "08:04 pm"
      },
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: TColors.primarycolor3,
        body: Stack(
          children: [
            // 🔵 Top Blue Header
            Container(
              width: double.infinity,
              height: 120.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(color: TColors.primarycolor),
              child: Row(
                children: [
                  Container(
                    height: 40.h,
                    width: 40.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, size: 20.sp, color: TColors.labeltext),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  CircleAvatar(
                    backgroundImage: AssetImage(widget.doctorImage),
                    radius: 22.r,
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.doctorName,
                        style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        widget.isOnline ? "Online" : "Offline",
                        style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    height: 40.h,
                    width: 40.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: TColors.primarycolor3,
                    ),
                    child: Icon(Icons.more_vert, color: TColors.labeltext, size: 20.sp),
                  ),
                ],
              ),
            ),

            // ⚪️ White Rounded Container with messages
            Padding(
              padding: EdgeInsets.only(top: 90.h),
              child: Container(
                width: double.infinity,
                height: ScreenUtil().screenHeight,
                decoration: BoxDecoration(
                  color: TColors.primarycolor3,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.all(20.w),
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          final isMe = message['isMe'] as bool;

                          return Align(
                            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 6.h),
                                  padding: EdgeInsets.all(12.w),
                                  constraints: BoxConstraints(maxWidth: 250.w),
                                  decoration: BoxDecoration(
                                    color: isMe ? TColors.primarycolor : Colors.white,
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: message['type'] == 'text'
                                      ? Text(
                                          message['text'] as String,
                                          style: TextStyle(
                                            color: isMe ? Colors.white : Colors.black87,
                                            fontSize: 13.sp,
                                          ),
                                        )
                                      : message['type'] == 'image'
                                          ? ClipRRect(
                                              borderRadius: BorderRadius.circular(10.r),
                                              child: Image.asset(
                                                message['text'] as String,
                                                width: 200.w,
                                                height: 150.h,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : Row(
                                              children: [
                                                Icon(Icons.play_arrow, color: isMe ? Colors.white : Colors.black),
                                                SizedBox(width: 6.w),
                                                Expanded(
                                                  child: Container(
                                                    height: 4.h,
                                                    decoration: BoxDecoration(
                                                      color: isMe ? Colors.white : Colors.grey,
                                                      borderRadius: BorderRadius.circular(2.r),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 8.w),
                                                Text(
                                                  message['text'] as String,
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: isMe ? Colors.white : Colors.black87,
                                                  ),
                                                )
                                              ],
                                            ),
                                ),
                                Text(
                                  message['time'] as String,
                                  style: TextStyle(fontSize: 11.sp, color: Colors.grey),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    // Chat Input Area
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      child: Row(
                        children: [
                          Icon(Icons.add, color: Colors.grey),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: TextField(
                                controller: _textController,
                                focusNode: _focusNode,
                                decoration: const InputDecoration(
                                  hintText: "Type a message here...",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          GestureDetector(
                            onLongPress: () {
                              setState(() => _showMicTemporarily = true);
                            },
                            onLongPressUp: () {
                              setState(() => _showMicTemporarily = false);
                            },
                            onTap: () {
                              // send message logic
                            },
                            child: Icon(
                              _showMicTemporarily
                                  ? Icons.mic
                                  : (_isTextFieldFocused ? Icons.send : Icons.mic),
                              color: _showMicTemporarily
                                  ? Colors.grey
                                  : (_isTextFieldFocused ? TColors.primarycolor : Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
