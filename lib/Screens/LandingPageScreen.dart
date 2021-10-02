import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LandingPageScreen extends StatefulWidget {
  const LandingPageScreen({Key? key}) : super(key: key);

  @override
  _LandingPageScreenState createState() => _LandingPageScreenState();
}

class _LandingPageScreenState extends State<LandingPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Lottie.asset('assets/animations/landing-animation.json'),
    );
  }
}
