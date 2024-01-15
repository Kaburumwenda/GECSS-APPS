// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gecssmns/Apis/base_url.dart';
import 'package:gecssmns/widgets/statistics_totals_card.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class DeskMpesaStatistics extends StatefulWidget {
  const DeskMpesaStatistics({Key? key}) : super(key: key);

  @override
  State<DeskMpesaStatistics> createState() => _DeskMpesaStatisticsState();
}

class _DeskMpesaStatisticsState extends State<DeskMpesaStatistics> {
  LocalStorage storage = LocalStorage('usertoken');

  bool _cardLoading = true;

  double earnings = 0;
  int batteries = 0;
  int bikes = 0;
  int staff = 0;

  int today = 0;
  int thisweek = 0;
  int thismonth = 0;
  int thisyear = 0;
  int totals = 0;

    @override
  void initState() {
    super.initState();
    _fetchData();
  }

   _fetchData() async {
    var baseur = AdsType.baseurl;
    var token = storage.getItem('token');
    setState(() {
       _cardLoading = true;
    });
    String url = '$baseur/v1/mpesa/office/stat';
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
        today = data['today'].toInt();
        thisweek = data['week'].toInt();
        thismonth = data['month'].toInt();
        thisyear = data['year'].toInt();
        totals = data['total'].toInt();
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
        crossAxisCount: 5,
        crossAxisSpacing: 20,
        physics: const NeverScrollableScrollPhysics(),
        //scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [

          StatisticTotalsCard(
            title: 'Today: ', 
            totals: today, 
            iconColor:const Color(0xFF2697FF), 
            iconColorbg:const Color(0xFF2697FF).withOpacity(0.2), 
            iconType: FontAwesomeIcons.moneyBillTrendUp
            ),
          
          StatisticTotalsCard(
            title: 'This Week:  ', 
            totals: thisweek, 
            iconColor:const Color(0xFFFFA113), 
            iconColorbg:const Color(0xFFFFA113).withOpacity(0.2), 
            iconType: FontAwesomeIcons.moneyBillTrendUp
            ),

          StatisticTotalsCard(
            title: 'This Month: ', 
            totals: thismonth, 
            iconColor:const Color(0xFF2697FF), 
            iconColorbg:const Color(0xFF2697FF).withOpacity(0.2), 
            iconType: FontAwesomeIcons.moneyBillTrendUp
            ),

            StatisticTotalsCard(
            title: 'This Year: ', 
            totals: thisyear, 
            iconColor:const Color(0xFF2697FF), 
            iconColorbg:const Color(0xFF2697FF).withOpacity(0.2), 
            iconType: FontAwesomeIcons.moneyBillTrendUp
            ),

          StatisticTotalsCard(
            title: 'Totals', 
            totals: totals, 
            iconColor:const Color(0xFFEC7063), 
            iconColorbg:const Color(0xFFEC7063).withOpacity(0.2), 
            iconType: FontAwesomeIcons.moneyBillTrendUp
            ),

        ],
        )
    );
  }
}
