// ignore_for_file: prefer_final_fields, use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:gecssmns/Apis/base_url.dart';
import 'package:gecssmns/Models/battery_swaps.dart';
import 'package:gecssmns/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

class RecordUpdate extends StatefulWidget {
  final BatterySwaps recordData;
  final Function refreshUpdatedRecord;
  final List swapCenters;
  const RecordUpdate({ 
    required this.recordData,
    required this.refreshUpdatedRecord,
    required this.swapCenters,
    super.key});

  @override
  State<RecordUpdate> createState() => _RecordUpdateState();
}

class _RecordUpdateState extends State<RecordUpdate> {
  LocalStorage storage =  LocalStorage('usertoken');
  TextEditingController  _bikeController = TextEditingController();
  TextEditingController  _batteryController = TextEditingController();
  TextEditingController  _amountController = TextEditingController();


  var _swapCenterTitle;
  var _batteryStatusTitle;

  List _batteryStatus = [
    {
      "title":"Issued"
    },
    {
      "title":"Depleted"
    }
  ];

  @override
  void initState() {
    super.initState();
    setState(() {
      _bikeController.text = widget.recordData.bikeNo.toString();
      _batteryController.text = widget.recordData.batteryCode1.toString();
      _amountController.text = widget.recordData.amount.toString();
      _swapCenterTitle = widget.recordData.source;
      _batteryStatusTitle = widget.recordData.status;
    });
  }

  void callAsyncFunction() async {
    await widget.refreshUpdatedRecord();
  }


