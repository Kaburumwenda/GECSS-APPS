// ignore_for_file: prefer_final_fields, use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gecssmns/Apis/base_url.dart';
import 'package:gecssmns/Models/battery.dart';
import 'package:gecssmns/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

class RecordUpdate extends StatefulWidget {
  final BatteryModel recordData;
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
  DateTime? _deploymentDate;
  DateTime? _conditionDate;

  TextEditingController  _purchaseCurrency = TextEditingController();
  TextEditingController  _serialController = TextEditingController();
  TextEditingController  _capacityController = TextEditingController();
  TextEditingController  _purchasePrice  = TextEditingController();
  TextEditingController  _modelController = TextEditingController();
  TextEditingController  _makeController = TextEditingController();
  TextEditingController  _productionYear = TextEditingController();
  TextEditingController  _deploymentDateController = TextEditingController();
  TextEditingController  _estimatedSoh = TextEditingController();
  TextEditingController  _conditionDateController = TextEditingController();
  TextEditingController  _remarksController = TextEditingController();


  var _swapCenterTitle;
  var _batteryStatusTitle;
  var _batteryConditionTitle;

  List _batteryStatus = [
    {
      "title":"Issued"
    },
    {
      "title":"Depleted"
    },
    {
      "title":"Charged"
    },
    {
      "title":"Charging"
    },
  ];


  List _batteryCondition = [
    {
      "title":"Healthy"
    },
    {
      "title":"Repaired & Healthy"
    },
    {
      "title":"Malfunction"
    },
    {
      "title":"Out of Service"
    },
    {
      "title":"Others"
    },
  ];


  @override
  void initState() {
    super.initState();
    setState(() {
      _serialController.text = widget.recordData.code.toString();
      _swapCenterTitle = widget.recordData.location;
      _batteryStatusTitle = widget.recordData.status;
      _batteryConditionTitle = widget.recordData.batteryCondition;
      _capacityController.text = widget.recordData.batteryCapacity.toString();
      _purchaseCurrency.text = widget.recordData.purchasePriceCurrency.toString();
      _purchasePrice.text = widget.recordData.purchasePrice.toString();
      _modelController.text = widget.recordData.model.toString();
      _makeController.text = widget.recordData.make.toString();
      _productionYear.text = widget.recordData.productionYear.toString();
      _deploymentDateController.text = widget.recordData.deploymentDate.toString();
      _conditionDateController.text = widget.recordData.batteryConditionDate.toString();
      _estimatedSoh.text = widget.recordData.estimatedSoh.toString();
      _remarksController.text = widget.recordData.remarks.toString();
    });
  }

  void callAsyncFunction() async {
    await widget.refreshUpdatedRecord();
  }


  _updateRecord() async {
      
      if(_serialController.text.length >= 14){
        if(mounted){
          Navigator.of(context).pop();
        }
        var baseur = AdsType.baseurl;
        String url = '$baseur/v1/battery/update/${widget.recordData.id}';
        var token = storage.getItem('token');
        var resp = 
          await http.post(Uri.parse(url),
          headers: {
            'Authorization': "token $token",
          },
          body:{
            'location': _swapCenterTitle,
            'code': _serialController.text,
            'status': _batteryStatusTitle,
            'battery_capacity':_capacityController.text,
            'purchase_price_currency':_purchaseCurrency.text,
            'purchase_price': _purchasePrice.text,
            'model': _modelController.text,
            'make': _makeController.text,
            'production_year': _productionYear.text,
            'deployment_date': _deploymentDateController.text,
            'battery_condition_date': _conditionDateController.text,
            'estimated_soh': _estimatedSoh.text,
            'battery_condition': _batteryConditionTitle,
            'remarks': _remarksController.text,
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


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _deploymentDate) {
      setState(() {
        _deploymentDate = picked;
         _deploymentDateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }


  Future<void> _batteryConditionDate(BuildContext context) async {
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
              "UPDATE BATTERY DETAILS", style: TextStyle(
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
        height: 480,
        width: 700,
        child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(children: [

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
                    controller: _serialController,
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
              Text('Capacity', style: TextStyle(
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
                    controller: _capacityController,
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
              Text('Purchase currency', style: TextStyle(
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
                    controller: _purchaseCurrency,
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
              Text('Purchase Price.', style: TextStyle(
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
                    controller: _purchasePrice,
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
              Text('Production Year', style: TextStyle(
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
                    controller: _productionYear,
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
              Text('Deployment Date', style: TextStyle(
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
                    controller: _deploymentDateController,
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
                        onPressed: () => _selectDate(context),
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
              Text('Estimated SOH', style: TextStyle(
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
                    controller: _estimatedSoh,
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
              Text('Battery Condition', style: TextStyle(
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
                        hint: Text(_batteryConditionTitle.toString()),
                        items: _batteryCondition.map((item) {
                          return DropdownMenuItem(
                            value: item['title'].toString(),
                            child: Text(item['title'].toString()),
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          setState(() {
                            _batteryConditionTitle = newVal;
                          });
                        },
                        value: _batteryConditionTitle,
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
              Text('Battery Condition Date', style: TextStyle(
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
                        onPressed: () => _batteryConditionDate(context),
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
              ],),
            ),
            
            ],),
            const SizedBox(height: 20,),

            Row(children: [

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text('Battery Remarks', style: TextStyle(
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