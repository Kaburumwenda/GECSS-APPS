// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gecssmns/Apis/base_url.dart';
import 'package:gecssmns/widgets/statistics_totals_card.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class BatteryStatistics extends StatefulWidget {
  const BatteryStatistics({Key? key}) : super(key: key);

  @override
  State<BatteryStatistics> createState() => _BatteryStatisticsState();
}

class _BatteryStatisticsState extends State<BatteryStatistics> {
  LocalStorage storage = LocalStorage('usertoken');

  bool _cardLoading = true;

  int today = 0;
  int week = 0;
  int month = 0;
  int year = 0;
  int totals = 0;

    @override
  void initState() {
    super.initState();
    _fetchData();
  }

   _fetchData() async {
    var baseur = AdsType.baseurl;
    setState(() {
       _cardLoading = true;
    });
    String url = '$baseur/v1/reports/battery_statistics/counts';
    var token = storage.getItem('token');

    final response = await http.get(Uri.parse(url),
            headers: {
              "Content-Type": "application/json",
              'Authorization': "token $token",
            },);

    if (response.statusCode == 200) {
      setState(() {
         _cardLoading = false;
      });
      var data = json.decode(response.body);
      setState(() {
        today = data['today'];
        week = data['week'];
        year = data['year'];
        month = data['month'];
        totals = data['total'];
      });
    } else {
      setState(() {
         _cardLoading = false;
      });
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 80,
      margin: const EdgeInsets.only(bottom: 10, top: 10, left: 10.0, right: 10.0),
      child: _cardLoading 
      ? const Center(child: CircularProgressIndicator(),)
      :GridView.count(
        crossAxisCount: 4,
        crossAxisSpacing: 20,
        physics: const NeverScrollableScrollPhysics(),
        //scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [

          StatisticTotalsCard(
            title: 'Today Swaps: ', 
            totals: today, 
            iconColor:const Color(0xFF2697FF), 
            iconColorbg:const Color(0xFF2697FF).withOpacity(0.2), 
            iconType: FontAwesomeIcons.chargingStation
            ),
          
          StatisticTotalsCard(
            title: 'This week swaps:  ', 
            totals: week, 
            iconColor:const Color(0xFFFFA113), 
            iconColorbg:const Color(0xFFFFA113).withOpacity(0.2), 
            iconType: FontAwesomeIcons.chargingStation
            ),

          StatisticTotalsCard(
            title: 'This month swaps', 
            totals: month, 
            iconColor:const Color(0xFF2697FF), 
            iconColorbg:const Color(0xFF2697FF).withOpacity(0.2), 
            iconType: FontAwesomeIcons.chargingStation
            ),

          StatisticTotalsCard(
            title: 'This Year swaps', 
            totals: year, 
            iconColor:const Color(0xFFEC7063), 
            iconColorbg:const Color(0xFFEC7063).withOpacity(0.2), 
            iconType: FontAwesomeIcons.chargingStation
            ),

        ],
        )
    );
  }
}