  _updateRecord() async {
      
      if(_batteryController.text.length >= 14){
        if(mounted){
          Navigator.of(context).pop();
        }
        var baseur = AdsType.baseurl;
        String url = '$baseur/v1/battery/swap/update/${widget.recordData.id}';
        var token = storage.getItem('token');
        var resp = 
          await http.post(Uri.parse(url),
          headers: {
            'Authorization': "token $token",
          },
          body:{
            'source': _swapCenterTitle,
            'bike_no':_bikeController.text,
            'battery_code1': _batteryController.text,
            'amount': _amountController.text,
            'status': _batteryStatusTitle,
          }
        );

        var data = json.decode(resp.body);

        if(data['error'] == 'false'){
         if(mounted){
          ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.success,
              title: "Update Successful",
              text: "The record has been updated to server successfully"
            )
          );
         }

        callAsyncFunction();

        } else{
          if(mounted){
            ArtSweetAlert.show(
              context: context,
              artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.danger,
                title: "OPPs!!!... an error occured",
                text: "An error occured while updating the record. Please try again later"
              )
            );
          }
        }

        
        } else{
          snackBar(
          context,
          title: 'Please Note battery serial must be atleast 14 letters',
          textColor: Colors.white,
          backgroundColor: Colors.red,
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: radius(5)),
          margin:const EdgeInsets.all(16),
          duration: 6.seconds,
        );
      }
  }

  @override
  Widget build(BuildContext context) {
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
              "UPDATE BATTERY SWAP DETAILS", style: TextStyle(
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
        padding:const EdgeInsets.all(10),
        color: Theme.of(context).secondaryBackground,
        height: 220,
        width: 700,
        child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(children: [

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text('Swap Center', style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).headTextColor
              ),),
              const SizedBox(height: 5,),
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
                        hint: Text(_swapCenterTitle.toString()),
                        items: widget.swapCenters.map((item) {
                          return DropdownMenuItem(
                            value: item['title'].toString(),
                            child: Text(item['title'].toString()),
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          setState(() {
                            _swapCenterTitle = newVal;
                          });
                        },
                        value: _swapCenterTitle,
                      ),
                    ),
                  ),
                ],
              ),
              ],),
            ),
            const SizedBox(width: 20,),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text('Battery Serial', style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).headTextColor
              ),),
              const SizedBox(height: 5,),
              Row(
              children: [
                Flexible(
                  child: SizedBox(
                    height: 32,
                    child: TextFormField(
                    controller: _batteryController,
                    style: GoogleFonts.lato(textStyle: TextStyle(
                      fontSize: 14.0, 
                      color: Theme.of(context).lightTextColor,
                      height: 1.0,
                    )),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).secondaryBackground,
                      contentPadding:const EdgeInsets.only(left: 10, right: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide:BorderSide(
                          color: Theme.of(context).btnBackground, // Set border color
                          width: 1.0,         // Set border width
                          //style: BorderStyle.solid, // Set border style (solid, dashed, etc.)
                        ),
                      ),
                      focusedBorder:const OutlineInputBorder(
                        borderSide:BorderSide(
                          color: Colors.blue, // Set border color
                          width: 1.0,         // Set border width
                          //style: BorderStyle.solid, // Set border style (solid, dashed, etc.)
                        ),
                      ),
                    ),
                                    
                    ),
                  ),
                  ),
              ],),
              ],),
            ),
            const SizedBox(width: 20,),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text('Bike No Plate.', style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).headTextColor
              ),),
              const SizedBox(height: 5,),
              Row(
              children: [
                Flexible(
                  child: SizedBox(
                    height: 32,
                    child: TextFormField(
                    controller: _bikeController,
                    style: GoogleFonts.lato(textStyle: TextStyle(
                      fontSize: 14.0, 
                      color: Theme.of(context).lightTextColor,
                      height: 1.0,
                    )),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).secondaryBackground,
                      contentPadding:const EdgeInsets.only(left: 10, right: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide:BorderSide(
                          color: Theme.of(context).btnBackground, // Set border color
                          width: 1.0,         // Set border width
                          //style: BorderStyle.solid, // Set border style (solid, dashed, etc.)
                        ),
                      ),
                      focusedBorder:const OutlineInputBorder(
                        borderSide:BorderSide(
                          color: Colors.blue, // Set border color
                          width: 1.0,         // Set border width
                          //style: BorderStyle.solid, // Set border style (solid, dashed, etc.)
                        ),
                      ),
                    ),
                                    
                    ),
                  ),
                  ),
              ],),
              ],),
            ),
            

            ],),
            const SizedBox(height: 20,),

            Row(children: [

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text('Amount', style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).headTextColor
              ),),
              const SizedBox(height: 5,),
              Row(
              children: [
                Flexible(
                  child: SizedBox(
                    height: 32,
                    child: TextFormField(
                    controller: _amountController,
                    style: GoogleFonts.lato(textStyle: TextStyle(
                      fontSize: 14.0, 
                      color: Theme.of(context).lightTextColor,
                      height: 1.0,
                    )),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).secondaryBackground,
                      contentPadding:const EdgeInsets.only(left: 10, right: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide:BorderSide(
                          color: Theme.of(context).btnBackground, // Set border color
                          width: 1.0,         // Set border width
                          //style: BorderStyle.solid, // Set border style (solid, dashed, etc.)
                        ),
                      ),
                      focusedBorder:const OutlineInputBorder(
                        borderSide:BorderSide(
                          color: Colors.blue, // Set border color
                          width: 1.0,         // Set border width
                          //style: BorderStyle.solid, // Set border style (solid, dashed, etc.)
                        ),
                      ),
                    ),
                                    
                    ),
                  ),
                  ),
              ],),
              ],),
            ),
            const SizedBox(width: 20,),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text('Battery Status', style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).headTextColor
              ),),
              const SizedBox(height: 5,),
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
                        hint: Text(_batteryStatusTitle.toString()),
                        items: _batteryStatus.map((item) {
                          return DropdownMenuItem(
                            value: item['title'].toString(),
                            child: Text(item['title'].toString()),
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          setState(() {
                            _batteryStatusTitle = newVal;
                          });
                        },
                        value: _batteryStatusTitle,
                      ),
                    ),
                  ),
                ],
              ),
              // Row(
              // children: [
              //   Flexible(
              //     child: SizedBox(
              //       height: 32,
              //       child: TextFormField(
              //       controller: _statusController,
              //       style: GoogleFonts.lato(textStyle: TextStyle(
              //         fontSize: 14.0, 
              //         color: Theme.of(context).lightTextColor,
              //         height: 1.0,
              //       )),
              //       decoration: InputDecoration(
              //         filled: true,
              //         fillColor: Theme.of(context).secondaryBackground,
              //         contentPadding:const EdgeInsets.only(left: 10, right: 10),
              //         enabledBorder: OutlineInputBorder(
              //           borderSide:BorderSide(
              //             color: Theme.of(context).btnBackground, // Set border color
              //             width: 1.0,         // Set border width
              //             //style: BorderStyle.solid, // Set border style (solid, dashed, etc.)
              //           ),
              //         ),
              //         focusedBorder:const OutlineInputBorder(
              //           borderSide:BorderSide(
              //             color: Colors.blue, // Set border color
              //             width: 1.0,         // Set border width
              //             //style: BorderStyle.solid, // Set border style (solid, dashed, etc.)
              //           ),
              //         ),
              //       ),
                                    
              //       ),
              //     ),
              //     ),
              // ],),
              ],),
            ),
            

            ],),



         Container(
          margin: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: (){
                  _updateRecord();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).btnBackground,
                  padding:const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
                child: Text('Update Record', style: TextStyle(
                  color: Theme.of(context).headTextColor
                ),),
                ),
            ],
          ),
        )

        ],
      ),)
      );
  }
}