import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListViewImages extends StatelessWidget {
  const ListViewImages({
    super.key,
    required this.titleList,
    required this.imageList,
    required this.onItemTap,
  });

  final List<String> titleList;
  final List<String> imageList;
  final Function(String) onItemTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 120.h,
      child: ListView.builder(
        itemCount: titleList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onItemTap(titleList[index]),
            child: SizedBox(
              width: 80.w,
              child: Padding(
                padding: EdgeInsets.all(8.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 56.w,
                      height: 56.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: theme.cardColor,
                      ),
                      child: Center(
                        child: Image.asset(
                          imageList[index],
                          fit: BoxFit.cover,
                          width: 40.w,
                          height: 40.h,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    SizedBox(
                      width: 60.w,
                      child: Text(
                        titleList[index],
                        style: theme.textTheme.bodySmall?.copyWith(fontSize: 10.sp),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
