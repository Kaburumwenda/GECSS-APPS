import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gecssmns/Apis/base_url.dart';
import 'package:gecssmns/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class ThisMonthPieChart extends StatefulWidget {
  const ThisMonthPieChart({Key? key}) : super(key: key);

  @override
  State<ThisMonthPieChart> createState() => _ThisMonthPieChartState();
}

class _ThisMonthPieChartState extends State<ThisMonthPieChart> {
  LocalStorage storage = LocalStorage('usertoken');
  List<Map<String, dynamic>> apiData = [];
  TooltipBehavior? _tooltipBehavior;
  bool _isLoading = false;

  int swaps = 0;
  int mileage = 0;
  int carbon = 0;
  int revenue = 0;
  int units = 0;


  @override
  void initState() {
    super.initState();
    fetchData();
    _tooltipBehavior = TooltipBehavior(enable: true);
  }

   Future<void> fetchData() async {
    var baseur = AdsType.baseurl;
    var token = storage.getItem('token');
    String url = '$baseur/v1/reports/overall_statistics_totals_month';
    setState(() {
      _isLoading = true;
    });
    final response = await http.get(Uri.parse(url),
            headers: {
              "Content-Type": "application/json",
              'Authorization': "token $token"
            },);
    
    var data = json.decode(response.body) as List;

    if (response.statusCode == 200) {
      setState(() {
        apiData = List<Map<String, dynamic>>.from(json.decode(response.body));
        _isLoading = false;
        swaps = data[0]['Swaps'];
        mileage = data[0]['Mileage'];
        carbon = data[0]['Carbon'];
        revenue = data[0]['Revenue'];
        units = data[0]['Units'];
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load data');
    }
  }

  List<_ChartData> processData() {
  List<_ChartData> data = [];
  if (apiData.isNotEmpty) {
    apiData[0].forEach((key, value) {
      data.add(_ChartData(key, value));
    });
  }
  return data;
}

  @override
  Widget build(BuildContext context) {

    final formatter = NumberFormat('#,###', 'en_US');

    return Container(
      child: _isLoading
          ? Container(
            color: Theme.of(context).secondaryBackground,
            child: Center(
              child: LoadingBouncingGrid.square(
                borderSize: 0.0,
                backgroundColor: Theme.of(context).loadingColors,
              )
              ),
          )
          : Container(
            color: Theme.of(context).secondaryBackground,
            child: Row(
              children: [
                Expanded(
                  child: SfCircularChart(
                    tooltipBehavior:  _tooltipBehavior,
                    title: ChartTitle(text: 'This Month Overall Analysis', textStyle: GoogleFonts.teko()),
                    legend: const Legend(isVisible: true, overflowMode:LegendItemOverflowMode.wrap, position:LegendPosition.bottom  ),
                      series: <CircularSeries>[
                        RadialBarSeries<_ChartData, String>(
                          dataSource: processData(),
                          xValueMapper: (_ChartData data, _) => data.label,
                          yValueMapper: (_ChartData data, _) => data.value,
                          dataLabelSettings: const DataLabelSettings(isVisible: true),
                          enableTooltip: true,
                        )
                      ],
                    ),
                ),
                // TOTALS CONTAINER **********************START**********************
                Container(
                  width: 110,
                  //color: Colors.red,
                  padding:const EdgeInsets.all(2),
                  child: Column(children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          FaIcon(FontAwesomeIcons.cashRegister, size: 18, color: Theme.of(context).iconsColors, ),
                          const SizedBox(width: 10,),
                          const Text('Revenue')
                        ],),
                        Text('Ksh ${formatter.format(revenue)}', style: GoogleFonts.teko(textStyle: TextStyle(
                        color: const Color(0xFF1ccaa7).withOpacity(0.6),
                        fontSize: 20
                      )) ),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          FaIcon(FontAwesomeIcons.rightLeft, size: 18, color: Theme.of(context).iconsColors, ),
                          const SizedBox(width: 10,),
                          const Text('No. Swaps')
                        ],),
                        Text(formatter.format(swaps), style: GoogleFonts.teko(textStyle: TextStyle(
                        color: const Color(0xFF1ccaa7).withOpacity(0.6),
                        fontSize: 20
                      )) ),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          FaIcon(FontAwesomeIcons.plugCircleBolt , size: 18, color: Theme.of(context).iconsColors, ),
                          const SizedBox(width: 10,),
                          const Text('Power')
                        ],),
                        Text('${formatter.format(units)} Kw', style: GoogleFonts.teko(textStyle: TextStyle(
                        color: const Color(0xFF1ccaa7).withOpacity(0.6),
                        fontSize: 20
                      )) ),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          FaIcon(FontAwesomeIcons.peopleArrows , size: 18, color: Theme.of(context).iconsColors, ),
                          const SizedBox(width: 10,),
                          const Text('Mileage')
                        ],),
                        Text('${formatter.format(mileage)} KMs', style: GoogleFonts.teko(textStyle: TextStyle(
                        color: const Color(0xFF1ccaa7).withOpacity(0.6),
                        fontSize: 20
                      )) ),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          FaIcon(FontAwesomeIcons.smog, size: 18, color: Theme.of(context).iconsColors, ),
                          const SizedBox(width: 10,),
                          const Text('GHG')
                        ],),
                        Text('${formatter.format(carbon)} Kt', style: GoogleFonts.teko(textStyle: TextStyle(
                        color: const Color(0xFF1ccaa7).withOpacity(0.6),
                        fontSize: 20
                      )) ),
                      ],
                    ),

                  ],),
                )
                // TOTALS CONTAINER********************** END **********************
              ],
            ),
          ),
    );
  }
}

class _ChartData {
  _ChartData(this.label, this.value);
  final String label;
  final int value;
}
