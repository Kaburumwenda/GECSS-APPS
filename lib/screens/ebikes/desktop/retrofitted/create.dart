// ignore_for_file: prefer_final_fields, use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gecssmns/Apis/base_url.dart';
import 'package:gecssmns/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;

class CreateRecord extends StatefulWidget {
  final Function refreshUpdatedRecord;
  final List swapCenters;
  const CreateRecord({ 
    required this.refreshUpdatedRecord,
    required this.swapCenters,
    super.key});

  @override
  State<CreateRecord> createState() => _CreateRecordState();
}

class _CreateRecordState extends State<CreateRecord> {
  LocalStorage storage =  LocalStorage('usertoken');
  final _form = GlobalKey<FormState>();
  DateTime? _deploymentDate;
  DateTime? _conditionDate;

  String  _purchaseCurrency = "";
  String  _serialController = "";
  String  _capacityController = "";
  String  _purchasePrice  = "";
  String  _modelController = "";
  String  _makeController = "";
  String  _productionYear = "";
  TextEditingController  _deploymentDateController = TextEditingController();
  String  _estimatedSoh = "";
  TextEditingController  _conditionDateController = TextEditingController();
  String  _remarksController = "";


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
  }

  void callAsyncFunction() async {
    await widget.refreshUpdatedRecord();
  }


  _createRecord() async {

    var isvalid = _form.currentState!.validate();
    if (!isvalid) {
      return;
    }
    _form.currentState!.save();
      
    if(mounted){
      Navigator.of(context).pop();
    }
    var baseur = AdsType.baseurl;
    String url = '$baseur/v1/battery/create';
    var token = storage.getItem('token');
    try{
      var resp = 
          await http.post(Uri.parse(url),
          headers: {
            'Authorization': "token $token",
          },
          body:{
            'location': _swapCenterTitle,
            'code': _serialController,
            'status': _batteryStatusTitle,
            'battery_capacity':_capacityController,
            'purchase_price_currency':_purchaseCurrency,
            'purchase_price': _purchasePrice,
            'model': _modelController,
            'make': _makeController,
            'production_year': _productionYear,
            'deployment_date': _deploymentDateController.text,
            'battery_condition_date': _conditionDateController.text,
            'estimated_soh': _estimatedSoh,
            'battery_condition': _batteryConditionTitle,
            'remarks': _remarksController,
          }
        );

        var data = json.decode(resp.body);

        if(data['error'] == '0'){
         if(mounted){
          ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.success,
              title: "Record created Successfully",
              text: "The record has been added to server successfully"
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
                text: "An error occured while adding the record. Please try again later"
              )
            );
          }
        }
    } catch(err){
      print('error occurred: $err');
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
              "ADD NEW BATTERY", style: TextStyle(
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
        width: 800,
        child:Form(
          key: _form,
          child: Column(
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
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'Enter battery serial';
                        }
                        return null;
                      },
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
                      onSaved: (v) {
                        _serialController = v!;
                      },
                                      
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
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'Enter battery capacity';
                        }
                        return null;
                      },
                      initialValue: "72V 45AH",
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
                      onSaved: (v) {
                        _capacityController = v!;
                      },
                                      
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
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'Enter purchase currency';
                        }
                        return null;
                      },
                      initialValue: "USD",
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
                      onSaved: (v) {
                        _purchaseCurrency = v!;
                      },
                                      
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
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'Enter purchase price';
                        }
                        return null;
                      },
                      initialValue: "560",
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
                      onSaved: (v) {
                        _purchasePrice = v!;
                      },
                                      
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
                        child: DropdownButtonFormField(
                          isDense: true,
                          validator: (value) {
                            if (value == null) {
                              return 'Select swap center';
                            }
                            return null;
                          },
                          style:const TextStyle(
                            height: 0.1,
                          ),
                          decoration:const InputDecoration(
                            border: InputBorder.none,
                          ),
                          dropdownColor: Theme.of(context).secondaryBackground,
                          isExpanded: true,
                          //underline: Container(),
                          hint:const Text('Select swap center'),
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
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'Enter battery model';
                        }
                        return null;
                      },
                      initialValue: "Lithium Ion",
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
                      onSaved: (v) {
                        _modelController = v!;
                      },
                                      
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
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'Enter battery make';
                        }
                        return null;
                      },
                      initialValue: "Lithium Iron Phosphate (LiFePO4)",
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
                      onSaved: (v) {
                        _makeController = v!;
                      },
                                      
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
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'Enter production year';
                        }
                        return null;
                      },
                      initialValue: "2024",
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
                      onSaved: (v) {
                        _productionYear = v!;
                      },
                                      
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
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'Enter deployment date';
                        }
                        return null;
                      },
                      controller: _deploymentDateController,
                      style:const TextStyle(
                        fontSize: 16.0, 
                        color: Colors.white70,
                        height: 1.0,
                      ),
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
                        labelText: 'Select deployment date...',
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
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'Enter Estimated SOH';
                        }
                        return null;
                      },
                      initialValue: "2,000 cycles",
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
                      onSaved: (v) {
                        _estimatedSoh = v!;
                      },
                                      
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
                        height: 40,
                        child: DropdownButtonFormField(
                          isDense: true,
                          validator: (value) {
                            if (value == null) {
                              return 'Select battery condition';
                            }
                            return null;
                          },
                          style:const TextStyle(
                            height: 0.1,
                          ),
                          decoration:const InputDecoration(
                            border: InputBorder.none,
                          ),
                          dropdownColor: Theme.of(context).secondaryBackground,
                          isExpanded: true,
                          //underline: Container(),
                          hint:const Text("Select battery condition"),
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
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'Enter battery condition date';
                        }
                        return null;
                      },
                      controller: _conditionDateController,
                      style:const TextStyle(
                        fontSize: 16.0, 
                        color: Colors.white70,
                        height: 1.0,
                      ),
                      //controller: _conditionDateController,
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
                        labelText: 'Select condition date...',
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
                        height: 40,
                        child: DropdownButtonFormField(
                          isDense: true,
                          validator: (value) {
                            if (value == null) {
                              return 'Select battery status';
                            }
                            return null;
                          },
                          style:const TextStyle(
                            height: 0.1,
                          ),
                          decoration:const InputDecoration(
                            border: InputBorder.none,
                          ),

                          dropdownColor: Theme.of(context).secondaryBackground,
                          isExpanded: true,
                          //underline: Container(),
                          hint:const Text('Select battery status'),
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
                    validator: (v) {
                        if (v!.isEmpty) {
                          return 'Enter battery remarks';
                        }
                        return null;
                      },
                    initialValue: "Healthy and operational",
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
                    onSaved: (v) {
                        _remarksController = v!;
                      },
                                    
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
                    _createRecord();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).btnBackground,
                    padding:const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                  child: Text('Save Record', style: TextStyle(
                    color: Theme.of(context).headTextColor
                  ),),
                  ),
              ],
            ),
          )
          
          ],
          ),
        ),)
      );
  }
}