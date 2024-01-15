import 'package:flutter/material.dart';
import 'package:gecssmns/main.dart';
import 'package:gecssmns/public/mobile/mobile_appbar.dart';
import 'package:gecssmns/public/mobile/mobile_sidebar.dart';
import 'package:gecssmns/screens/home/desktop/overall_piechart.dart';
import 'package:gecssmns/screens/home/desktop/this_month_areachart.dart';
import 'package:gecssmns/screens/home/desktop/this_month_linechart.dart';
import 'package:gecssmns/screens/home/desktop/this_month_piechart.dart';
import 'package:gecssmns/screens/home/desktop/this_year_areachart.dart';
import 'package:gecssmns/screens/home/desktop/this_year_columnchart.dart';
import 'package:gecssmns/screens/home/desktop/this_year_piechart.dart';
import 'package:gecssmns/screens/home/mobile/battery_swaps.dart';
import 'package:gecssmns/screens/home/mobile/mpesa_transactions.dart';
import 'package:gecssmns/screens/home/mobile/statistics_card.dart';

class MobileDashboard extends StatelessWidget {
  const MobileDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryBackground,

      drawer:const MobileSidebar(),

      body:SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [

            const MobileAppbar(),

            const StatisticsCard(),

            Expanded(child: 
            Container(
              margin:const EdgeInsets.only(left: 10.0, right: 10.0, top: 0.0),
              padding: EdgeInsets.zero,
              child:ListView(
                children: const [

                ThisMonthAreaChart(),
                SizedBox(height: 10,),

                ThisYearAreaChart(),
                SizedBox(height: 10,),

                ThisMonthLineChart(),
                SizedBox(height: 10,),

                ThisYearColumnChart(),
                SizedBox(height: 10,),

                ThisMonthPieChart(),
                SizedBox(height: 10,),

                ThisYearPieChart(),
                SizedBox(height: 10,),

                OverallPieChart(),
                SizedBox(height: 10,),

                MobileMpesaTransactions(),
                SizedBox(height: 10,),

                MobileBatterySwaps(),
                SizedBox(height: 10,),

              ],),
            ))

        ],),
      ),
    );
  }
}