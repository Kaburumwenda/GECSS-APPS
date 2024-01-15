import 'package:flutter/material.dart';
import 'package:gecssmns/main.dart';
import 'package:gecssmns/responsive/responsive_layout.dart';
import 'package:gecssmns/screens/home/desktop/dashboard.dart';
import 'package:gecssmns/screens/home/mobile/mobile_dashboard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryBackground,
      
      body:const ResponsiveLayout(
        desktopBody:DesktopDashboard(),
        mobileBody:MobileDashboard() ,
        ),
    );
  }
}