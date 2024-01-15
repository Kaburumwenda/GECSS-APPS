import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gecssmns/main.dart';
import 'package:gecssmns/screens/Finance/desktop/mpesa/mpesa_dashboard.dart';
import 'package:gecssmns/screens/batteries/desktop/battery/desk_battery_dash.dart';
import 'package:gecssmns/screens/batteries/desktop/swaps/desk_swap_dashboard.dart';
import 'package:gecssmns/screens/home/home_screen.dart';

class DesktopSidebar extends StatelessWidget {
  const DesktopSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Image.asset("assets/images/logo.png", width: 60,),

        const Divider(),

        ListTile(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(
             builder: (BuildContext context) => const HomeScreen(),
            ));
          },
          dense:true,
          minLeadingWidth : 8,
          leading:FaIcon(FontAwesomeIcons.gauge , size: 18, color: Theme.of(context).iconsColors),
          title: Text(
            "Dashboard",
            style: TextStyle(color: Theme.of(context).lightTextColor),
            ),
        ),

        ExpansionTile(
          title: Text("Finance", style: TextStyle(color: Theme.of(context).lightTextColor),),
          leading: FaIcon(FontAwesomeIcons.cashRegister , size: 18, color: Theme.of(context).iconsColors),
          // childrenPadding:const EdgeInsets.only(left: 20),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding:const EdgeInsets.symmetric(vertical: 0, horizontal: 20) ,
              dense: true,
              horizontalTitleGap: 2.0,
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const DeskMpesaDashboard(),
                  ));
               },
              leading: Icon(Icons.arrow_forward_ios, size: 15, color: Theme.of(context).lightTextColor),
              title: Text('Mpesa', style: TextStyle(color: Theme.of(context).lightTextColor),),
            ),
            ListTile(
              contentPadding:const EdgeInsets.symmetric(vertical: 0, horizontal: 20) ,
              dense: true,
              horizontalTitleGap: 2.0,
              onTap: (){},
              leading: Icon(Icons.arrow_forward_ios, size: 15, color: Theme.of(context).lightTextColor),
              title: Text('Payments', style: TextStyle(color: Theme.of(context).lightTextColor),),
            ),
            ListTile(
              contentPadding:const EdgeInsets.symmetric(vertical: 0, horizontal: 20) ,
              dense: true,
              horizontalTitleGap: 2.0,
              onTap: (){},
              leading: Icon(Icons.arrow_forward_ios, size: 15, color: Theme.of(context).lightTextColor),
              title: Text('Offers', style: TextStyle(color: Theme.of(context).lightTextColor),),
            ),
            ListTile(
              contentPadding:const EdgeInsets.symmetric(vertical: 0, horizontal: 20) ,
              dense: true,
              horizontalTitleGap: 2.0,
              onTap: (){},
              leading: Icon(Icons.arrow_forward_ios, size: 15, color: Theme.of(context).lightTextColor),
              title: Text('Complains', style: TextStyle(color: Theme.of(context).lightTextColor),),
            ),
            ListTile(
              contentPadding:const EdgeInsets.symmetric(vertical: 0, horizontal: 20) ,
              dense: true,
              horizontalTitleGap: 2.0,
              onTap: (){},
              leading: Icon(Icons.arrow_forward_ios, size: 15, color: Theme.of(context).lightTextColor),
              title: Text('Reports', style: TextStyle(color: Theme.of(context).lightTextColor),),
            ),
            

          ],
          ),

        ListTile(
          onTap: (){},
          dense:true,
          minLeadingWidth : 8,
          leading: FaIcon(FontAwesomeIcons.sitemap, size: 18, color: Theme.of(context).iconsColors),
          title: Text(
            "IAM",
            style: TextStyle(color: Theme.of(context).lightTextColor),
            ),
        ),

        ExpansionTile(
          title: Text("Batteries", style: TextStyle(color: Theme.of(context).lightTextColor),),
          leading: FaIcon(FontAwesomeIcons.carBattery , size: 18, color: Theme.of(context).iconsColors),
          // childrenPadding:const EdgeInsets.only(left: 20),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding:const EdgeInsets.symmetric(vertical: 0, horizontal: 20) ,
              dense: true,
              horizontalTitleGap: 2.0,
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const DeskBatterySwapDashboard(),
                  ));
               },
              leading: Icon(Icons.arrow_forward_ios, size: 15, color: Theme.of(context).lightTextColor),
              title: Text('Swap', style: TextStyle(color: Theme.of(context).lightTextColor),),
            ),
            ListTile(
              contentPadding:const EdgeInsets.symmetric(vertical: 0, horizontal: 20) ,
              dense: true,
              horizontalTitleGap: 2.0,
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const DeskBatteryDashboard(),
                  ));
               },
              leading: Icon(Icons.arrow_forward_ios, size: 15, color: Theme.of(context).lightTextColor),
              title: Text('Batteries', style: TextStyle(color: Theme.of(context).lightTextColor),),
            ),
          ],
        ),

        ListTile(
          onTap: (){},
          dense:true,
          minLeadingWidth : 8,
          leading: FaIcon(FontAwesomeIcons.motorcycle, size: 18, color: Theme.of(context).iconsColors),
          title: Text(
            "Motorbikes",
            style: TextStyle(color: Theme.of(context).lightTextColor),
            ),
        ),

        ListTile(
          onTap: (){},
          dense:true,
          minLeadingWidth : 8,
          leading: FaIcon(FontAwesomeIcons.folderTree , size: 18, color: Theme.of(context).iconsColors),
          title: Text(
            "Reports",
            style: TextStyle(color: Theme.of(context).lightTextColor),
            ),
        ),

      ],),
    );
  }
}