// ignore_for_file: sized_box_for_whitespace, prefer_final_fields, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gecssmns/Apis/base_url.dart';
import 'package:gecssmns/Models/mpesa_transactions.dart';
import 'package:gecssmns/main.dart';
import 'package:gecssmns/public/Desktop/sidebar.dart';
import 'package:gecssmns/public/Desktop/topnavbar.dart';
import 'package:gecssmns/screens/Finance/desktop/mpesa/delete.dart';
import 'package:gecssmns/screens/Finance/desktop/mpesa/mpesa_statistics.dart';
import 'package:gecssmns/screens/Finance/desktop/mpesa/update.dart';
import 'package:gecssmns/screens/Finance/desktop/mpesa/view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nb_utils/nb_utils.dart';

class DeskMpesaDashboard extends StatefulWidget {
  const DeskMpesaDashboard({super.key});

  @override
  State<DeskMpesaDashboard> createState() => _DeskMpesaDashboardState();
}

class _DeskMpesaDashboardState extends State<DeskMpesaDashboard> {
LocalStorage storage =  LocalStorage('usertoken');
List<MpesaTransactions> _data=[];
List swapCenters = [];
bool _isLoading = false;
bool _modalLoading = false;

TextEditingController searchQueryController = TextEditingController();

TextEditingController  _startdateController = TextEditingController();
DateTime? _selectedDate;
TextEditingController  _enddateController = TextEditingController();
DateTime? _endselectedDate;

var _swapcenterCode;
var _swapcenterTitle;

@override
  void initState() {
    super.initState();
    getRecordOnLoad();
    _getSwapCenters();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
         _startdateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

   Future<void> _endselectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _endselectedDate) {
      setState(() {
        _endselectedDate = picked;
         _enddateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  getRecordOnLoad() async {
      setState(() {
        _isLoading = true;
      });
      _data = [];
      var baseur = AdsType.baseurl;
      String url = '$baseur/v1/mpesa';
      var token = storage.getItem('token');
      List resp = json.decode((
        await http.get(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': "token $token",
        }
       )).body);
      for (var element in resp) {
        _data.add(MpesaTransactions.fromJson(element));
      }

      setState(() {
        _isLoading = false;
      });
  }

  Future _getSwapCenters() async {
    var token = storage.getItem('token');
    var baseur = AdsType.baseurl;
    String baseUrl = '$baseur/v1/branches';
    http.Response response = await http.get(Uri.parse(baseUrl),
    headers: {
            "Content-Type": "application/json",
            'Authorization': "token $token"
          }
     );

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        swapCenters = jsonData;
      });
    }
  }

  _searchRecords() async {
    if(searchQueryController.text.length > 2){
      setState(() {
        _isLoading = true;
        _data = [];
      });
      var baseur = AdsType.baseurl;
      String url = '$baseur/v1/mpesa/search/${searchQueryController.text}';
      var token = storage.getItem('token');
      List resp = json.decode((
        await http.get(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': "token $token",
        }
       )).body);
      for (var element in resp) {
        _data.add(MpesaTransactions.fromJson(element));
      }

      setState(() {
        _isLoading = false;
      });
    }else{
      toast('OOPS!!!... Your input is too short or null');
    }
  }

  _refreshRecord(){
    setState(() {
      searchQueryController.text="";
      _data = [];
    });
    getRecordOnLoad();
  }

 
  _getTodayRecord() async {
      setState(() {
        _isLoading = true;
        _data = [];
      });

      if(mounted){
        Navigator.of(context).pop();
      }
      
      var baseur = AdsType.baseurl;
      String url = '$baseur/v1/mpesa/office/stat/today';
      var token = storage.getItem('token');
      List resp = json.decode((
        await http.get(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': "token $token",
        }
       )).body);
      for (var element in resp) {
        _data.add(MpesaTransactions.fromJson(element));
      }

      setState(() {
        _isLoading = false;
      });
  }

  _getThisweekRecord() async {
      setState(() {
        _isLoading = true;
        _data = [];
      });

      if(mounted){
        Navigator.of(context).pop();
      }
      
      var baseur = AdsType.baseurl;
      String url = '$baseur/v1/mpesa/office/stat/week';
      var token = storage.getItem('token');
      List resp = json.decode((
        await http.get(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': "token $token",
        }
       )).body);
      for (var element in resp) {
        _data.add(MpesaTransactions.fromJson(element));
      }

      setState(() {
        _isLoading = false;
      });
  }

  _getThismonthRecord() async {
      setState(() {
        _isLoading = true;
        _data = [];
      });

      if(mounted){
        Navigator.of(context).pop();
      }
      
      var baseur = AdsType.baseurl;
      String url = '$baseur/v1/mpesa/office/stat/month';
      var token = storage.getItem('token');
      List resp = json.decode((
        await http.get(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': "token $token",
        }
       )).body);
      for (var element in resp) {
        _data.add(MpesaTransactions.fromJson(element));
      }

      setState(() {
        _isLoading = false;
      });
  }

  _getThisyearRecord() async {
      setState(() {
        _isLoading = true;
        _data = [];
      });

      if(mounted){
        Navigator.of(context).pop();
      }
      
      var baseur = AdsType.baseurl;
      String url = '$baseur/v1/mpesa/office/stat/year';
      var token = storage.getItem('token');
      List resp = json.decode((
        await http.get(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': "token $token",
        }
       )).body);
      for (var element in resp) {
        _data.add(MpesaTransactions.fromJson(element));
      }

      setState(() {
        _isLoading = false;
      });
  }

  _getRecordbyDateRange() async {
      setState(() {
        _isLoading = true;
        _data = [];
      });

      if(mounted){
        Navigator.of(context).pop();
      }
      
      if(_startdateController.text.length > 2 && _enddateController.text.length > 2){
        var baseur = AdsType.baseurl;
      String url = '$baseur/v1/mpesa/office/stat/range';
      var token = storage.getItem('token');
      List resp = json.decode((
        await http.post(Uri.parse(url),
        headers: {
          'Authorization': "token $token",
        },
        body:{
          'fromdate': _startdateController.text,
          'todate': _enddateController.text,
        }
       )).body);

      for (var element in resp) {
        _data.add(MpesaTransactions.fromJson(element));
      }

      setState(() {
        _isLoading = false;
      });
      } else{
        setState(() {
        _isLoading = false;
      });
      }
  }


  _getRecordbyAgent() async {
      setState(() {
        _isLoading = true;
        _data = [];
      });
      
      if(_startdateController.text.length > 2 && _enddateController.text.length > 2 ){
        if(mounted){
          Navigator.of(context).pop();
        }
        var baseur = AdsType.baseurl;
        String url = '$baseur/v1/mpesa/office/filter_by_agent';
        var token = storage.getItem('token');
        List resp = json.decode((
          await http.post(Uri.parse(url),
          headers: {
            'Authorization': "token $token",
          },
          body:{
            'fromdate': _startdateController.text,
            'todate': _enddateController.text,
            'agentID': _swapcenterTitle,
          }
        )).body);

        for (var element in resp) {
          _data.add(MpesaTransactions.fromJson(element));
        }

        setState(() {
          _isLoading = false;
        });

        
        } else{
          setState(() {
          _isLoading = false;
        });
      }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            color: Theme.of(context).primaryBackground,
            height: double.infinity,
            width: MediaQuery.of(context).size.width * .12,
            child:const DesktopSidebar(),
          ),

          Container(
            color: Theme.of(context).primaryBackground,
            height: double.infinity,
            width: MediaQuery.of(context).size.width * .88,
            child:Column(
              children: [

                const DesktopTopNav(),

                const DeskMpesaStatistics(),

              // *************************************** BODY CONTENT ******* BEGIN
              Expanded(
                child: Container(
                  color: Theme.of(context).secondaryBackground,
                  margin:const EdgeInsets.fromLTRB(10, 0, 10, 20),
                  child: Column(
                    children: [
                      // ######################################## TOP NAV ########### BEGIN
                      Container(
                        padding:const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Row(children: [
                          const Text("MPESA TRANSACTIONS"),
                          const SizedBox(width: 40,),

                          Flexible(
                            child: SizedBox(
                              width: 300,
                              height: 32,
                              child: TextField(
                              controller: searchQueryController,
                              //autofocus: true,
                              style:const TextStyle(
                                fontSize: 16.0, 
                                color: Colors.white70,
                                height: 1.0,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Theme.of(context).secondaryBackground,
                                contentPadding:const EdgeInsets.only(left: 10, right: 10),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8)
                                  ),
                                  borderSide:BorderSide(
                                    color: Theme.of(context).btnBackground, // Set border color
                                    width: 1.0,         // Set border width
                                    //style: BorderStyle.solid, // Set border style (solid, dashed, etc.)
                                  ),
                                ),
                                focusedBorder:const OutlineInputBorder(
                                  borderRadius:BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8)
                                  ),
                                  borderSide:BorderSide(
                                    color: Colors.blue, // Set border color
                                    width: 1.0,         // Set border width
                                    //style: BorderStyle.solid, // Set border style (solid, dashed, etc.)
                                  ),
                                ),
                                labelText: 'Search by name, Agent code, trans ID...',
                                labelStyle:const TextStyle(fontSize: 12),
                                helperStyle: const TextStyle(color: Colors.white)
                              ),
                              
                              onSubmitted: (String value){
                                _searchRecords();
                              },
                                               
                              ),
                            ),
                            ),

                          TextButton.icon(
                            onPressed: (){
                              _searchRecords();
                            }, 
                            icon: Icon(Icons.search, color: Theme.of(context).lightTextColor,), 
                            label:  Text('Search', style: TextStyle(color: Theme.of(context).lightTextColor)),
                            style: ButtonStyle(  
                              side: MaterialStateProperty.all(BorderSide(
                                color: Theme.of(context).btnBackground, // Set the desired border color
                                width: 1.0, // Set the desired border width
                              )),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.0), // Set the desired border radius
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).secondaryBackground,
                                )
                            ),
                          ),

                          // ################## right buttons
                          const Spacer(),

                          SizedBox(
                            height: 30,
                            child: TextButton.icon(
                              onPressed: (){
                              }, 
                              icon: Icon(Icons.download, size: 20, color: Theme.of(context).lightTextColor), 
                              label:  Text('Pdf', style: TextStyle(fontSize: 16, color: Theme.of(context).lightTextColor),),
                              style: ButtonStyle(  
                                side: MaterialStateProperty.all(BorderSide(
                                  color: Theme.of(context).btnBackground, // Set the desired border color
                                  width: 1.0, // Set the desired border width
                                )),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0.0), // Set the desired border radius
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).secondaryBackground,
                                  )
                              ),
                            ),
                          ),

                          // ################################# AGENT START
                          SizedBox(
                            height: 30,
                            child: TextButton.icon(
                              onPressed: (){
                                 setState(() {
                                  _swapcenterTitle = "";
                                });
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context){
                                    return StatefulBuilder(
                                      builder: (BuildContext context, StateSetter setState) {
                                        return AlertDialog(
                                        elevation: 20.0,
                                        alignment: Alignment.topCenter,
                                        contentPadding: EdgeInsets.zero,
                                        titlePadding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(2.0),
                                            //side:const BorderSide(color: Colors.blue), // Border color
                                          ), 
                                        title: Container(
                                          padding:const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                          color: Theme.of(context).modalHeader,
                                          child: Row(
                                            children: [
                                              Text(
                                                "FILTER BY SWAP CENTERS", style: TextStyle(
                                                  fontSize: 14,
                                                  color: Theme.of(context).modalHeaderTitle,
                                              ),),
                                              const Spacer(),
                                      
                                              IconButton(
                                                onPressed: (){Navigator.of(context).pop();}, 
                                                icon:const Icon(Icons.cancel_outlined, color: Colors.red, )
                                              )
                                            ],
                                          )
                                          ),
                                      
                                        content: Container(
                                          color: Theme.of(context).secondaryBackground,
                                          padding:const EdgeInsets.all(10),
                                          height: 280,
                                          width: 400,
                                          child:Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                      
                                            Text('Select Swap Center', style: TextStyle(
                                              fontSize: 14,
                                              color: Theme.of(context).headTextColor
                                            ),),
                                      
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    padding:const EdgeInsets.only(left: 10, right: 10),
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context).secondaryBackground,
                                                      borderRadius: BorderRadius.circular(1.0), // Set border radius
                                                      border: Border.all(
                                                        color: Theme.of(context).btnBackground, // Set border color
                                                        width: 1.0, // Set border width
                                                      ),
                                                    ),
                                                    height: 35,
                                                    child: DropdownButton(
                                                      dropdownColor: Theme.of(context).secondaryBackground,
                                                      isExpanded: true,
                                                      underline: Container(),
                                                      hint:const Text('Select swap center', style: TextStyle(fontSize: 14),),
                                                      items: swapCenters.map((item) {
                                                        return DropdownMenuItem(
                                                          value: item['title'].toString(),
                                                          child: Text(item['title'].toString()),
                                                          onTap: (){
                                                            _swapcenterTitle = item['code'].toString();
                                                          },
                                                        );
                                                      }).toList(),
                                                      onChanged: (newVal) {
                                                        setState(() {
                                                          _swapcenterCode = newVal;
                                                        });
                                                      },
                                                      value: _swapcenterCode,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                      
                                            const SizedBox(height: 20,),
                                      
                                            Text('Start Date:', style: TextStyle(
                                              fontSize: 14,
                                              color: Theme.of(context).headTextColor
                                            ),),
                                            Flexible(
                                              child: SizedBox(
                                                width: double.infinity,
                                                height: 32,
                                                child: TextField(
                                                //autofocus: true,
                                                style:const TextStyle(
                                                  fontSize: 16.0, 
                                                  color: Colors.white70,
                                                  height: 1.0,
                                                ),
                                                controller: _startdateController,
                                                readOnly: true,
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Theme.of(context).secondaryBackground,
                                                  contentPadding:const EdgeInsets.only(left: 10, right: 10),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderRadius:const BorderRadius.only(
                                                      topLeft: Radius.circular(8),
                                                      bottomLeft: Radius.circular(8)
                                                    ),
                                                    borderSide:BorderSide(
                                                      color: Theme.of(context).btnBackground, // Set border color
                                                      width: 1.0,         // Set border width
                                                      //style: BorderStyle.solid, // Set border style (solid, dashed, etc.)
                                                    ),
                                                  ),
                                                  focusedBorder:const OutlineInputBorder(
                                                    borderRadius:BorderRadius.only(
                                                      topLeft: Radius.circular(8),
                                                      bottomLeft: Radius.circular(8)
                                                    ),
                                                    borderSide:BorderSide(
                                                      color: Colors.blue, // Set border color
                                                      width: 1.0,         // Set border width
                                                      //style: BorderStyle.solid, // Set border style (solid, dashed, etc.)
                                                    ),
                                                  ),
                                                  labelText: 'Select start date...',
                                                  labelStyle:const TextStyle(fontSize: 12),
                                                  helperStyle: const TextStyle(color: Colors.white),
                                                  suffixIcon: IconButton(
                                                    icon:const Icon(Icons.calendar_today, size: 20,),
                                                    onPressed: () => _selectDate(context),
                                                  ),
                                                ),
                                                                
                                                ),
                                              ),
                                              ),
                                            const SizedBox(height: 20,),
                                      
                                            Text('End Date:', style: TextStyle(
                                              fontSize: 14,
                                              color: Theme.of(context).headTextColor
                                            ),),                                        
                                            Flexible(
                                              child: SizedBox(
                                                width: double.infinity,
                                                height: 32,
                                                child: TextField(
                                                //autofocus: true,
                                                style:const TextStyle(
                                                  fontSize: 16.0, 
                                                  color: Colors.white70,
                                                  height: 1.0,
                                                ),
                                                controller: _enddateController,
                                                readOnly: true,
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Theme.of(context).secondaryBackground,
                                                  contentPadding:const EdgeInsets.only(left: 10, right: 10),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderRadius:const BorderRadius.only(
                                                      topLeft: Radius.circular(8),
                                                      bottomLeft: Radius.circular(8)
                                                    ),
                                                    borderSide:BorderSide(
                                                      color: Theme.of(context).btnBackground, // Set border color
                                                      width: 1.0,         // Set border width
                                                      //style: BorderStyle.solid, // Set border style (solid, dashed, etc.)
                                                    ),
                                                  ),
                                                  focusedBorder:const OutlineInputBorder(
                                                    borderRadius:BorderRadius.only(
                                                      topLeft: Radius.circular(8),
                                                      bottomLeft: Radius.circular(8)
                                                    ),
                                                    borderSide:BorderSide(
                                                      color: Colors.blue, // Set border color
                                                      width: 1.0,         // Set border width
                                                      //style: BorderStyle.solid, // Set border style (solid, dashed, etc.)
                                                    ),
                                                  ),
                                                  labelText: 'Select end date...',
                                                  labelStyle:const TextStyle(fontSize: 12),
                                                  helperStyle: const TextStyle(color: Colors.white),
                                                  suffixIcon: IconButton(
                                                    icon:const Icon(Icons.calendar_today, size: 20,),
                                                    onPressed: () => _endselectDate(context),
                                                  ),
                                                ),
                                                                
                                                ),
                                              ),
                                              ),
                                      
                                            Container(
                                              margin: const EdgeInsets.only(top: 20),
                                              child: _modalLoading 
                                              ? const Center(child: CircularProgressIndicator(),)
                                              : Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: (){
                                                      _getRecordbyAgent();
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: Theme.of(context).btnBackground,
                                                      padding:const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(1),
                                                      ),
                                                    ),
                                                    child: Text('Pull Records', style: TextStyle(
                                                      color: Theme.of(context).headTextColor
                                                    ),),
                                                    ),
                                                ],
                                              ),
                                            )
                                      
                                      
                                          ],
                                        ),),
                                      
                                      );
                                      }
                                      
                                    );
                                  }
                                );
                              }, 
                              icon: Icon(Icons.battery_2_bar_outlined, size: 20, color: Theme.of(context).lightTextColor), 
                              label:  Text('Swap Centers', style: TextStyle(fontSize: 16, color: Theme.of(context).lightTextColor ),),
                              style: ButtonStyle(  
                                side: MaterialStateProperty.all(BorderSide(
                                  color: Theme.of(context).btnBackground, // Set the desired border color
                                  width: 1.0, // Set the desired border width
                                )),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0.0), // Set the desired border radius
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).secondaryBackground,
                                  )
                              ),
                            ),
                          ),
                          // ########################################## AGENT END

                          SizedBox(
                            height: 30,
                            child: TextButton.icon(
                              onPressed: (){
                                setState(() {
                                  _startdateController.text = "";
                                  _enddateController.text = "";
                                  _selectedDate = null;
                                  _endselectedDate = null;
                                });
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context){
                                    return AlertDialog(
                                      elevation: 20.0,
                                      alignment: Alignment.topCenter,
                                      contentPadding: EdgeInsets.zero,
                                      titlePadding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(2.0),
                                          //side:const BorderSide(color: Colors.blue), // Border color
                                        ), 
                                      title: Container(
                                        padding:const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                        color: Theme.of(context).modalHeader,
                                        child: Row(
                                          children: [
                                            Text(
                                              "FILTER MPESA TRANSACTION", style: TextStyle(
                                                fontSize: 14,
                                                color: Theme.of(context).modalHeaderTitle,
                                            ),),
                                            const Spacer(),

                                            IconButton(
                                              onPressed: (){Navigator.of(context).pop();}, 
                                              icon:const Icon(Icons.cancel_outlined, color: Colors.red, )
                                            )
                                          ],
                                        )
                                        ),

                                      content: Container(
                                        color: Theme.of(context).secondaryBackground,
                                        height: 190,
                                        child:Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Container(
                                            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                            child: Row(children: [

                                              Container(
                                                margin: const EdgeInsets.only(right: 20),
                                                height: 30,
                                                child: TextButton(
                                                  onPressed: (){
                                                     _getTodayRecord();
                                                  },
                                                  style: ButtonStyle(  
                                                    side: MaterialStateProperty.all(BorderSide(
                                                      color: Theme.of(context).btnBackground, // Set the desired border color
                                                      width: 1.0, // Set the desired border width
                                                    )),
                                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(5.0), // Set the desired border radius
                                                      ),
                                                    ),
                                                    // backgroundColor: MaterialStateProperty.all(
                                                    //   Theme.of(context).primaryBackground,
                                                    //   )
                                                  ),  
                                                  child: Text('Today', style: TextStyle(
                                                    fontSize: 14, color: Theme.of(context).lightTextColor,),),
                                                ),
                                              ),

                                              Container(
                                                margin: const EdgeInsets.only(right: 20),
                                                height: 30,
                                                child: TextButton(
                                                  onPressed: (){
                                                     _getThisweekRecord();
                                                  },
                                                  style: ButtonStyle(  
                                                    side: MaterialStateProperty.all(BorderSide(
                                                      color: Theme.of(context).btnBackground, // Set the desired border color
                                                      width: 1.0, // Set the desired border width
                                                    )),
                                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(5.0), // Set the desired border radius
                                                      ),
                                                    ),
                                                    // backgroundColor: MaterialStateProperty.all(
                                                    //   Theme.of(context).primaryBackground,
                                                    //   )
                                                  ),  
                                                  child: Text('This Week', style: TextStyle(
                                                    fontSize: 14, color: Theme.of(context).lightTextColor,),),
                                                ),
                                              ),

                                              Container(
                                                margin: const EdgeInsets.only(right: 20),
                                                height: 30,
                                                child: TextButton(
                                                  onPressed: (){
                                                     _getThismonthRecord();
                                                  },
                                                  style: ButtonStyle(  
                                                    side: MaterialStateProperty.all(BorderSide(
                                                      color: Theme.of(context).btnBackground, // Set the desired border color
                                                      width: 1.0, // Set the desired border width
                                                    )),
                                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(5.0), // Set the desired border radius
                                                      ),
                                                    ),
                                                    // backgroundColor: MaterialStateProperty.all(
                                                    //   Theme.of(context).primaryBackground,
                                                    //   )
                                                  ),  
                                                  child: Text('This Month', style: TextStyle(
                                                    fontSize: 14, color: Theme.of(context).lightTextColor,),),
                                                ),
                                              ),

                                              Container(
                                                margin: const EdgeInsets.only(right: 20),
                                                height: 30,
                                                child: TextButton(
                                                  onPressed: (){
                                                     _getThisyearRecord();
                                                  },
                                                  style: ButtonStyle(  
                                                    side: MaterialStateProperty.all(BorderSide(
                                                      color: Theme.of(context).btnBackground, // Set the desired border color
                                                      width: 1.0, // Set the desired border width
                                                    )),
                                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(5.0), // Set the desired border radius
                                                      ),
                                                    ),
                                                    // backgroundColor: MaterialStateProperty.all(
                                                    //   Theme.of(context).primaryBackground,
                                                    //   )
                                                  ),  
                                                  child: Text('This Year', style: TextStyle(fontSize: 14, color: Theme.of(context).lightTextColor,),),
                                                ),
                                              ),
                                            ],),
                                          ),

                                          const SizedBox(height: 10,),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10),
                                            child: Text('Filter by date range:', style: TextStyle(
                                              color: Theme.of(context).headTextColor,
                                            ),),
                                          ),
                                         // const SizedBox(height: 10,),

                                          
                                          Container(
                                            margin:const EdgeInsets.all(10),
                                            child: Row(children: [
                                            
                                              Flexible(
                                                child: SizedBox(
                                                  width: 200,
                                                  height: 32,
                                                  child: TextField(
                                                  //autofocus: true,
                                                  style:const TextStyle(
                                                    fontSize: 16.0, 
                                                    color: Colors.white70,
                                                    height: 1.0,
                                                  ),
                                                  controller: _startdateController,
                                                  readOnly: true,
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Theme.of(context).secondaryBackground,
                                                    contentPadding:const EdgeInsets.only(left: 10, right: 10),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderRadius:const BorderRadius.only(
                                                        topLeft: Radius.circular(8),
                                                        bottomLeft: Radius.circular(8)
                                                      ),
                                                      borderSide:BorderSide(
                                                        color: Theme.of(context).btnBackground, // Set border color
                                                        width: 1.0,         // Set border width
                                                        //style: BorderStyle.solid, // Set border style (solid, dashed, etc.)
                                                      ),
                                                    ),
                                                    focusedBorder:const OutlineInputBorder(
                                                      borderRadius:BorderRadius.only(
                                                        topLeft: Radius.circular(8),
                                                        bottomLeft: Radius.circular(8)
                                                      ),
                                                      borderSide:BorderSide(
                                                        color: Colors.blue, // Set border color
                                                        width: 1.0,         // Set border width
                                                        //style: BorderStyle.solid, // Set border style (solid, dashed, etc.)
                                                      ),
                                                    ),
                                                    labelText: 'Select start date...',
                                                    labelStyle:const TextStyle(fontSize: 12),
                                                    helperStyle: const TextStyle(color: Colors.white),
                                                    suffixIcon: IconButton(
                                                      icon:const Icon(Icons.calendar_today, size: 20,),
                                                      onPressed: () => _selectDate(context),
                                                    ),
                                                  ),
                                                                  
                                                  ),
                                                ),
                                                ),
                                                const SizedBox(width: 40,),
                                            
                                              Flexible(
                                                child: SizedBox(
                                                  width: 200,
                                                  height: 32,
                                                  child: TextField(
                                                  //autofocus: true,
                                                  style:const TextStyle(
                                                    fontSize: 16.0, 
                                                    color: Colors.white70,
                                                    height: 1.0,
                                                  ),
                                                  controller: _enddateController,
                                                  readOnly: true,
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Theme.of(context).secondaryBackground,
                                                    contentPadding:const EdgeInsets.only(left: 10, right: 10),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderRadius:const BorderRadius.only(
                                                        topLeft: Radius.circular(8),
                                                        bottomLeft: Radius.circular(8)
                                                      ),
                                                      borderSide:BorderSide(
                                                        color: Theme.of(context).btnBackground, // Set border color
                                                        width: 1.0,         // Set border width
                                                        //style: BorderStyle.solid, // Set border style (solid, dashed, etc.)
                                                      ),
                                                    ),
                                                    focusedBorder:const OutlineInputBorder(
                                                      borderRadius:BorderRadius.only(
                                                        topLeft: Radius.circular(8),
                                                        bottomLeft: Radius.circular(8)
                                                      ),
                                                      borderSide:BorderSide(
                                                        color: Colors.blue, // Set border color
                                                        width: 1.0,         // Set border width
                                                        //style: BorderStyle.solid, // Set border style (solid, dashed, etc.)
                                                      ),
                                                    ),
                                                    labelText: 'Select end date...',
                                                    labelStyle:const TextStyle(fontSize: 12),
                                                    helperStyle: const TextStyle(color: Colors.white),
                                                    suffixIcon: IconButton(
                                                      icon:const Icon(Icons.calendar_today, size: 20,),
                                                      onPressed: () => _endselectDate(context),
                                                    ),
                                                  ),
                                                                  
                                                  ),
                                                ),
                                                ),
                                            
                                            ],),
                                          ),

                                          Container(
                                            margin: const EdgeInsets.only(top: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: (){
                                                    _getRecordbyDateRange();
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Theme.of(context).btnBackground,
                                                    padding:const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(1),
                                                    ),
                                                  ),
                                                  child: Text('Pull Records', style: TextStyle(
                                                    color: Theme.of(context).headTextColor
                                                  ),),
                                                  ),
                                              ],
                                            ),
                                          )


                                        ],
                                      ),),

                                    );
                                  }
                                );
                              }, 
                              icon: Icon(Icons.grass, size: 20, color: Theme.of(context).lightTextColor), 
                              label:  Text('Filter', style: TextStyle(fontSize: 16, color: Theme.of(context).lightTextColor),),
                              style: ButtonStyle(  
                                side: MaterialStateProperty.all(BorderSide(
                                  color: Theme.of(context).btnBackground, // Set the desired border color
                                  width: 1.0, // Set the desired border width
                                )),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0.0), // Set the desired border radius
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).secondaryBackground,
                                  )
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 30,
                            child: TextButton.icon(
                              onPressed: (){
                                _refreshRecord();
                              }, 
                              icon: Icon(Icons.refresh_outlined, size: 20, color: Theme.of(context).lightTextColor), 
                              label:  Text('Refresh', style: TextStyle(fontSize: 16, color: Theme.of(context).lightTextColor),),
                              style: ButtonStyle(  
                                side: MaterialStateProperty.all(BorderSide(
                                  color: Theme.of(context).btnBackground, // Set the desired border color
                                  width: 1.0, // Set the desired border width
                                )),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0.0), // Set the desired border radius
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).secondaryBackground,
                                  )
                              ),
                            ),
                          ),

                          // ################## right buttons
                        ]),
                      ),
                      // ######################################## TOP NAV ########### END
                
                      // ######################################## DATATABLE ########### BEGIN
                      Expanded(
                        child: Container(
                          child: _isLoading 
                          ? Center(
                            child: LoadingBouncingGrid.square(
                              borderSize: 0.0,
                              backgroundColor: Theme.of(context).loadingColors,
                            )
                            )
                          : _data.isEmpty
                          ? const Center(child: Text('No record to display'),)
                          :Container(
                            width: double.infinity,
                            // color: Theme.of(context).secondaryBackground,
                            padding:const EdgeInsets.all(5),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: DataTable(
                                  columnSpacing: 2,
                                  dataRowMaxHeight: 27,
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
                                    DataColumn(label: Text('#')),
                                    DataColumn(label: Text('Type')),
                                    DataColumn(label: Text('TransID')),
                                    DataColumn(label: Text('REF')),
                                    DataColumn(label: Text('Name')),
                                    DataColumn(label: Text('Amount')),
                                    DataColumn(label: Text('Balance')),
                                    DataColumn(label: Text('Status')),
                                    DataColumn(label: Text('TRANSTIME')),
                                    DataColumn(label: Text('Action')),
                                  ], 
                                  rows: List<DataRow>.generate(
                                    _data.length,
                                    (index) => DataRow(cells: [
                                      DataCell(Container( 
                                        width: 40.0, 
                                        child: Text("${index + 1 }"))),
                                      DataCell(Text(_data[index].transactionType.toString() )),
                                      DataCell(Text(_data[index].transID.toString() )),
                                      DataCell(
                                        Row(
                                          children: [
                                            Text(_data[index].billRefNumber.toString() ),
                                            const SizedBox(width: 5,),
                                            InkWell(
                                              onTap: (){
                                              showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: (BuildContext context){
                                                    return RecordUpdate(
                                                      recordData: _data[index],
                                                      refreshUpdatedRecord: getRecordOnLoad,
                                                    );
                                                  }
                                                );
                                            },
                                            child: Icon(Icons.edit, size: 15, color: Theme.of(context).lightTextColor,)),
                                          ],
                                        )
                                      ),
                                      DataCell(Text(_data[index].firstName.toString())),
                                      DataCell(SizedBox( width:50, child: Text( _data[index].transAmount.toString()),)),
                                      DataCell(SizedBox( width:80, child: Text( _data[index].orgAccountBalance.toString()),)),
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
                                          //width: 140.0,
                                          child: Text(
                                            DateFormat('E, d MMM yyyy HH:mm:ss').format(
                                                DateTime.parse(_data[index].created.toString())),
                                                style:const TextStyle(fontSize: 12 ) 
                                          ),
                                        )
                                      ),
                                      DataCell(
                                        Row(children: [
                                          InkWell(
                                            onTap: (){
                                              showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: (BuildContext context){
                                                    return RecordView(
                                                      recordData: _data[index]
                                                    );
                                                  }
                                                );
                                            },
                                            child: Container(
                                              padding:const EdgeInsets.fromLTRB(10, 3, 10, 3),
                                              color: const Color(0xFF1ccaa7).withOpacity(0.2),
                                              child:const FaIcon(FontAwesomeIcons.eye , color: Color(0xFF1ccaa7), size: 15, )),
                                          ),
                                          const SizedBox(width: 10,),
                                          InkWell(
                                            onTap: (){
                                              showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: (BuildContext context){
                                                    return RecordUpdate(
                                                      recordData: _data[index],
                                                      refreshUpdatedRecord: getRecordOnLoad,
                                                    );
                                                  }
                                                );
                                            },
                                            child: Container(
                                              padding:const EdgeInsets.fromLTRB(10, 3, 10, 3),
                                              color: const Color(0xFF2697FF).withOpacity(0.2),
                                              child:const FaIcon(FontAwesomeIcons.penToSquare , color: Color(0xFF2697FF), size: 15, )),
                                          ),
                                          const SizedBox(width: 10,),
                                          InkWell(
                                            onTap: (){
                                              showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: (BuildContext context){
                                                    return RecordDelete(
                                                      recordData: _data[index],
                                                      refreshUpdatedRecord: getRecordOnLoad,
                                                    );
                                                  }
                                                );
                                            },
                                            child: Container(
                                              padding:const EdgeInsets.fromLTRB(10, 3, 10, 3),
                                              color: const Color(0xFFEC7063).withOpacity(0.2),
                                              child:const FaIcon(FontAwesomeIcons.xmark , color: Color(0xFFEC7063), size: 15, )),
                                          ),
                                          const SizedBox(width: 10,),
                                        ],)
                              
                                      ),

                                    ])
                                  )
                                  ),
                            ),
                          )
                        ),
                      )
                      // ######################################## DATATABLE ########### END
                    ],
                  ),
                ),
              )
              // *************************************** BODY CONTENT ******* END


              ],
            ),
          ),
        ]
        ,),
    );
  }



}
