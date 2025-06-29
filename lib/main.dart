import 'package:dawini/providers/navigationbar_provider.dart';
import 'package:dawini/providers/onboarding_provider.dart';
import 'package:dawini/providers/theme_provider.dart';
import 'package:dawini/screens/authentication/forgotpassword/forgotpassword.dart';
import 'package:dawini/screens/authentication/login/loginscreen.dart';
import 'package:dawini/screens/authentication/signup/signupscreen.dart';
import 'package:dawini/screens/home/booking/booking_provider/booking_provider.dart'
    show AppointmentProvider;
import 'package:dawini/screens/home/chat/chat_provider/chat_provider.dart';
import 'package:dawini/screens/home/home/doctors/doctors_provider/doctors_provider.dart';
import 'package:dawini/services/translation.dart';
import 'package:dawini/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final localeProvider = LocaleProvider();
  await localeProvider.loadSavedLocale();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => OnboardingProvider()),
        ChangeNotifierProvider.value(value: localeProvider),
        ChangeNotifierProvider(create: (_) => DoctorProvider()),
        ChangeNotifierProvider(create: (_) => AppointmentProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final currentLocale = localeProvider.locale.languageCode ?? 'en';
    final isArabic = currentLocale == 'ar';

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Dawini',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          theme: ThemeData(
            fontFamily: isArabic ? 'Cairo' : 'Poppins',
            brightness: Brightness.light,
            primarySwatch: Colors.teal,
          ),
          darkTheme: ThemeData(
            fontFamily: isArabic ? 'Cairo' : 'Poppins',
            brightness: Brightness.dark,
          ),
          locale: localeProvider.locale,
          supportedLocales: const [Locale('en'), Locale('ar')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          routes: {
            '/login': (context) => const LoginScreen(),
            '/signup': (context) => const SignupScreen(),
            '/root': (context) => const RootScreen(),
            '/forgot-password': (context) => ForgotPassEmail(),
            // Add more if needed
          },
          home: const Splashscreen(),
        );
      },
    );
  }
}
