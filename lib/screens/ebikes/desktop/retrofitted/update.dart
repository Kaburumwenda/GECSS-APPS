// ignore_for_file: prefer_final_fields, use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gecssmns/Apis/base_url.dart';
import 'package:gecssmns/Models/motorcycle_retro.dart';
import 'package:gecssmns/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

class RecordUpdate extends StatefulWidget {
  final MotorcycleRetro recordData;
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
  DateTime? _conditionDate;


  TextEditingController  _numberplateController = TextEditingController();
  TextEditingController  _chassisnoController = TextEditingController(); 
  TextEditingController  _enginenoController  = TextEditingController();
  TextEditingController  _motornoController  = TextEditingController();
  TextEditingController  _modelController = TextEditingController();
  TextEditingController  _makeController = TextEditingController();
  TextEditingController  _clientController = TextEditingController();
  TextEditingController  _clientphoneController = TextEditingController();
  TextEditingController  _countryController = TextEditingController();
  TextEditingController  _conditionController = TextEditingController();
  TextEditingController  _conditionDateController = TextEditingController();
  TextEditingController  _supervisorController = TextEditingController();
  TextEditingController  _approvalController = TextEditingController();
  TextEditingController  _remarksController = TextEditingController();


  var _ebikeStatusTitle;

  List _ebikeStatus = [
    {
      "title":"Active"
    },
    {
      "title":"Reprocessed"
    },
    {
      "title":"Others"
    },
  ];





  @override
  void initState() {
    super.initState();
    setState(() {
      _numberplateController.text = widget.recordData.numberPlate.toString();
      _chassisnoController.text = widget.recordData.chassisNo.toString();
      _enginenoController.text = widget.recordData.engineNo.toString();
      _motornoController.text = widget.recordData.motorNo.toString();
      _modelController.text = widget.recordData.model.toString();
      _makeController.text = widget.recordData.make.toString();
      _clientController.text = widget.recordData.client.toString();
      _clientphoneController.text = widget.recordData.clientPhone.toString();
      _countryController.text = widget.recordData.country.toString();
      _conditionController.text = widget.recordData.condition.toString();
      _conditionDateController.text = widget.recordData.conditionDate.toString();
      _supervisorController.text = widget.recordData.supervisor.toString();
      _approvalController.text = widget.recordData.approval.toString();
      _remarksController.text = widget.recordData.remarks.toString();
      _ebikeStatusTitle = widget.recordData.status;
    });
  }

  void callAsyncFunction() async {
    await widget.refreshUpdatedRecord();
  }


  _updateRecord() async {
      
      if(_chassisnoController.text.length >= 10){
        if(mounted){
          Navigator.of(context).pop();
        }
        var baseur = AdsType.baseurl;
        String url = '$baseur/v1/motorbike_retro/update/${widget.recordData.id}';
        var token = storage.getItem('token');
        var resp = 
          await http.post(Uri.parse(url),
          headers: {
            'Authorization': "token $token",
          },
          body:{
            'number_plate': _numberplateController.text,
            'chassis_no': _chassisnoController.text,
            'engine_no':_enginenoController.text,
            'motor_no':_motornoController.text,
            'model': _modelController.text,
            'make': _makeController.text,
            'client': _clientController.text,
            'client_phone': _clientphoneController.text,
            'country': _countryController.text,
            'condition': _conditionController.text,
            'condition_date': _conditionDateController.text,
            'supervisor': _supervisorController.text,
            'approval': _approvalController.text,
            'remarks': _remarksController.text,
            'status': _ebikeStatusTitle,
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
          title: 'Please Note battery serial must be atleast 14 letters ',
          textColor: Colors.white,
          backgroundColor: Colors.red,
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: radius(5)),
          margin:const EdgeInsets.all(16),
          duration: 6.seconds,
        );
      }
  }



  Future<void> _ebikeConditionDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _conditionDate) {
      setState(() {
        _conditionDate = picked;
         _conditionDateController.text = "${picked.toLocal()}".split(' ')[0];
      });
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
              "UPDATE EBIKE DETAILS", style: TextStyle(
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
        height: 540,
        width: 800,
        child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(children: [

             Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text('Plate Number', style: TextStyle(
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
                   controller: _numberplateController,
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
              Text('Chassis Number', style: TextStyle(
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
                    controller: _chassisnoController,
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
              Text('Engine No.', style: TextStyle(
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
                    controller: _enginenoController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                    ],
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
              Text('Motor No.', style: TextStyle(
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
                    controller: _motornoController,
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
              Text('Model', style: TextStyle(
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
                    controller: _modelController,
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
              Text('Make', style: TextStyle(
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
                    controller: _makeController,
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
              Text('Client', style: TextStyle(
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
                    controller: _clientController,
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
              Text('Client Country', style: TextStyle(
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
                    controller: _countryController,
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
              Text('Client Phone', style: TextStyle(
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
                    controller: _clientphoneController,
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
              Text('Ebike Condition', style: TextStyle(
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
                    controller: _conditionController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                    ],
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
              Text('Condition Date', style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).headTextColor
              ),),
              const SizedBox(height: 5,),
              Row(
              children: [
                Flexible(
                  child: SizedBox(
                    //width: 200,
                    height: 35,
                    child: TextFormField(
                    //autofocus: true,
                    style:const TextStyle(
                      fontSize: 16.0, 
                      color: Colors.white70,
                      height: 1.0,
                    ),
                   controller: _conditionDateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).secondaryBackground,
                      contentPadding:const EdgeInsets.only(left: 10, right: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide:BorderSide(
                          color: Theme.of(context).btnBackground, // Set border color
                          width: 1.0, 
                        ),
                      ),
                      focusedBorder:const OutlineInputBorder(
                        borderSide:BorderSide(
                          color: Colors.blue, // Set border color
                          width: 1.0, 
                        ),
                      ),
                      //labelText: 'Select start date...',
                      labelStyle:const TextStyle(fontSize: 12),
                      helperStyle: const TextStyle(color: Colors.white),
                      suffixIcon: IconButton(
                        icon:const Icon(Icons.calendar_today, size: 20,),
                        onPressed: () => _ebikeConditionDate(context),
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
              Text('Ebike Status', style: TextStyle(
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
                        hint: Text(_ebikeStatusTitle.toString()),
                        items: _ebikeStatus.map((item) {
                          return DropdownMenuItem(
                            value: item['title'].toString(),
                            child: Text(item['title'].toString()),
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          setState(() {
                            _ebikeStatusTitle = newVal;
                          });
                        },
                        value: _ebikeStatusTitle,
                      ),
                    ),
                  ),
                ],
              ),
              ],),
            ),
            
            ],),
            const SizedBox(height: 20,),


            Row(children: [

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text('Supervisor', style: TextStyle(
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
                    controller: _supervisorController,
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
              Text('Approved By.', style: TextStyle(
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
                    controller: _approvalController,
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
              Text('Remarks', style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).headTextColor
              ),),
              const SizedBox(height: 5,),
              Row(
              children: [
                Flexible(
                  child: TextFormField(
                  controller: _remarksController,
                  minLines: 2,
                  maxLines: 10,
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
              ],),
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