// ignore_for_file: prefer_final_fields, use_build_context_synchronously

import 'dart:convert';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:gecssmns/Apis/base_url.dart';
import 'package:gecssmns/Models/mpesa_transactions.dart';
import 'package:gecssmns/main.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;

class MobileRecordDelete extends StatefulWidget {
  final MpesaTransactions recordData;
  final Function refreshUpdatedRecord;
  const MobileRecordDelete({ 
    required this.recordData,
    required this.refreshUpdatedRecord,
    super.key});

  @override
  State<MobileRecordDelete> createState() => _MobileRecordDeleteState();
}

class _MobileRecordDeleteState extends State<MobileRecordDelete> {
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


  _deleteRecord() async {
    if(mounted){
        Navigator.of(context).pop();
      }
      var baseur = AdsType.baseurl;
      String url = '$baseur/v1/mpesa/soft_delete/${widget.recordData.id}';
      var token = storage.getItem('token');
      var resp = 
        await http.get(Uri.parse(url),
        headers: {
          'Authorization': "token $token",
        },
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
        padding:const EdgeInsets.fromLTRB(20, 0, 20, 0),
        //color: Theme.of(context).modalHeader,
        child: Image.asset("assets/images/logo.png", height: 80,)
        ),

      content: Container(
        padding:const EdgeInsets.all(10),
        height: 250,
        child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

         Text('Are you sure? you want to delete selected record!', style: TextStyle(
           fontSize: 16,
           color: Theme.of(context).headTextColor
         ),),
         const SizedBox(height: 20,),

         Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.start,
             children: [
             Text('TransID:', style: TextStyle(color: Theme.of(context).lightTextColor, fontSize: 14),),
             const SizedBox(width: 10,),
             Text(widget.recordData.transID.toString(), style: TextStyle(
               color: Theme.of(context).headTextColor, 
               fontSize: 14,
               ))
           ],),
           Row(
             mainAxisAlignment: MainAxisAlignment.start,
             children: [
             Text('REF ID:', style: TextStyle(color: Theme.of(context).lightTextColor, fontSize: 14),),
             const SizedBox(width: 10,),
             Text(widget.recordData.billRefNumber.toString(), style: TextStyle(
               color: Theme.of(context).headTextColor, 
               fontSize: 14,
               ))
           ],),
           Row(
             mainAxisAlignment: MainAxisAlignment.start,
             children: [
             Text('Name:', style: TextStyle(color: Theme.of(context).lightTextColor, fontSize: 14),),
             const SizedBox(width: 10,),
             Text(widget.recordData.firstName.toString(), style: TextStyle(
               color: Theme.of(context).headTextColor, 
               fontSize: 14,
               ))
           ],),
           Row(
             mainAxisAlignment: MainAxisAlignment.start,
             children: [
             Text('TransAmount:', style: TextStyle(color: Theme.of(context).lightTextColor, fontSize: 14),),
             const SizedBox(width: 10,),
             Text(widget.recordData.transAmount.toString(), style: TextStyle(
               color: Theme.of(context).headTextColor, 
               fontSize: 14,
               ))
           ],),
         ],),

         const SizedBox(height: 20,),
        
         Row(
           children: [
             Expanded(
               child: ElevatedButton(
                 onPressed: (){
                   _deleteRecord();
                 },
                 style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.red,
                   padding:const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(1),
                   ),
                 ),
                 child:const Text('Yes! Delete', style: TextStyle(
                   color: Colors.white
                 ),),
               ),
             ),
             const SizedBox(width: 40,),
         
             Expanded(
               child: ElevatedButton(
                 onPressed: (){
                   Navigator.of(context).pop();
                 },
                 style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.blue,
                   padding:const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(1),
                   ),
                 ),
                 child:const Text(' No ', style: TextStyle(
                   color: Colors.white,
                 ),),
               ),
             ),
           ],
         )

        ],
      ),)
      );
  }
}