import 'package:flutter/material.dart';
import 'package:gecssmns/Models/mpesa_transactions.dart';
import 'package:gecssmns/main.dart';
import 'package:google_fonts/google_fonts.dart';

class MobileRecordView extends StatelessWidget {
  final MpesaTransactions recordData;
  const MobileRecordView({ required this.recordData, super.key});

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
        color: Theme.of(context).secondaryBackground,
        child: Image.asset('assets/images/logo.png', height: 50,)
        ),

      content: Container(
        padding:const EdgeInsets.all(10),
        color: Theme.of(context).secondaryBackground,
        height: 500,
        // width: 700,
        child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text('TransactionType', style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).lightTextColor
          ),),
                    
          Row(
            children: [
              Flexible(
                child: SizedBox(
                  height: 32,
                  child: TextFormField(
                    initialValue: recordData.transactionType,
                  style: GoogleFonts.teko(textStyle: TextStyle(
                    fontSize: 16.0, 
                    color: Theme.of(context).headTextColor,
                    height: 1.0,
                  )),
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
                  ),
                                  
                  ),
                ),
                ),
            ],
          ),
          const SizedBox(height: 20,),
          
          Text('TransID', style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).lightTextColor
          ),),
                    
          Row(
            children: [
              Flexible(
                child: SizedBox(
                  height: 32,
                  child: TextFormField(
                    initialValue: recordData.transID ,
                  style: GoogleFonts.teko(textStyle: TextStyle(
                    fontSize: 16.0, 
                    color: Theme.of(context).headTextColor,
                    height: 1.0,
                  )),
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
                  ),
                                  
                  ),
                ),
                ),
            ],
          ),
          const SizedBox(height: 20,),
          
          
          Text('FirstName', style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).lightTextColor
          ),),
                    
          Row(
            children: [
              Flexible(
                child: SizedBox(
                  height: 32,
                  child: TextFormField(
                    initialValue: recordData.firstName ,
                  style: GoogleFonts.teko(textStyle: TextStyle(
                    fontSize: 16.0, 
                    color: Theme.of(context).headTextColor,
                    height: 1.0,
                  )),
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
                  ),
                                  
                  ),
                ),
                ),
            ],
          ),
          const SizedBox(height: 20,),


          Text('Swap Center ID / Acc No', style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).lightTextColor
          ),),
          Row(
            children: [
              Flexible(
                child: SizedBox(
                  height: 32,
                  child: TextFormField(
                    initialValue: recordData.billRefNumber,
                  style: GoogleFonts.teko(textStyle: TextStyle(
                    fontSize: 16.0, 
                    color: Theme.of(context).lightTextColor,
                    height: 1.0,
                  )),
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
                  ),
                                  
                  ),
                ),
                ),
            ],
          ),
          const SizedBox(height: 20,),
          
          Text('Trans Amount', style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).lightTextColor
          ),
          ),              
          Row(
            children: [
              Flexible(
                child: SizedBox(
                  height: 32,
                  child: TextFormField(
                    initialValue: recordData.transAmount ,
                  style: GoogleFonts.teko(textStyle: TextStyle(
                    fontSize: 16.0, 
                    color: Theme.of(context).headTextColor,
                    height: 1.0,
                  )),
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
                  ),
                                  
                  ),
                ),
                ),
            ],
          ),
          const SizedBox(height: 20,),
          
          
          Text('MSISDN', style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).lightTextColor
          ),
          ),
                    
          Row(
            children: [
              Flexible(
                child: SizedBox(
                  height: 32,
                  child: TextFormField(
                    initialValue: recordData.mSISDN ,
                  style: GoogleFonts.teko(textStyle: TextStyle(
                    fontSize: 16.0, 
                    color: Theme.of(context).headTextColor,
                    height: 1.0,
                  )),
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
                  ),
                                  
                  ),
                ),
                ),
            ],
          ),

          const SizedBox(height: 20,),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(onPressed: (){
                Navigator.of(context).pop();
              }, 
              icon:const Icon(Icons.cancel, size: 30,)
              ),
            ],
          )

        ],
      ),)
      );
  }
}