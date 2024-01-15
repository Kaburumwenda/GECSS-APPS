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

class ThisMonthLineChart extends StatefulWidget {
  const ThisMonthLineChart({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ThisMonthLineChartState createState() => _ThisMonthLineChartState();
}

class _ThisMonthLineChartState extends State<ThisMonthLineChart> {
  LocalStorage storage = LocalStorage('usertoken');
  List<DataPoint> _dataPoints = [];
  List<DataPoint> _ghgdataPoints = [];
  List<DataPoint> _swapdataPoints = [];
  List<DataPoint> _unitsdataPoints = [];
  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    super.initState();
    fetchDataFromApi();
    _tooltipBehavior = TooltipBehavior(enable: true);
  }

  final NumberFormat currencyFormat = NumberFormat.currency(
      symbol: "KE",
      decimalDigits: 2, // Number of decimal places
    );

  void fetchDataFromApi() async {
    var baseur = AdsType.baseurl;
    //var token = storage.getItem('token');
    String url = '$baseur/v1/reports/overall_statistics_month';
    try {
      final response = await http.get(Uri.parse(url),
            headers: {
              "Content-Type": "application/json"
            },);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        List<DataPoint> dataPoints = List<DataPoint>.from(data.map((item) {
          return DataPoint(item['day'], item['total'], item['ghg'], item['units'], item['swap'], //item['mileage']
          );
        }));

        List<DataPoint> ghgdataPoints = List<DataPoint>.from(data.map((item) {
          return DataPoint(item['day'], item['total'], item['ghg'], item['units'], item['swap'],// item['mileage']
          );
        }));

        List<DataPoint> swapdataPoints = List<DataPoint>.from(data.map((item) {
          return DataPoint(item['day'], item['total'], item['ghg'], item['units'], item['swap'], //item['mileage']
          );
        }));

        List<DataPoint> unitsdataPoints = List<DataPoint>.from(data.map((item) {
          return DataPoint(item['day'], item['total'], item['ghg'], item['units'], item['swap'], //item['mileage']
          );
        }));

        setState(() {
          _dataPoints = dataPoints;
          _ghgdataPoints = ghgdataPoints;
          _swapdataPoints = swapdataPoints;
          _unitsdataPoints = unitsdataPoints;
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
            title: ChartTitle(text: 'This Month (GHG, Power & Swaps ) Analysis', textStyle: GoogleFonts.teko()),
            legend: const Legend(
              isVisible: true, position: LegendPosition.bottom ),
            zoomPanBehavior: ZoomPanBehavior(zoomMode: ZoomMode.xy),
            tooltipBehavior:  _tooltipBehavior,
              series: <ChartSeries>[
               
                LineSeries<DataPoint, int>(
                  color:const Color.fromARGB(255, 255, 110, 19).withOpacity(0.4),
                  name: 'No. of Swaps',
                  dataSource: _swapdataPoints,
                  xValueMapper: (DataPoint data, _) => data.day,
                  yValueMapper: (DataPoint data, _) => data.swap,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  enableTooltip: true,
                  markerSettings: const MarkerSettings(isVisible: true),
                ),
                 LineSeries<DataPoint, int>(
                  color: const Color(0xFFFFA113).withOpacity(0.4),
                  name: 'Power units (Kw)',
                  dataSource: _unitsdataPoints,
                  xValueMapper: (DataPoint data, _) => data.day,
                  yValueMapper: (DataPoint data, _) => data.units,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  enableTooltip: true,
                  markerSettings: const MarkerSettings(isVisible: true),
                ),
          
                LineSeries<DataPoint, int>(
                  color:const Color.fromARGB(255, 19, 255, 137).withOpacity(0.4),
                  name: 'GHG',
                  dataSource: _ghgdataPoints,
                  xValueMapper: (DataPoint data, _) => data.day,
                  yValueMapper: (DataPoint data, _) => data.ghg,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  enableTooltip: true,
                  markerSettings: const MarkerSettings(isVisible: true),
                ),
          
              ],
              primaryXAxis: NumericAxis(
                edgeLabelPlacement: EdgeLabelPlacement.shift, 
                title: AxisTitle(text: 'Days', textStyle: const TextStyle(color:Colors.green, fontSize: 14))),
              primaryYAxis: NumericAxis(
                labelFormat: '{value}', 
                title: AxisTitle(text: 'Counts', textStyle: const TextStyle(
                  color:Colors.green, fontSize: 14)) 
                ),
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
  final int day;
  final int total;
  final double ghg;
  final double units;
  final int swap;
  //final double mileage;

  DataPoint(
    this.day, 
    this.total, 
    this.ghg, 
    this.units, 
    this.swap, 
    //this.mileage 
    );
}

