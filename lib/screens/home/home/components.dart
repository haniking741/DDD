import 'package:dawini/const/colors.dart';
import 'package:dawini/screens/home/home/widgets/home_widgets.dart';
import 'package:dawini/services/translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
class ComponentsScreen extends StatefulWidget {
  const ComponentsScreen({super.key});

  @override
  _ComponentsScreenState createState() => _ComponentsScreenState();
}

class _ComponentsScreenState extends State<ComponentsScreen> {
  bool isLoading = true; // Initially, set loading to true
  List<Map<String, dynamic>> products = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    // Simulating a delay for fetching data
    await Future.delayed(Duration(seconds: 1));
    if (!mounted) return;
    setState(() {
       products = [
     
    {
      "main_image": "assets/images/products/product2.jpg",
      "productName": "samsung s22 ultra",
      "categoryName": "Phone",
      "price": 25000,
      "rating": 4.2,
      "description": "samsung s21 ultra battrie excelente avec sans boitier et chargeur dorigine"
    },
    {
      "main_image": "assets/images/products/product4.jpg",
      "productName": "ASUS GeForce GTX 1660 SUPER",
      "categoryName": "Electromenager",
      "price": 35000,
      "rating": 4.8,
      "description": "A high-performance graphics card with 6GB GDDR6 memory, ideal for 1080p gaming with smooth frame rates and excellent cooling."
    },
    {
      "main_image": "assets/images/products/product5.png",
      "productName": "MSI k78",
      "categoryName": "Electromenager",
      "price": 8000,
      "rating": 3.5,
      "description": "A premium mechanical keyboard with customizable RGB lighting, ergonomic design, and durable key switches for responsive typing."
    },
  ];


      isLoading = false; // Set loading to false after fetching
    });
  }

  List<Map<String, dynamic>> getCategoryProducts(String category) {
    return products.where((product) => product['categoryName'] == category).toList();
  }

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: TColors.primarycolor3,
          appBar: AppBar(
            title: Text(localeProvider.translate("other_products"),),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(text: localeProvider.translate("Rheumatologist"),),
                Tab(text: localeProvider.translate("Orthopedic"),),
                Tab(text: localeProvider.translate("Internal diseases"),),
              ],
            ),
          ),
          body: isLoading
              ? Center(child: CircularProgressIndicator()) // Show loading indicator
              : Padding(
                  padding: EdgeInsets.only(top: 20.w),
                  child: TabBarView(
                    children: [
                      _buildCategoryView("Rheumatologist"),
                      _buildCategoryView("Orthopedic"),
                      _buildCategoryView("Internal diseases"),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildCategoryView(String category) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    List<Map<String, dynamic>> categoryProducts = getCategoryProducts(category);
    if (categoryProducts.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Center(child: Text(localeProvider.translate("no_item"))),
          Image.asset("assets/images/empty.gif",width: double.infinity,height: 200.w,),
        ],
      );
    }
    return HomeWidgets.buildProductGrid(categoryProducts,context);
  }
}
