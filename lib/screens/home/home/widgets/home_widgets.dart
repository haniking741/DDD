import 'package:dawini/const/button.dart';
import 'package:dawini/const/colors.dart';
import 'package:dawini/services/translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class HomeWidgets {
  static Widget buildHeader(TextEditingController searchController, context, FocusNode searchFocusNode) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final theme = Theme.of(context);
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: ScreenUtil().screenHeight / 5,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal:  12.w,vertical: 9.h),
            child: Column(
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [
    
    Text(localeProvider.translate("location"), style: theme.textTheme.titleMedium),
    SizedBox(height: 10.h,),
    Row(
      children: [
        Icon(Icons.location_on, size: 25.sp, color: TColors.primarycolor),
        SizedBox(width: 5.w),
        Text(
          "Tebessa, Algeria",
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
      ]
    ),
    SizedBox(height: 15.h,),
    HomeWidgets.buildSearchBar(searchController, searchFocusNode, context)
  ],
),
          ),
        ),
      ],
    );
  }

static Widget buildSearchBar(TextEditingController searchController, FocusNode focusNode, BuildContext context) {
  final localeProvider = Provider.of<LocaleProvider>(context);
  final theme = Theme.of(context);

  return Row(
  children: [
    Expanded(
      child: Container(
        height: 55.h,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(width: 1, color: TColors.labeltext.withOpacity(0.2)),
        ),
        child: TextField(
          controller: searchController,
          focusNode: focusNode,
          autofocus: false,
          decoration: InputDecoration(
            hintText: localeProvider.translate("search_here"),
            hintStyle: TextStyle(color: theme.hintColor),
            prefixIcon: Icon(Icons.search_rounded, color: TColors.primarycolor,size: 24.sp,),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 12.h),
          ),
        ),
      ),
    ),
    SizedBox(width: 10.w),
    Container(
      height: 50.h,
      width: 50.h,
      decoration: BoxDecoration(
        color: TColors.primarycolor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: const Icon(Icons.filter_list, color: Colors.white),
    ),
  ],
);

}


  static Widget buildSectionHeader1(context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            localeProvider.translate("categories"),
            style: theme.textTheme.titleLarge!.copyWith(color: TColors.labeltext)
          ),
          PrimaryTextButton(text: localeProvider.translate("see_all"), onPressed: (){})
        ],
      ),
    );
  }
  static Widget buildSectionHeader2(context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            localeProvider.translate("popular_products"),
            style: theme.textTheme.titleLarge!.copyWith(color: TColors.labeltext)
          ),
          PrimaryTextButton(text: localeProvider.translate("see_all"), onPressed: (){})
        ],
      ),
    );
  }
  static Widget buildSectionHeader3(context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            localeProvider.translate("schedule"),
            style: theme.textTheme.titleLarge!.copyWith(color: TColors.labeltext)
          ),
        ],
      ),
    );
  }
static Widget buildContainer({
  required String doctorName,
  required String specialty,
  required String imagePath,
  required String date,
  required String time,
  required VoidCallback onCallTap,
}) {
  return Padding(
    padding: EdgeInsets.all(20.w),
    child: Container(
      width: double.infinity,
      height: 150.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: TColors.primarycolor,
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // الصف العلوي: صورة + الاسم + التخصص + الاتصال
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 22.r,
                    backgroundImage: AssetImage(imagePath),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctorName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          specialty,
                          style: TextStyle(
                            color: TColors.primarycolor3,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: onCallTap,
                    child: Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.phone,
                        color: TColors.primarycolor,
                        size: 22.sp,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
          
              // الصف السفلي: التاريخ والوقت
              Container(
                width: double.infinity,
                height: 50.h,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: TColors.labeltext.withOpacity(0.2),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, color: Colors.white, size: 18.sp),
                    SizedBox(width: 8.w),
                    Text(
                      date,
                      style: TextStyle(color: Colors.white, fontSize: 12.sp),
                    ),
                    Spacer(),
                    Container(
                      width: 1,
                      height: 24.h,
                      color: Colors.white.withOpacity(0.5),
                    ),
                    Spacer(),
                    Icon(Icons.access_time, color: Colors.white, size: 18.sp),
                    SizedBox(width: 8.w),
                    Text(
                      time,
                      style: TextStyle(color: Colors.white, fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}


  static Widget buildPageIndicator(PageController pageController, int itemCount, context) {
    return SmoothPageIndicator(
      controller: pageController,
      count: itemCount,
      effect: ExpandingDotsEffect(
        dotHeight: 10.h,
        dotWidth: 10.w,
        dotColor: Colors.grey[400]!,
      ),
    );
  }
 static Widget buildProductGrid(
  List<Map<String, dynamic>> products,
  BuildContext context,
) {
  final int itemCount = products.length > 4 ? 4 : products.length;
  final theme = Theme.of(context);

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.w),
    child: GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: itemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20.w,
        mainAxisSpacing: 20.h,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        final product = products[index];

        return GestureDetector(
          onTap: () {
            // TODO: Navigate to hospital detail or perform an action
          },
          child: Container(
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      // Hospital image
                      ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(12.r)),
                        child: Image.asset(
                          product['main_image'],
                          width: double.infinity,
                          height: ScreenUtil().screenHeight * 0.3,
                          fit: BoxFit.cover,
                        ),
                      ),

                      // Favorite icon (top-right)
                      Positioned(
                        top: 8.h,
                        right: 8.w,
                        child: Container(
                          width: 30.w,
                          height: 30.w,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.6),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.directions,
                            size: 18.sp,
                            color: TColors.primarycolor
                          ),
                        ),
                      ),

                      // Rating badge (bottom-right)
                      Positioned(
                        bottom: 10.h,
                        right: 8.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 14.sp,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                product['rating'].toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['hospitalName'],
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        product['category'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}


}