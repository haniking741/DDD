import 'package:dawini/const/colors.dart';
import 'package:dawini/screens/home/home/commun/listview.dart';
import 'package:dawini/screens/home/home/components.dart';
import 'package:dawini/screens/home/home/doctors/fetchdoctors.dart';
import 'package:dawini/screens/home/home/widgets/home_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  final List<Map<String, dynamic>> carousel_products = [

  ];
 final List<Map<String, dynamic>> products = [
   {
      "main_image": "assets/images/hospitals/hospital1.jpg",
      "second_image":"assets/images/hospitals/hospital2.jpeg",
      "hospitalName": "Alia Salah Hospital",
      "category": "Emergency",
      "rating": 4.5,
      "description": "emergency hospital Alia Salah for operations & Medical follow-up"
    },
   {
  "main_image": "assets/images/hospitals/hospital1.jpg",
  "second_image": "assets/images/hospitals/hospital2.jpeg",
  "hospitalName": "Clinique Ennour Tebessa",
  "category": "Private",
  "rating": 4.3,
  "description": "Ennour Clinic provides specialized medical care in surgery, gynecology, pediatrics, and internal medicine in Tebessa."
}

  
  ];
late FocusNode _searchFocusNode;
late TextEditingController searchController;

@override
void didChangeDependencies() {
  searchController = TextEditingController();
  _searchFocusNode = FocusNode();
  super.didChangeDependencies();
  // Unfocus keyboard when the screen appears
  Future.microtask(() {
    FocusScope.of(context).unfocus();
    _searchFocusNode.unfocus();
  });
}

@override
void dispose() {
  _searchFocusNode.dispose();
  searchController.dispose();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.primarycolor3,
      body: ListView(
        children: [
          HomeWidgets.buildHeader(searchController, context,_searchFocusNode),
          HomeWidgets.buildSectionHeader3(context),
         HomeWidgets.buildContainer(
  doctorName: "Dr. Ahmed Salah",
  specialty: "Cardiologist",
  imagePath: "assets/icons/doctor.png",
  date: "Monday, 26 July",
  time: "09:00 - 10:00",
  onCallTap: () {
    print("Calling Dr. Ahmed Salah...");
    // يمكنك هنا استدعاء الاتصال أو أي أكشن آخر
  },
),
SizedBox(height: 15.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HomeWidgets.buildPageIndicator(_pageController, carousel_products.length,context),
                  ],
                ),
              ),
            ],
          ),
          HomeWidgets.buildSectionHeader1(context),
          SizedBox(height: 15.h),
         ListViewImages(
  titleList: [
    "Dentist", "Cardiology", "Orthopae","Neurologue","gastrologue",
    "Generaliste", "Génécologue","Others"
  ],
  imageList: [
    "assets/icons/tooth.png",
    "assets/icons/heart.png",
    "assets/icons/kidney.png",
    "assets/icons/brain.png",
    "assets/icons/stomach.png",
    "assets/icons/doctor.png",
    "assets/icons/womb.png",
    "assets/icons/more.png",
  ],
  onItemTap: (selectedCategory) {
  if (selectedCategory == "Others") {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ComponentsScreen()),
    );
  } else {
   Navigator.push(
  context,
  PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 400),
    pageBuilder: (context, animation, secondaryAnimation) => DoctorsFetch(category: selectedCategory),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  ),
);


  }
}


),
          SizedBox(height: 5.h),
          HomeWidgets.buildSectionHeader2(context),
          SizedBox(height: 15.h),
          HomeWidgets.buildProductGrid(products,context),
        ],
      ),
    );
  }
}
