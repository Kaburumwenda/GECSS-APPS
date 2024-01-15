// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gecssmns/Apis/base_url.dart';
import 'package:gecssmns/widgets/statistics_totals_card.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class StatisticsCard extends StatefulWidget {
  const StatisticsCard({Key? key}) : super(key: key);

  @override
  State<StatisticsCard> createState() => _StatisticsCardState();
}

class _StatisticsCardState extends State<StatisticsCard> {
  LocalStorage storage = LocalStorage('usertoken');

  bool _cardLoading = true;

  double earnings = 0;
  int batteries = 0;
  int bikes = 0;
  int staff = 0;

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
    String url = '$baseur/v1/statistics/totals';
    final response = await http.get(Uri.parse(url),
            headers: {
              "Content-Type": "application/json",
            },);

    if (response.statusCode == 200) {
      setState(() {
         _cardLoading = false;
      });
      var data = json.decode(response.body);
      setState(() {
        earnings = data['earnings'];
        batteries = data['batteries'];
        bikes = data['bikes'];
        staff = data['staff'];
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
      height: 200,
      padding:const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 0.0),
      //margin: const EdgeInsets.only(bottom: 10, top: 0),
      child: _cardLoading 
      ? const Center(child: CircularProgressIndicator(),)
      :GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        childAspectRatio: 2,
        crossAxisSpacing: 10,
        physics: const NeverScrollableScrollPhysics(),
        //scrollDirection: Axis.horizontal,
        //shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: [

          StatisticTotalsCard(
            title: 'Batteries: ', 
            totals: batteries, 
            iconColor:const Color(0xFF2697FF), 
            iconColorbg:const Color(0xFF2697FF).withOpacity(0.2), 
            iconType: FontAwesomeIcons.carBattery
            ),
          
          StatisticTotalsCard(
            title: 'Motorcycles:  ', 
            totals: bikes, 
            iconColor:const Color(0xFFFFA113), 
            iconColorbg:const Color(0xFFFFA113).withOpacity(0.2), 
            iconType: FontAwesomeIcons.motorcycle
            ),

          StatisticTotalsCard(
            title: 'Swap Stations ', 
            totals: staff, 
            iconColor:const Color(0xFF2697FF), 
            iconColorbg:const Color(0xFF2697FF).withOpacity(0.2), 
            iconType: FontAwesomeIcons.chargingStation
            ),

          StatisticTotalsCard(
            title: 'Earnings', 
            totals: earnings.toInt(), 
            iconColor:const Color(0xFFEC7063), 
            iconColorbg:const Color(0xFFEC7063).withOpacity(0.2), 
            iconType: FontAwesomeIcons.cashRegister
            ),

        ],
        )
    );
  }
}
