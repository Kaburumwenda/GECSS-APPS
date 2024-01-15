import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gecssmns/Apis/base_url.dart';
import 'package:gecssmns/Models/battery_swaps.dart';
import 'package:gecssmns/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:localstorage/localstorage.dart';

class DeskBatterySwaps extends StatefulWidget {
  const DeskBatterySwaps({super.key});

  @override
  State<DeskBatterySwaps> createState() => _DeskBatterySwapsState();
}

class _DeskBatterySwapsState extends State<DeskBatterySwaps> {
  LocalStorage storage =  LocalStorage('usertoken');

  List<BatterySwaps> _data=[];
  bool _isLoading = false;


   @override
    void initState() {
      super.initState();
      _getRecord_onLoad();
    }

  // ignore: non_constant_identifier_names
  _getRecord_onLoad() async {
      setState(() {
        _isLoading = true;
      });
      _data = [];
      var baseur = AdsType.baseurl;
      var token = storage.getItem('token');
      String url = '$baseur/v1/battery/batteryswap_min10';
      List resp = json.decode((await http.get(Uri.parse(url),
      headers: {
            "Content-Type": "application/json",
            'Authorization': "token $token"
          }
       )).body);
      for (var element in resp) {
        _data.add(BatterySwaps.fromJson(element));
      }

      setState(() {
        _isLoading = false;
      });
  }


  @override
  Widget build(BuildContext context) {
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
      : _data.isEmpty
      ? const Center(child: Text('No record to display'),)
      :Container(
        color: Theme.of(context).secondaryBackground,
        padding:const EdgeInsets.all(5),
        child: Column(
          children: [

            Container(
              padding:const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                children: [
                Text("Recent Battery Swaps", style: GoogleFonts.teko(textStyle: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).lightTextColor
                )), ),
                const Spacer(),
                TextButton(
                  onPressed: (){},
                  style: ElevatedButton.styleFrom(
                      backgroundColor:const Color(0xFFFFA113).withOpacity(0.2),
                      padding:const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  child:const Text('See More', style: TextStyle(color: Colors.white),)
                )
              ],),
            ),

            SizedBox(
              width: double.infinity,
              child: DataTable(
                  columnSpacing: 10,
                  dataRowMaxHeight: 27 ,
                  dataRowMinHeight: 10,
                  headingRowHeight: 25.0,
                  headingTextStyle: GoogleFonts.teko(textStyle: TextStyle(
                    color: Theme.of(context).lightTextColor,
                    fontSize: 18,
                    )),
                  dataTextStyle:GoogleFonts.lato(textStyle: TextStyle(
                    color: Theme.of(context).lightTextColor,
                    fontSize: 12,
                    )) ,
                  columns:const [
                    DataColumn(label: Text('Location')),
                    DataColumn(label: Text('Bike')),
                    DataColumn(label: Text('Battery')),
                    DataColumn(label: Text('Amount')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Applied on.')),
                  ], 
                  rows: List<DataRow>.generate(
                    _data.length,
                    (index) => DataRow(cells: [
                      DataCell(
                        SizedBox(
                          width: 80.0,
                          child: Text(_data[index].source.toString(), 
                          maxLines: 1, overflow: TextOverflow.ellipsis, ),
                        )
                        ),
                      DataCell(Text(_data[index].bikeNo.toString())),
                      DataCell(Text(_data[index].batteryCode1.toString())),
                      DataCell(SizedBox( width:50, child: Text( _data[index].amount.toString()),)),
                      DataCell(
                        Container(
                          width: 40.0,
                          padding: const EdgeInsets.only(top: 2, bottom: 2),
                          color: Colors.green,
                          child:Text(_data[index].status.toString(),
                          textAlign: TextAlign.center,
                          style:const TextStyle(color:Colors.white ),
                          ),
                        )),
                      DataCell(
                        SizedBox(
                          width: 140.0,
                          child: Text(
                            DateFormat('E, d MMM yyyy HH:mm:ss').format(
                                DateTime.parse(_data[index].createdAt.toString())).substring(0, 17),
                                style:const TextStyle(fontSize: 12 ) 
                          ),
                        )
                      ),
                    ])
                  )
                  ),
            ),
          ],
        ),
      )
    );
  }
}