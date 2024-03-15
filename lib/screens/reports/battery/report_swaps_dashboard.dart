import 'package:flutter/material.dart';
import 'package:gecssmns/main.dart';
import 'package:gecssmns/public/Desktop/sidebar.dart';
import 'package:gecssmns/screens/Finance/desktop/mpesa/mpesa_statistics.dart';
import 'package:gecssmns/screens/batteries/desktop/swaps/desk_swap_dashboard.dart';
import 'package:gecssmns/screens/reports/battery/battery_statistics.dart';
import 'package:gecssmns/screens/reports/battery/this_month_chart.dart';
import 'package:gecssmns/screens/reports/battery/this_week_chart.dart';
import 'package:gecssmns/screens/reports/battery/this_year_chart.dart';
import 'package:gecssmns/screens/reports/battery/yearly_chart.dart';
import 'package:nb_utils/nb_utils.dart';

class ReportBatterySwapDashboard extends StatefulWidget {
  const ReportBatterySwapDashboard({super.key});

  @override
  State<ReportBatterySwapDashboard> createState() => _ReportBatterySwapDashboardState();
}

class _ReportBatterySwapDashboardState extends State<ReportBatterySwapDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [
        Container(
          color: Theme.of(context).secondaryBackground,
          height: double.infinity,
          width: MediaQuery.of(context).size.width * .12,
          child:const DesktopSidebar(),
        ),
       
       Container(
        color: Theme.of(context).primaryBackground,
        height: double.infinity,
        width: MediaQuery.of(context).size.width * .88,
        child: Column(children: [
          // top nav start
          Container(
            padding:const EdgeInsets.fromLTRB(10, 10, 10, 20),
            color: Theme.of(context).secondaryBackground,
            child: Row(children: [
              const Text("BATTERY SWAPS"),
              const Spacer(),
              TextButton.icon(
                onPressed: (){
                  snackBar(
                    context,
                    title: 'Access denied...Please contact system Admin sysadmin@gecss-ke.com',
                    textColor: Colors.white,
                    backgroundColor: Colors.red,
                    elevation: 8,
                    //shape: RoundedRectangleBorder(borderRadius: radius(30)),
                    margin:const EdgeInsets.fromLTRB(200, 16, 100, 20),
                    duration: 3.seconds,
                  );
                }, 
                icon:const Icon(Icons.picture_as_pdf), 
                label: const Text('Pdf'),
                style: ButtonStyle(  
                  side: MaterialStateProperty.all(BorderSide(
                    color: Theme.of(context).btnBackground, // Set the desired border color
                    width: 1.0, // Set the desired border width
                  )),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0), // Set the desired border radius
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).secondaryBackground,
                    )
                ),
                ),
              const SizedBox(width: 20,),
              TextButton.icon(
                onPressed: (){
                  snackBar(
                    context,
                    title: 'Access denied...Please contact system Admin sysadmin@gecss-ke.com',
                    textColor: Colors.white,
                    backgroundColor: Colors.red,
                    elevation: 8,
                    //shape: RoundedRectangleBorder(borderRadius: radius(30)),
                    margin:const EdgeInsets.fromLTRB(200, 16, 100, 20),
                    duration: 3.seconds,
                  );
                }, 
                icon:const Icon(Icons.cloud_download_outlined), 
                label: const Text('Excel'),
                style: ButtonStyle(  
                  side: MaterialStateProperty.all(BorderSide(
                    color: Theme.of(context).btnBackground, // Set the desired border color
                    width: 1.0, // Set the desired border width
                  )),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0), // Set the desired border radius
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).secondaryBackground,
                    )
                ),
                ),
              
              const SizedBox(width: 20,),
              TextButton.icon(
                onPressed: (){
                  const DeskBatterySwapDashboard().launch(context);
                }, 
                icon:const Icon(Icons.panorama_fish_eye), 
                label: const Text('Battery swaps records'),
                style: ButtonStyle(  
                  side: MaterialStateProperty.all(BorderSide(
                    color: Theme.of(context).btnBackground, // Set the desired border color
                    width: 1.0, // Set the desired border width
                  )),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0), // Set the desired border radius
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).secondaryBackground,
                    )
                ),
                ),

            ],),
          ),
          //top nav end

          // statistics start
          Container(
            color: Theme.of(context).secondaryBackground,
            child: const BatteryStatistics() //DeskMpesaStatistics()
            ),
          // staticts end

          const SizedBox(height: 10,),

          // ##################################### mobile body content start
          Expanded(child: Container(
            margin:const EdgeInsets.only(left: 10.0, right: 10.0),
            child: ListView(children:const [
              Row(children: [
                Expanded(
                  flex: 2,
                  child: ThisWeekChart()),
                  SizedBox(width: 20,),
                Expanded(
                  flex: 4,
                  child: ThisMonthChart()),
              ],),
              SizedBox(height: 20,),
              Row(children: [
                Expanded(
                  flex: 3,
                  child: ThisYearChart()),
                  SizedBox(width: 20,),
                Expanded(
                  flex: 3,
                  child: ThisYearlyChart()),
              ],),
            ]),
          ))
          // ##################################### mobile body content end


        ],),
       )

      ]),
    );
  }
}