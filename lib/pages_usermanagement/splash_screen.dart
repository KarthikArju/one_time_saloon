import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:salon/features/home_page.dart';
import 'package:salon/pages_usermanagement/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  bool islogin = false;
  checkLogin() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    if (prefs.getString("Email") != "" && prefs.getString("Email") != null) {
      islogin = true;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Image.asset(
          'assets/saloon_logo.png',
        ),
        // child: SvgPicture.asset('assets/logo.svg'),
      ),
      nextScreen: islogin ? HomePage() : const OnBoardingScreen(),
      duration: 3500,
      backgroundColor: Colors.white,
    );
  }
}
