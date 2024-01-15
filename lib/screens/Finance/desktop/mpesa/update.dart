// ignore_for_file: prefer_final_fields, use_build_context_synchronously

import 'dart:convert';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:gecssmns/Apis/base_url.dart';
import 'package:gecssmns/Models/mpesa_transactions.dart';
import 'package:gecssmns/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

class RecordUpdate extends StatefulWidget {
  final MpesaTransactions recordData;
  final Function refreshUpdatedRecord;
  const RecordUpdate({ 
    required this.recordData,
    required this.refreshUpdatedRecord,
    super.key});

  @override
  State<RecordUpdate> createState() => _RecordUpdateState();
}

class _RecordUpdateState extends State<RecordUpdate> {
  LocalStorage storage =  LocalStorage('usertoken');
  TextEditingController  _agentIDController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _agentIDController.text = widget.recordData.billRefNumber.toString();
    });
  }

  void callAsyncFunction() async {
    await widget.refreshUpdatedRecord();
  }


  _updateRecord() async {
      
      if(_agentIDController.text.length > 2){
        if(mounted){
          Navigator.of(context).pop();
        }
        var baseur = AdsType.baseurl;
        String url = '$baseur/v1/mpesa/update/${widget.recordData.id}';
        var token = storage.getItem('token');
        var resp = 
          await http.post(Uri.parse(url),
          headers: {
            'Authorization': "token $token",
          },
          body:{
            'billRefNumber': _agentIDController.text,
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
          title: 'Swap Center or Account No. cannot be blank!!!',
          textColor: Colors.white,
          backgroundColor: Colors.red,
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: radius(5)),
          margin:const EdgeInsets.all(16),
          duration: 3.seconds,
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
              "UPDATE MPESA TRANSACTION DETAILS", style: TextStyle(
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
        height: 140,
        width: 400,
        child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

         Text('Swap Center ID / Acc No', style: TextStyle(
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
                 //initialValue: widget.recordData.billRefNumber,
                 controller: _agentIDController,
                 style: GoogleFonts.lato(textStyle: TextStyle(
                   fontSize: 14.0, 
                   color: Theme.of(context).lightTextColor,
                   height: 1.0,
                 )),
                 decoration: InputDecoration(
                   filled: true,
                   // fillColor: Theme.of(context).primaryBackground,
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
           ],
         ),

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