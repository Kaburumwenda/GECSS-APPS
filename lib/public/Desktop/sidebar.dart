import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gecssmns/main.dart';
import 'package:gecssmns/screens/Finance/desktop/mpesa/mpesa_dashboard.dart';
import 'package:gecssmns/screens/batteries/desktop/battery/desk_battery_dash.dart';
import 'package:gecssmns/screens/batteries/desktop/swaps/desk_swap_dashboard.dart';
import 'package:gecssmns/screens/ebikes/desktop/new/desk_ebike_dash.dart';
import 'package:gecssmns/screens/ebikes/desktop/retrofitted/desk_retro_dash.dart';
import 'package:gecssmns/screens/home/home_screen.dart';
import 'package:gecssmns/screens/reports/battery/report_swaps_dashboard.dart';
import 'package:gecssmns/screens/reports/mpesa/report_mpesa_dashboard.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nb_utils/nb_utils.dart';

class DesktopSidebar extends StatefulWidget {
  const DesktopSidebar({super.key});

  @override
  State<DesktopSidebar> createState() => _DesktopSidebarState();
}

class _DesktopSidebarState extends State<DesktopSidebar> {
  LocalStorage staffstorage = LocalStorage('staff');

  var staffrole;

  @override
    void initState() {
      super.initState();
      setState(() {
        staffrole = staffstorage.getItem('role');
      });
    }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Column(children: [
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
                  title: Text('Mobile money', style: TextStyle(color: Theme.of(context).lightTextColor),),
                ),
                ListTile(
                  contentPadding:const EdgeInsets.symmetric(vertical: 0, horizontal: 20) ,
                  dense: true,
                  horizontalTitleGap: 2.0,
                  onTap: (){
                    snackBar(
                      context,
                      title: 'Access denied...Please contact system Admin : sysadmin@gecss-ke.com',
                      textColor: Colors.white,
                      backgroundColor: Colors.red,
                      elevation: 8,
                      //shape: RoundedRectangleBorder(borderRadius: radius(30)),
                      margin:const EdgeInsets.fromLTRB(200, 16, 100, 20),
                      duration: 3.seconds,
                    );
                  },
                  leading: Icon(Icons.arrow_forward_ios, size: 15, color: Theme.of(context).lightTextColor),
                  title: Text('Payments', style: TextStyle(color: Theme.of(context).lightTextColor),),
                ),
                ListTile(
                  contentPadding:const EdgeInsets.symmetric(vertical: 0, horizontal: 20) ,
                  dense: true,
                  horizontalTitleGap: 2.0,
                  onTap: (){
                    snackBar(
                      context,
                      title: 'Access denied...Please contact system Admin : sysadmin@gecss-ke.com',
                      textColor: Colors.white,
                      backgroundColor: Colors.red,
                      elevation: 8,
                      //shape: RoundedRectangleBorder(borderRadius: radius(30)),
                      margin:const EdgeInsets.fromLTRB(200, 16, 100, 20),
                      duration: 3.seconds,
                    );
                  },
                  leading: Icon(Icons.arrow_forward_ios, size: 15, color: Theme.of(context).lightTextColor),
                  title: Text('Offers', style: TextStyle(color: Theme.of(context).lightTextColor),),
                ),
                ListTile(
                  contentPadding:const EdgeInsets.symmetric(vertical: 0, horizontal: 20) ,
                  dense: true,
                  horizontalTitleGap: 2.0,
                  onTap: (){
                    snackBar(
                      context,
                      title: 'Access denied...Please contact system Admin : sysadmin@gecss-ke.com',
                      textColor: Colors.white,
                      backgroundColor: Colors.red,
                      elevation: 8,
                      //shape: RoundedRectangleBorder(borderRadius: radius(30)),
                      margin:const EdgeInsets.fromLTRB(200, 16, 100, 20),
                      duration: 3.seconds,
                    );
                  },
                  leading: Icon(Icons.arrow_forward_ios, size: 15, color: Theme.of(context).lightTextColor),
                  title: Text('Complains', style: TextStyle(color: Theme.of(context).lightTextColor),),
                ),
                ListTile(
                  contentPadding:const EdgeInsets.symmetric(vertical: 0, horizontal: 20) ,
                  dense: true,
                  horizontalTitleGap: 2.0,
                  onTap: (){
                    snackBar(
                      context,
                      title: 'Access denied...Please contact system Admin : sysadmin@gecss-ke.com',
                      textColor: Colors.white,
                      backgroundColor: Colors.red,
                      elevation: 8,
                      //shape: RoundedRectangleBorder(borderRadius: radius(30)),
                      margin:const EdgeInsets.fromLTRB(200, 16, 100, 20),
                      duration: 3.seconds,
                    );
                  },
                  leading: Icon(Icons.arrow_forward_ios, size: 15, color: Theme.of(context).lightTextColor),
                  title: Text('Reports', style: TextStyle(color: Theme.of(context).lightTextColor),),
                ),
                
          
              ],
              ),
          
            ListTile(
              onTap: (){
                snackBar(
                context,
                title: 'Notice!!!!... This feauture is under-development contact system Admin for more info : sysadmin@gecss-ke.com',
                textColor: Colors.white,
                backgroundColor: Colors.blue,
                elevation: 8,
                //shape: RoundedRectangleBorder(borderRadius: radius(30)),
                margin:const EdgeInsets.fromLTRB(200, 16, 100, 20),
                duration: 3.seconds,
              );
              },
              dense:true,
              minLeadingWidth : 8,
              leading: FaIcon(FontAwesomeIcons.sitemap, size: 18, color: Theme.of(context).iconsColors),
              title: Text(
                "IAM",
                style: TextStyle(color: Theme.of(context).lightTextColor),
                ),
            ),
          
            ListTile(
              onTap: (){
                snackBar(
                context,
                title: 'Notice!!!!... This feauture is under-development contact system Admin for more info : sysadmin@gecss-ke.com',
                textColor: Colors.white,
                backgroundColor: Colors.blue,
                elevation: 8,
                //shape: RoundedRectangleBorder(borderRadius: radius(30)),
                margin:const EdgeInsets.fromLTRB(200, 16, 100, 20),
                duration: 3.seconds,
              );
              },
              dense:true,
              minLeadingWidth : 8,
              leading: FaIcon(FontAwesomeIcons.peopleRoof , size: 18, color: Theme.of(context).iconsColors),
              title: Text(
                "HR Portal",
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
                    if(staffrole !='Agent'){
                      Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => const DeskBatteryDashboard(),
                      ));
                    } else{
                      snackBar(
                        context,
                        title: 'Access denied...Please contact system Admin : sysadmin@gecss-ke.com',
                        textColor: Colors.white,
                        backgroundColor: Colors.red,
                        elevation: 8,
                        //shape: RoundedRectangleBorder(borderRadius: radius(30)),
                        margin:const EdgeInsets.fromLTRB(200, 16, 100, 20),
                        duration: 3.seconds,
                      );
                    }
                    
                   },
                  leading: Icon(Icons.arrow_forward_ios, size: 15, color: Theme.of(context).lightTextColor),
                  title: Text('Batteries', style: TextStyle(color: Theme.of(context).lightTextColor),),
                ),
              ],
            ),
          
            ExpansionTile(
              title: Text("E-Bikes", style: TextStyle(color: Theme.of(context).lightTextColor),),
              leading: FaIcon(FontAwesomeIcons.motorcycle , size: 18, color: Theme.of(context).iconsColors),
              // childrenPadding:const EdgeInsets.only(left: 20),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding:const EdgeInsets.symmetric(vertical: 0, horizontal: 20) ,
                  dense: true,
                  horizontalTitleGap: 2.0,
                  onTap: (){
                    if(staffrole !='Agent'){
                      Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => const DeskEbikeDashboard(),
                      ));
                    } else{
                      snackBar(
                        context,
                        title: 'Access denied...Please contact system Admin : sysadmin@gecss-ke.com',
                        textColor: Colors.white,
                        backgroundColor: Colors.red,
                        elevation: 8,
                        //shape: RoundedRectangleBorder(borderRadius: radius(30)),
                        margin:const EdgeInsets.fromLTRB(200, 16, 100, 20),
                        duration: 3.seconds,
                      );
                    }

                   },
                  leading: Icon(Icons.arrow_forward_ios, size: 15, color: Theme.of(context).lightTextColor),
                  title: Text('New', style: TextStyle(color: Theme.of(context).lightTextColor),),
                ),
                ListTile(
                  contentPadding:const EdgeInsets.symmetric(vertical: 0, horizontal: 20) ,
                  dense: true,
                  horizontalTitleGap: 2.0,
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => const DeskRetrofittedDashboard(),
                      ));
                   },
                  leading: Icon(Icons.arrow_forward_ios, size: 15, color: Theme.of(context).lightTextColor),
                  title: Text('Retrofitted', style: TextStyle(color: Theme.of(context).lightTextColor),),
                ),
              ],
            ),
          
            ExpansionTile(
              title: Text("Reports", style: TextStyle(color: Theme.of(context).lightTextColor),),
              leading: FaIcon(FontAwesomeIcons.chartColumn , size: 18, color: Theme.of(context).iconsColors),
              // childrenPadding:const EdgeInsets.only(left: 20),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding:const EdgeInsets.symmetric(vertical: 0, horizontal: 20) ,
                  dense: true,
                  horizontalTitleGap: 2.0,
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => const ReportMpesaDashboard(),
                      ));
                   },
                  leading: Icon(Icons.arrow_forward_ios, size: 15, color: Theme.of(context).lightTextColor),
                  title: Text('Mobile Money', style: TextStyle(color: Theme.of(context).lightTextColor),),
                ),
                ListTile(
                  contentPadding:const EdgeInsets.symmetric(vertical: 0, horizontal: 20) ,
                  dense: true,
                  horizontalTitleGap: 2.0,
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => const ReportBatterySwapDashboard(),
                      ));
                   },
                  leading: Icon(Icons.arrow_forward_ios, size: 15, color: Theme.of(context).lightTextColor),
                  title: Text('Battery Swaps', style: TextStyle(color: Theme.of(context).lightTextColor),),
                ),
              ],
            ),
          
          
            ListTile(
              onTap: (){
                snackBar(
                context,
                title: 'Notice!!!!... This feauture is under-development contact system Admin for more info : sysadmin@gecss-ke.com',
                textColor: Colors.white,
                backgroundColor: Colors.blue,
                elevation: 8,
                //shape: RoundedRectangleBorder(borderRadius: radius(30)),
                margin:const EdgeInsets.fromLTRB(200, 16, 100, 20),
                duration: 3.seconds,
              );
              },
              dense:true,
              minLeadingWidth : 8,
              leading: FaIcon(FontAwesomeIcons.mapLocationDot , size: 18, color: Theme.of(context).iconsColors),
              title: Text(
                "GPS & Maps",
                style: TextStyle(color: Theme.of(context).lightTextColor),
                ),
            ),
          
          
             ExpansionTile(
              title: Text("Settings", style: TextStyle(color: Theme.of(context).lightTextColor),),
              leading: FaIcon(FontAwesomeIcons.gears , size: 18, color: Theme.of(context).iconsColors),
              // childrenPadding:const EdgeInsets.only(left: 20),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding:const EdgeInsets.symmetric(vertical: 0, horizontal: 20) ,
                  dense: true,
                  horizontalTitleGap: 2.0,
                  onTap: (){
                    snackBar(
                        context,
                        title: 'Access denied...Please contact system Admin : sysadmin@gecss-ke.com',
                        textColor: Colors.white,
                        backgroundColor: Colors.red,
                        elevation: 8,
                        //shape: RoundedRectangleBorder(borderRadius: radius(30)),
                        margin:const EdgeInsets.fromLTRB(200, 16, 100, 20),
                        duration: 3.seconds,
                      );
                   },
                  leading: Icon(Icons.arrow_forward_ios, size: 15, color: Theme.of(context).lightTextColor),
                  title: Text('Reinstall to default', style: TextStyle(color: Theme.of(context).lightTextColor),),
                ),
                ListTile(
                  contentPadding:const EdgeInsets.symmetric(vertical: 0, horizontal: 20) ,
                  dense: true,
                  horizontalTitleGap: 2.0,
                  onTap: (){
                    snackBar(
                        context,
                        title: 'Access denied...Please contact system Admin : sysadmin@gecss-ke.com',
                        textColor: Colors.white,
                        backgroundColor: Colors.red,
                        elevation: 8,
                        //shape: RoundedRectangleBorder(borderRadius: radius(30)),
                        margin:const EdgeInsets.fromLTRB(200, 16, 100, 20),
                        duration: 3.seconds,
                      );
                   },
                  leading: Icon(Icons.arrow_forward_ios, size: 15, color: Theme.of(context).lightTextColor),
                  title: Text('Factory Reset', style: TextStyle(color: Theme.of(context).lightTextColor),),
                ),
                ListTile(
                  contentPadding:const EdgeInsets.symmetric(vertical: 0, horizontal: 20) ,
                  dense: true,
                  horizontalTitleGap: 2.0,
                  onTap: (){
                    snackBar(
                        context,
                        title: 'Access denied...Please contact system Admin : sysadmin@gecss-ke.com',
                        textColor: Colors.white,
                        backgroundColor: Colors.red,
                        elevation: 8,
                        //shape: RoundedRectangleBorder(borderRadius: radius(30)),
                        margin:const EdgeInsets.fromLTRB(200, 16, 100, 20),
                        duration: 3.seconds,
                      );
                   },
                  leading: Icon(Icons.arrow_forward_ios, size: 15, color: Theme.of(context).lightTextColor),
                  title: Text('Networks Radius', style: TextStyle(color: Theme.of(context).lightTextColor),),
                ),
                ListTile(
                  contentPadding:const EdgeInsets.symmetric(vertical: 0, horizontal: 20) ,
                  dense: true,
                  horizontalTitleGap: 2.0,
                  onTap: (){
                    snackBar(
                        context,
                        title: 'Access denied...Please contact system Admin : sysadmin@gecss-ke.com',
                        textColor: Colors.white,
                        backgroundColor: Colors.red,
                        elevation: 8,
                        //shape: RoundedRectangleBorder(borderRadius: radius(30)),
                        margin:const EdgeInsets.fromLTRB(200, 16, 100, 20),
                        duration: 3.seconds,
                      );
                   },
                  leading: Icon(Icons.arrow_forward_ios, size: 15, color: Theme.of(context).lightTextColor),
                  title: Text('System Themes', style: TextStyle(color: Theme.of(context).lightTextColor),),
                ),
                ListTile(
                  contentPadding:const EdgeInsets.symmetric(vertical: 0, horizontal: 20) ,
                  dense: true,
                  horizontalTitleGap: 2.0,
                  onTap: (){
                    snackBar(
                        context,
                        title: 'Access denied...Please contact system Admin : sysadmin@gecss-ke.com',
                        textColor: Colors.white,
                        backgroundColor: Colors.red,
                        elevation: 8,
                        //shape: RoundedRectangleBorder(borderRadius: radius(30)),
                        margin:const EdgeInsets.fromLTRB(200, 16, 100, 20),
                        duration: 3.seconds,
                      );
                   },
                  leading: Icon(Icons.arrow_forward_ios, size: 15, color: Theme.of(context).lightTextColor),
                  title: Text('Advanced features', style: TextStyle(color: Theme.of(context).lightTextColor),),
                ),
              ],
            ),
          
          
            ExpansionTile(
              title: Text("Sec & GM", style: TextStyle(color: Theme.of(context).lightTextColor),),
              leading: FaIcon(FontAwesomeIcons.skullCrossbones , size: 18, color: Theme.of(context).iconsColors),
              // childrenPadding:const EdgeInsets.only(left: 20),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding:const EdgeInsets.symmetric(vertical: 0, horizontal: 20) ,
                  dense: true,
                  horizontalTitleGap: 2.0,
                  onTap: (){
                    snackBar(
                        context,
                        title: 'Access denied...Please contact system Admin : sysadmin@gecss-ke.com',
                        textColor: Colors.white,
                        backgroundColor: Colors.red,
                        elevation: 8,
                        //shape: RoundedRectangleBorder(borderRadius: radius(30)),
                        margin:const EdgeInsets.fromLTRB(200, 16, 100, 20),
                        duration: 3.seconds,
                      );
                   },
                  leading: Icon(Icons.arrow_forward_ios, size: 15, color: Theme.of(context).lightTextColor),
                  title: Text('Safety & security', style: TextStyle(color: Theme.of(context).lightTextColor),),
                ),
                ListTile(
                  contentPadding:const EdgeInsets.symmetric(vertical: 0, horizontal: 20) ,
                  dense: true,
                  horizontalTitleGap: 2.0,
                  onTap: (){
                    snackBar(
                        context,
                        title: 'Access denied...Please contact system Admin : sysadmin@gecss-ke.com',
                        textColor: Colors.white,
                        backgroundColor: Colors.red,
                        elevation: 8,
                        //shape: RoundedRectangleBorder(borderRadius: radius(30)),
                        margin:const EdgeInsets.fromLTRB(200, 16, 100, 20),
                        duration: 3.seconds,
                      );
                   },
                  leading: Icon(Icons.arrow_forward_ios, size: 15, color: Theme.of(context).lightTextColor),
                  title: Text('Restore point', style: TextStyle(color: Theme.of(context).lightTextColor),),
                ),
                ListTile(
                  contentPadding:const EdgeInsets.symmetric(vertical: 0, horizontal: 20) ,
                  dense: true,
                  horizontalTitleGap: 2.0,
                  onTap: (){
                    snackBar(
                        context,
                        title: 'Access denied...Please contact system Admin : sysadmin@gecss-ke.com',
                        textColor: Colors.white,
                        backgroundColor: Colors.red,
                        elevation: 8,
                        //shape: RoundedRectangleBorder(borderRadius: radius(30)),
                        margin:const EdgeInsets.fromLTRB(200, 16, 100, 20),
                        duration: 3.seconds,
                      );
                   },
                  leading: Icon(Icons.arrow_forward_ios, size: 15, color: Theme.of(context).lightTextColor),
                  title: Text('Back-Ups', style: TextStyle(color: Theme.of(context).lightTextColor),),
                ),
                ListTile(
                  contentPadding:const EdgeInsets.symmetric(vertical: 0, horizontal: 20) ,
                  dense: true,
                  horizontalTitleGap: 2.0,
                  onTap: (){
                    snackBar(
                        context,
                        title: 'Access denied...Please contact system Admin : sysadmin@gecss-ke.com',
                        textColor: Colors.white,
                        backgroundColor: Colors.red,
                        elevation: 8,
                        //shape: RoundedRectangleBorder(borderRadius: radius(30)),
                        margin:const EdgeInsets.fromLTRB(200, 16, 100, 20),
                        duration: 3.seconds,
                      );
                   },
                  leading: Icon(Icons.arrow_forward_ios, size: 15, color: Theme.of(context).lightTextColor),
                  title: Text('System lock', style: TextStyle(color: Theme.of(context).lightTextColor),),
                ),
                ListTile(
                  contentPadding:const EdgeInsets.symmetric(vertical: 0, horizontal: 20) ,
                  dense: true,
                  horizontalTitleGap: 2.0,
                  onTap: (){
                    snackBar(
                        context,
                        title: 'Access denied...Please contact system Admin : sysadmin@gecss-ke.com',
                        textColor: Colors.white,
                        backgroundColor: Colors.red,
                        elevation: 8,
                        //shape: RoundedRectangleBorder(borderRadius: radius(30)),
                        margin:const EdgeInsets.fromLTRB(200, 16, 100, 20),
                        duration: 3.seconds,
                      );
                   },
                  leading: Icon(Icons.arrow_forward_ios, size: 15, color: Theme.of(context).lightTextColor),
                  title: Text('Recycle bin', style: TextStyle(color: Theme.of(context).lightTextColor),),
                ),
              ],
            ),
          
            ListTile(
              onTap: (){
                snackBar(
                context,
                title: 'Access denied...Please contact system Admin : sysadmin@gecss-ke.com',
                textColor: Colors.white,
                backgroundColor: Colors.red,
                elevation: 8,
                //shape: RoundedRectangleBorder(borderRadius: radius(30)),
                margin:const EdgeInsets.fromLTRB(200, 16, 100, 20),
                duration: 3.seconds,
              );
              },
              dense:true,
              minLeadingWidth : 8,
              leading: FaIcon(FontAwesomeIcons.recycle , size: 18, color: Theme.of(context).iconsColors),
              title: Text(
                "Recycle Bin",
                style: TextStyle(color: Theme.of(context).lightTextColor),
                ),
            ),
          
            
          
          ],),
        ],
      ),
    );
  }
}