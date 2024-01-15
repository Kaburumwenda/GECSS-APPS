import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gecssmns/Apis/base_url.dart';
import 'package:gecssmns/Models/mpesa_transactions.dart';
import 'package:gecssmns/main.dart';
import 'package:gecssmns/screens/Finance/mobile/mpesa/delete.dart';
import 'package:gecssmns/screens/Finance/mobile/mpesa/mpesa_statistics.dart';
import 'package:gecssmns/screens/Finance/mobile/mpesa/update.dart';
import 'package:gecssmns/screens/Finance/mobile/mpesa/view.dart';
import 'package:gecssmns/screens/home/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nb_utils/nb_utils.dart';


class MobileMpesaDashboard extends StatefulWidget {
  const MobileMpesaDashboard({super.key});

  @override
  State<MobileMpesaDashboard> createState() => _MobileMpesaDashboardState();
}

class _MobileMpesaDashboardState extends State<MobileMpesaDashboard> {

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
      backgroundColor: Theme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryBackground,
        elevation: 0.0,
        title: Text('Mpesa', style: TextStyle(
          color: Theme.of(context).headTextColor,
          fontSize: 14,
        ),),
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => const HomeScreen(),
              ));
          }, 
          icon:const Icon(Icons.arrow_back_ios)
          ),
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.download)
          ),
          IconButton(
            onPressed: (){
              showDialog(
                context: context, 
                builder: (BuildContext context){
                  return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState){
                      return rangefilterWidget();
                    }
                    );
                }
                );
            }, 
            icon: const Icon(Icons.filter_list )
          ),

          IconButton(
            onPressed: (){
              setState(() {
                _enddateController.text = "";
                _startdateController.text = "";
              });
              showDialog(
                context: context, 
                builder: (BuildContext context){
                  return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState){
                      return AlertDialog(
                        contentPadding: EdgeInsets.zero,
                        titlePadding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.0),
                          //side:const BorderSide(color: Colors.blue), // Border color
                        ),
                        title: Container(
                        width: double.infinity,
                        padding:const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        color: Theme.of(context).secondaryBackground,
                        child: Column(
                          children: [
                            Image.asset('assets/images/logo.png', height: 50,),
                            Text('FILTER BY SWAP CENTERS', style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).headTextColor,
                            ))
                          ],
                        )
                        ),


                        content: Container(
                            color: Theme.of(context).secondaryBackground,
                            padding:const EdgeInsets.all(10),
                            height: 300,
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
                                          color: Theme.of(context).lightTextColor, // Set border color
                                          width: 1.0, // Set border width
                                        ),
                                      ),
                                      height: 35,
                                      child: DropdownButton(
                                        isExpanded: true,
                                        underline: Container(),
                                        hint:const Text('Select swap center'),
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
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(2),
                                      borderSide:const BorderSide(
                                        color: Colors.blue, // Set border color
                                        width: 2.0,         // Set border width
                                        style: BorderStyle.solid, // Set border style (solid, dashed, etc.)
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
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(2),
                                      borderSide:const BorderSide(
                                        color: Colors.blue, // Set border color
                                        width: 2.0,         // Set border width
                                        style: BorderStyle.solid, // Set border style (solid, dashed, etc.)
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
                                        padding:const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
            icon: const Icon(Icons.charging_station )
          ),
        ],
      ),

      body: Container(  
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 0),
        child: Column(children: [
          const MobileMpesaStatistics(),
          // ###################################### TABLE BODY SECTION ################# BEGIN
          Expanded(
            child: Container(  
              color: Theme.of(context).secondaryBackground,
              child: Column(children: [
                // ##################################### SEARCH & REFRESH ############### START
                Container(
                  margin:const EdgeInsets.only(top: 10, right: 10, left: 10),
                  child: Row(children: [
                    Flexible(
                      child: SizedBox(
                        width: 200,
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
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5)
                            ),
                            borderSide:BorderSide(
                              color: Theme.of(context).secondaryBackground, // Set border color
                              width: 1.0,         // Set border width
                              style: BorderStyle.solid, // Set border style (solid, dashed, etc.)
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

                    SizedBox(
                      height: 32,
                      child: TextButton.icon(
                        onPressed: (){
                          _searchRecords();
                        }, 
                        icon:Icon(Icons.search, size: 15, color: Theme.of(context).lightTextColor,), 
                        label: Text('Search', style: TextStyle(color: Theme.of(context).lightTextColor),),
                        style: ButtonStyle(
                          side: MaterialStateProperty.all(BorderSide(
                            color: Theme.of(context).lightTextColor, // Set the desired border color
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
                    const SizedBox(width: 10,),

                    SizedBox(
                      height: 35,
                      child: IconButton(
                        onPressed: (){
                          _refreshRecord();
                        }, 
                        icon: FaIcon(FontAwesomeIcons.arrowsRotate, size: 20, color: Theme.of(context).lightTextColor, )
                      ),
                    )

                  ]),
                ),
                // ##################################### SEARCH & REFRESH ############### END
                // ########################################## DATATABLE ####################### START
                Expanded(
                  child:Container(
                    padding:const EdgeInsets.fromLTRB(5, 10, 5, 10),
                    width: double.infinity,
                    child:  _isLoading 
                      ? Center(
                        child: LoadingBouncingGrid.square(
                          borderSize: 0.0,
                          backgroundColor: Theme.of(context).loadingColors,
                        )
                        )
                      : _data.isEmpty
                      ? const Center(child: Text('No record to display'),)
                      :SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                          horizontalMargin: 0,
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
                            DataColumn(label: Text('Name')),
                            DataColumn(label: Text('Amount')),
                            DataColumn(label: Text('Status')),
                            DataColumn(label: Text('Date')),
                            DataColumn(label: Text('Action')),
                          ], 
                          rows: List<DataRow>.generate(
                            _data.length,
                            (index) => DataRow(cells: [
                              DataCell(Text((index + 1).toString() )),
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
                                Text(
                                  DateFormat('E, d, HH:mm').format(
                                      DateTime.parse(_data[index].created.toString())),
                                      style:const TextStyle(fontSize: 12 ) 
                                )
                              ),

                              DataCell(
                                SizedBox(
                                  width: 20.0,
                                  child: PopupMenuButton<String>(
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (BuildContext context) {
                                        return [
                                          PopupMenuItem<String>(
                                            textStyle: TextStyle(
                                              color: Theme.of(context).headTextColor,
                                            ),
                                            value: 'View Record',
                                            child: SizedBox(
                                              height: 40,
                                              child: TextButton.icon(
                                                onPressed: (){
                                                  Navigator.of(context).pop();
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext context){
                                                      return MobileRecordView(
                                                        recordData: _data[index]
                                                      );
                                                    }
                                                  );
                                                }, 
                                                icon:const FaIcon(FontAwesomeIcons.eye , color: Color(0xFF1ccaa7), size: 20, ), 
                                                label: const Text('  View'),
                                                style: TextButton.styleFrom(
                                                  // backgroundColor:Theme.of(context).primaryBackground ,
                                                  padding:const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(1),
                                                  ),
                                                ),
                                              )
                                            ),
                                          ),

                                          PopupMenuItem<String>(
                                            textStyle: TextStyle(
                                              color: Theme.of(context).headTextColor,
                                            ),
                                            value: 'Update Record',
                                            child: SizedBox(
                                              height: 40,
                                              child: TextButton.icon(
                                                onPressed: (){
                                                  Navigator.of(context).pop();
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext context){
                                                      return MobileRecordUpdate(
                                                        recordData: _data[index],
                                                        refreshUpdatedRecord: getRecordOnLoad,
                                                      );
                                                    }
                                                  );
                                                }, 
                                                icon:const FaIcon(FontAwesomeIcons.penToSquare , color: Color(0xFF2697FF), size: 20, ), 
                                                label: const Text('  Update'),
                                                style: TextButton.styleFrom(
                                                  // backgroundColor:Theme.of(context).primaryBackground ,
                                                  padding:const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(1),
                                                  ),
                                                ),
                                              )
                                            ),
                                          ),

                                          PopupMenuItem<String>(
                                            textStyle: TextStyle(
                                              color: Theme.of(context).headTextColor,
                                            ),
                                            value: 'Delete Record',
                                            child: SizedBox(
                                              height: 40,
                                              child: TextButton.icon(
                                                onPressed: (){
                                                  Navigator.of(context).pop();
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext context){
                                                      return MobileRecordDelete(
                                                        recordData: _data[index],
                                                        refreshUpdatedRecord: getRecordOnLoad,
                                                      );
                                                    }
                                                  );
                                                }, 
                                                icon:const FaIcon(FontAwesomeIcons.xmark , color: Color(0xFFEC7063), size: 20, ), 
                                                label: const Text('  Delete'),
                                                style: TextButton.styleFrom(
                                                  // backgroundColor:Theme.of(context).primaryBackground ,
                                                  padding:const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(1),
                                                  ),
                                                ),
                                              )
                                            ),
                                          ),


                                        ];
                                      },                               
                                  ),
                                )
                              ),

                            ])
                          )
                          ),
                    ),
                  ),
                )
                 // ########################################## DATATABLE ####################### END
              ]),
            )
           )
          // ###################################### TABLE BODY SECTION ################# END
        ],),
      ),

    );
  }


  Widget rangefilterWidget(){
  return AlertDialog(
        contentPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.0),
          //side:const BorderSide(color: Colors.blue), // Border color
        ),
        title: Container(
        width: double.infinity,
        padding:const EdgeInsets.fromLTRB(10, 5, 10, 5),
        color: Theme.of(context).secondaryBackground,
        child: Column(
          children: [
            Image.asset('assets/images/logo.png', height: 50,),
            Text('FILTER MPESA TRANSACTION', style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).headTextColor,
            ))
          ],
        )
        ),


        content: Container(
            color: Theme.of(context).secondaryBackground,
            padding:const EdgeInsets.all(10),
            height: 360,
            child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(children: [
                Expanded(
                  child: TextButton(
                    onPressed: (){
                        _getTodayRecord();
                    },
                    style: ButtonStyle(  
                      side: MaterialStateProperty.all(BorderSide(
                        color: Theme.of(context).lightTextColor, // Set the desired border color
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
                    child:Text('Today', style: TextStyle(fontSize: 14, color: Theme.of(context).headTextColor,),),
                  ),
                ),

                const SizedBox(width: 30,),

                Expanded(
                  child: TextButton(
                    onPressed: (){
                        _getThisweekRecord();
                    },
                    style: ButtonStyle(  
                      side: MaterialStateProperty.all(BorderSide(
                        color: Theme.of(context).lightTextColor, // Set the desired border color
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
                      fontSize: 14,
                      color: Theme.of(context).headTextColor,
                      ),),
                  ),
                ),
              ],),
              const SizedBox(height: 20,),
              Row(children: [
                Expanded(
                  child: TextButton(
                    onPressed: (){
                        _getThismonthRecord();
                    },
                    style: ButtonStyle(  
                      side: MaterialStateProperty.all(BorderSide(
                        color: Theme.of(context).lightTextColor, // Set the desired border color
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
                    child: Text('This Month', style: TextStyle(fontSize: 14, color: Theme.of(context).headTextColor),),
                  ),
                ),
                const SizedBox(width: 30,),

                Expanded(
                  child: TextButton(
                    onPressed: (){
                        _getThisyearRecord();
                    },
                    style: ButtonStyle(  
                      side: MaterialStateProperty.all(BorderSide(
                        color: Theme.of(context).lightTextColor, // Set the desired border color
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
                    child: Text('This Year', style: TextStyle(fontSize: 14, color: Theme.of(context).headTextColor ),),
                  ),
                ),
                                           
              ],),
              const SizedBox(height: 20,),

        
              Text('Filter by Date range:', style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).headTextColor
              ),),
        
              const SizedBox(height: 10,),
        
              
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
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide:const BorderSide(
                        color: Colors.blue, // Set border color
                        width: 2.0,         // Set border width
                        style: BorderStyle.solid, // Set border style (solid, dashed, etc.)
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
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide:const BorderSide(
                        color: Colors.blue, // Set border color
                        width: 2.0,         // Set border width
                        style: BorderStyle.solid, // Set border style (solid, dashed, etc.)
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
                        _getRecordbyDateRange();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).btnBackground,
                        padding:const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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


}