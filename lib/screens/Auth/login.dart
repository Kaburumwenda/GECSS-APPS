import 'package:flutter/material.dart';
import 'package:gecssmns/responsive/responsive_layout.dart';
import 'package:gecssmns/screens/Auth/desktop_login.dart';
import 'package:gecssmns/screens/Auth/mobile_login.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ResponsiveLayout(
        desktopBody: DesktopLoginScreen(),
        mobileBody: MobileLoginScreen(),
       
        ),
    );
  }
}