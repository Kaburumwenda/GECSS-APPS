import 'package:flutter/material.dart';
import 'package:gecssmns/main.dart';
import 'package:gecssmns/public/Desktop/sidebar.dart';
import 'package:gecssmns/public/Desktop/topnavbar.dart';
import 'package:gecssmns/screens/home/desktop/battery_swaps.dart';
import 'package:gecssmns/screens/home/desktop/mpesa_transactions.dart';
import 'package:gecssmns/screens/home/desktop/overall_piechart.dart';
import 'package:gecssmns/screens/home/desktop/this_month_piechart.dart';
import 'package:gecssmns/screens/home/desktop/this_month_areachart.dart';
import 'package:gecssmns/screens/home/desktop/statistics_card.dart';
import 'package:gecssmns/screens/home/desktop/this_month_linechart.dart';
import 'package:gecssmns/screens/home/desktop/this_year_areachart.dart';
import 'package:gecssmns/screens/home/desktop/this_year_columnchart.dart';
import 'package:gecssmns/screens/home/desktop/this_year_piechart.dart';

class DesktopDashboard extends StatefulWidget {
  const DesktopDashboard({super.key});

  @override
  State<DesktopDashboard> createState() => _DesktopDashboardState();
}

class _DesktopDashboardState extends State<DesktopDashboard> {

//  double SidebarWidth = MediaQuery.of(context).size.width * .30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryBackground,
      body: Row(
        children: [
          SizedBox(
            //color: Theme.of(context).secondaryBackground,
            height: double.infinity,
            width: MediaQuery.of(context).size.width * .12,
            child:const DesktopSidebar(),
          ),

          SizedBox(
            //color: Theme.of(context).secondaryBackground,
            height: double.infinity,
            width: MediaQuery.of(context).size.width * .88,
            child: Column(
              children: [
                
                const DesktopTopNav(),

                const StatisticsCard(),

                Expanded(
                  child: Container(
                    margin:const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: ListView(
                    children:const [

                     Row(children: [
                      Expanded(
                        flex: 3,
                        child: ThisMonthAreaChart()),
                        SizedBox(width: 20,),
                      Expanded(
                        flex: 3,
                        child: ThisYearAreaChart()),
                    ],),
                    SizedBox(height: 20,),

                    Row(children: [
                      Expanded(
                        flex: 3,
                        child: ThisMonthLineChart()),
                        SizedBox(width: 20,),
                      Expanded(
                        flex: 3,
                        child: ThisYearColumnChart()),
                    ],),
                    SizedBox(height: 20,),

                    Row(children: [
                      Expanded(
                        flex: 2,
                        child: ThisMonthPieChart()),
                        SizedBox(width: 10,),
                      Expanded(
                        flex: 2,
                        child: ThisYearPieChart()),
                        SizedBox(width: 10,),
                      Expanded(
                        flex: 2,
                        child: OverallPieChart()),

                    ],),
                    SizedBox(height: 20,),


                    Row(children: [
                      Expanded(
                        flex: 3,
                        child: DeskMpesaTransactions()),
                        SizedBox(width: 10,),
                      Expanded(
                        flex: 3,
                        child: DeskBatterySwaps()),
                    ],),

                    SizedBox(height: 40,),

                   ]),
                ))

              ],
            ),
          ),
        ]
        ,),
    );
  }
}