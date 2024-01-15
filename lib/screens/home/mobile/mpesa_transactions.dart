import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gecssmns/Apis/base_url.dart';
import 'package:gecssmns/Models/mpesa_transactions.dart';
import 'package:gecssmns/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:loading_animations/loading_animations.dart';

class MobileMpesaTransactions extends StatefulWidget {
  const MobileMpesaTransactions({super.key});

  @override
  State<MobileMpesaTransactions> createState() => _MobileMpesaTransactionsState();
}

class _MobileMpesaTransactionsState extends State<MobileMpesaTransactions> {

  List<MpesaTransactions> _data=[];
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
      String url = '$baseur/v1/mpesa/office/mpesa_min_List';
      List resp = json.decode((await http.get(Uri.parse(url) )).body);
      for (var element in resp) {
        _data.add(MpesaTransactions.fromJson(element));
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
        color: Theme.of(context).primaryBackground,
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
        color: Theme.of(context).primaryBackground,
        padding:const EdgeInsets.all(5),
        child: Column(
          children: [

            Container(
              padding:const EdgeInsets.only(left: 10.0, right: 20.0),
              child: Row(
                children: [
                Text("Recent Payment Transactions", style: GoogleFonts.teko(textStyle: TextStyle(
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
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                    columnSpacing: 5,
                    dataRowMaxHeight: 35,
                    dataRowMinHeight: 20,
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
                      DataColumn(label: Text('No')),
                      DataColumn(label: Text('TransID')),
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Amount')),
                      DataColumn(label: Text('Status')),
                      DataColumn(label: Text('Applied on.')),
                    ], 
                    rows: List<DataRow>.generate(
                      _data.length,
                      (index) => DataRow(cells: [
                        DataCell(Text((index + 1).toString() )),
                        DataCell(Text(_data[index].transID.toString() )),
                        DataCell(Text(_data[index].firstName.toString())),
                        DataCell(SizedBox( width:50, child: Text( _data[index].transAmount.toString()),)),
                        DataCell(
                          Container(
                            width: 40.0,
                            padding: const EdgeInsets.only(top: 2, bottom: 2),
                            color: Colors.green,
                            child:const Text("Paid",
                            textAlign: TextAlign.center,
                            style: TextStyle(color:Colors.white ),
                            ),
                          )),
                        DataCell(
                          SizedBox(
                            width: 100.0,
                            child: Text(
                              DateFormat('E, d, HH:mm').format(
                                  DateTime.parse(_data[index].created.toString())),
                                  style:const TextStyle(fontSize: 12 ) 
                            ),
                          )
                        ),
                      ])
                    )
                    ),
              ),
            ),
          ],
        ),
      )
    );
  }
}