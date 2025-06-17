import 'package:dawini/services/translation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnboardingPageModel {
  final String imagePath;
  final String title;
  final String description;

  OnboardingPageModel({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}

class OnboardingProvider extends ChangeNotifier {
 final List<OnboardingPageModel> _pages = [
  OnboardingPageModel(
    imagePath: 'assets/images/page1.png',
    title: 'welcome',
    description: 'description_welcome',
  ),
  OnboardingPageModel(
    imagePath: 'assets/images/page2.png',
    title: 'perfect_time',
    description: 'description_perfect_time',
  ),
  OnboardingPageModel(
    imagePath: 'assets/images/page3.png',
    title: 'secured_payment',
    description: 'description_secured_payment',
  ),
];


  int _currentIndex = 0;

  List<OnboardingPageModel> get pages => _pages;
  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  String getTranslatedTitle(String key, BuildContext context) {
    return Provider.of<LocaleProvider>(context, listen: false).translate(key);
  }

  String getTranslatedDescription(String key, BuildContext context) {
    return Provider.of<LocaleProvider>(context, listen: false).translate(key);
  }
}
