// ignore_for_file: prefer_typing_uninitialized_variables, prefer_final_fields

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gecssmns/Apis/base_url.dart';
import 'package:gecssmns/Models/new_bikes.dart';
import 'package:gecssmns/main.dart';
import 'package:gecssmns/public/Desktop/sidebar.dart';
import 'package:gecssmns/public/Desktop/topnavbar.dart';
import 'package:gecssmns/screens/ebikes/desktop/new/delete.dart';
import 'package:gecssmns/screens/ebikes/desktop/new/update.dart';
import 'package:gecssmns/screens/ebikes/desktop/new/view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animations/loading_animations.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nb_utils/nb_utils.dart';

class DeskEbikeDashboard extends StatefulWidget {
  const DeskEbikeDashboard({super.key});

  @override
  State<DeskEbikeDashboard> createState() => _DeskEbikeDashboardState();
}

class _DeskEbikeDashboardState extends State<DeskEbikeDashboard> {

  List<NewMotobikes> _data=[];
  bool _isLoading = false;

  LocalStorage storage =  LocalStorage('usertoken');
  List swapCenters = [];

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
      var token = storage.getItem('token');
      String url = '$baseur/v1/motorbike/list';
      List resp = json.decode((await http.get(Uri.parse(url),
        headers: {
            "Content-Type": "application/json",
            'Authorization': "token $token"
          }
       )).body);
      for (var element in resp) {
        _data.add(NewMotobikes.fromJson(element));
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
      String url = '$baseur/v1/motorbike_retro/search/${searchQueryController.text}';
      var token = storage.getItem('token');
      List resp = json.decode((
        await http.get(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': "token $token",
        }
       )).body);
      for (var element in resp) {
        _data.add(NewMotobikes.fromJson(element));
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
        String url = '$baseur/v1/battery/swap/filter_by_agent';
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
          _data.add(NewMotobikes.fromJson(element));
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
      body: Row(children: [
        Container(
            color: Theme.of(context).secondaryBackground,
            height: double.infinity,
            width: MediaQuery.of(context).size.width * .12,
            child:const DesktopSidebar(),
          ),

        Container(
          color: Theme.of(context).primaryBackground,
          height: double.infinity,
          width: MediaQuery.of(context).size.width * .88,
          child: Column(children: [

            Container(
              padding: const EdgeInsets.only(bottom: 5),
              color: Theme.of(context).secondaryBackground,
              child: const DesktopTopNav()),

            Expanded(
              child: Container(
                color: Theme.of(context).secondaryBackground,
                margin:const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                children: [
                  // ########################## TOP NAV ######################## START 
                  Container(
                    padding:const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Row(children: [
                      const Text("BRAND NEW E-BIKES"),
                      const SizedBox(width: 40,),
                
                      Flexible(
                        child: SizedBox(
                          width: 300,
                          height: 32,
                          child: TextField(
                          controller: searchQueryController,
                          //autofocus: true,
                          style:TextStyle(
                            fontSize: 16.0, 
                            color: Theme.of(context).lightTextColor,
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
                            labelText: 'Search by plate no, client, country...',
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
                        icon:Icon(Icons.search, color: Theme.of(context).lightTextColor), 
                        label: Text('Search', style: TextStyle(color: Theme.of(context).lightTextColor),),
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
                            snackBar(
                              context,
                              title: 'Access denied...Please contact system Admin sysadmin@gecss-ke.com',
                              textColor: Colors.white,
                              backgroundColor: Colors.red,
                              elevation: 8,
                              //shape: RoundedRectangleBorder(borderRadius: radius(30)),
                              margin:const EdgeInsets.fromLTRB(200, 16, 100, 20),
                              duration: 3.seconds,
                            );
                          }, 
                          icon:Icon(Icons.download, size: 20, color: Theme.of(context).lightTextColor, ), 
                          label: Text('Pdf', style: TextStyle(fontSize: 16, color: Theme.of(context).lightTextColor,),),
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
                            // showDialog(
                            //   barrierDismissible: false,
                            //   context: context,
                            //   builder: (BuildContext context){
                            //     return CreateRecord(
                            //       refreshUpdatedRecord: getRecordOnLoad,
                            //       swapCenters: swapCenters,
                            //     );
                            //   }
                            // );
                            snackBar(
                              context,
                              title: 'Access denied',
                              textColor: Colors.white,
                              backgroundColor: Colors.red,
                              elevation: 8,
                              //shape: RoundedRectangleBorder(borderRadius: radius(30)),
                              margin:const EdgeInsets.fromLTRB(200, 16, 100, 20),
                              duration: 3.seconds,
                            );
                          }, 
                          icon: Icon(Icons.add , size: 20, color: Theme.of(context).lightTextColor), 
                          label: Text('Add', style: TextStyle(fontSize: 16, color: Theme.of(context).lightTextColor),),
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
                  // ########################## TOP NAV ######################## END
                  // ########################## DATATABLE ######################## START 
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
                      : SizedBox(
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: DataTable(
                            horizontalMargin: 5,
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
                              DataColumn(label: Text('#')),
                              DataColumn(label: Text('Client')),
                              DataColumn(label: Text('Country')),
                              DataColumn(label: Text('C.Phone')),
                              DataColumn(label: Text('Ebike No.')),
                              DataColumn(label: Text('Chassis No')),
                              DataColumn(label: Text('Make')),
                              DataColumn(label: Text('Model')),
                              DataColumn(label: Text('Color')),
                              DataColumn(label: Text('Status')),
                              DataColumn(label: Text('Dep.date')),
                              DataColumn(label: Text('Action')),
                            ], 
                            rows: List<DataRow>.generate(
                              _data.length,
                              (index) => DataRow(cells: [
                                DataCell(SizedBox( 
                                  width: 30.0, 
                                  child: Text("${index + 1 }"))),
                                DataCell(Text(_data[index].client.toString(), )),
                                DataCell(Text(_data[index].country.toString(), )),
                                DataCell(Text(_data[index].clientPhone.toString(), )),
                                DataCell(Text(_data[index].numberplate.toString(), )),
                                DataCell(
                                  SizedBox(
                                    width: 100.0,
                                    child: Text(_data[index].chassisNo.toString(), 
                                    maxLines: 1, overflow: TextOverflow.ellipsis, ),
                                  )
                                ),
                                DataCell(
                                  Text(_data[index].make.toString(), 
                                  maxLines: 1, overflow: TextOverflow.ellipsis, )
                                ),
                                DataCell(Text( _data[index].model.toString() )),
                                DataCell(Text( _data[index].color.toString() )),
                                DataCell(
                                  Container(
                                    width: 80.0,
                                    padding:const EdgeInsets.only(top: 2, bottom: 2),
                                    color: _data[index].status == 'Active' ? Colors.green :  _data[index].status == 'Charged' ? Colors.blue : Colors.orange,
                                    child:Text(_data[index].status.toString(),
                                    textAlign: TextAlign.center,
                                    style:const TextStyle(color:Colors.white ),
                                    ),
                                  )),

                                DataCell(Text(_data[index].createdAt.toString()) ),
                                            
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
                                                swapCenters: swapCenters,
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
                    ),
                    ),
                  )
                  // ########################## DATATABLE ######################## END 
                ],),
              ))
          ],),)
        

      ]),
    );
  }
}