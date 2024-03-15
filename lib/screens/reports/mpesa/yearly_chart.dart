import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gecssmns/Apis/base_url.dart';
import 'package:gecssmns/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animations/loading_animations.dart';
import 'package:localstorage/localstorage.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class ThisYearlyChart extends StatefulWidget {
  const ThisYearlyChart({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ThisYearlyChartState createState() => _ThisYearlyChartState();
}

class _ThisYearlyChartState extends State<ThisYearlyChart> {
  LocalStorage storage = LocalStorage('usertoken');
  List<DataPoint> _dataPoints = [];
  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    super.initState();
    fetchDataFromApi();
    _tooltipBehavior = TooltipBehavior(enable: true);
  }

  void fetchDataFromApi() async {
    var baseur = AdsType.baseurl;
   var token = storage.getItem('token');
    String url = '$baseur/v1/reports/mpesa_statistics/yearly';
    try {
      final response = await http.get(Uri.parse(url),
            headers: {
              "Content-Type": "application/json",
              'Authorization': "token $token",
            },);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<DataPoint> dataPoints = List<DataPoint>.from(data.map((item) {
          return DataPoint(item['year'], item['total']);
        }));
        setState(() {
          _dataPoints = dataPoints;
        });
      } else {
       // print('Failed to fetch data from the API.');
      }
    } catch (e) {
      //print('Error: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).secondaryBackground,
      //padding: const EdgeInsets.all(5),
      child: _dataPoints.isNotEmpty
          ? SfCartesianChart(
            title: ChartTitle(text: 'Yearly Earning Analysis', textStyle: GoogleFonts.teko()),
            legend: const Legend(
              isVisible: true, position: LegendPosition.bottom ),
            zoomPanBehavior: ZoomPanBehavior(zoomMode: ZoomMode.xy),
            tooltipBehavior:  _tooltipBehavior,
              series: <ChartSeries>[
               
                AreaSeries<DataPoint, int>(
                  color: const Color(0xFFFFA113).withOpacity(0.2),
                  name: 'Area Analysis',
                  dataSource: _dataPoints,
                  xValueMapper: (DataPoint data, _) => data.date,
                  yValueMapper: (DataPoint data, _) => data.total,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  enableTooltip: true,
                  markerSettings: const MarkerSettings(isVisible: true),
                ),

                ColumnSeries<DataPoint, int>(
                  color:const Color(0xFF009999).withOpacity(0.2),
                  name: 'Bar Analysis',
                  dataSource: _dataPoints,
                  xValueMapper: (DataPoint data, _) => data.date,
                  yValueMapper: (DataPoint data, _) => data.total,
                  //dataLabelSettings: const DataLabelSettings(isVisible: true),
                  enableTooltip: true,
                  markerSettings: const MarkerSettings(isVisible: true),
                ),

                LineSeries<DataPoint, int>(
                  color:const Color(0xFF339966).withOpacity(0.2),
                  name: 'Line Analysis',
                  dataSource: _dataPoints,
                  xValueMapper: (DataPoint data, _) => data.date,
                  yValueMapper: (DataPoint data, _) => data.total,
                  //dataLabelSettings: const DataLabelSettings(isVisible: true),
                  enableTooltip: true,
                  markerSettings: const MarkerSettings(isVisible: true),
                ),
          
              ],
              primaryXAxis: NumericAxis(
                edgeLabelPlacement: EdgeLabelPlacement.shift, 
                title: AxisTitle(text: 'Years', textStyle: const TextStyle(color:Colors.green, fontSize: 14))),
              primaryYAxis: NumericAxis(
                numberFormat: NumberFormat.compactCurrency(decimalDigits: 0, symbol: "" ),
                // numberFormat: NumberFormat.compactSimpleCurrency(
                // decimalDigits: 0, locale: 'en_KE'), 
                labelFormat: '{value}', 
                title: AxisTitle(text: 'Amount Earned in - KES', textStyle: const TextStyle(color:Colors.green, fontSize: 14)) ),
            )

          : Container(
            color: Theme.of(context).secondaryBackground,
            child: Center(
              child: LoadingBouncingGrid.square(
                borderSize: 0.0,
                backgroundColor: Theme.of(context).loadingColors,
              )
              ),
          ),
    );
  }
}

class DataPoint {
  final int date;
  final double total;

  DataPoint(this.date, this.total);
}

