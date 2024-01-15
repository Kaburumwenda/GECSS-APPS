import 'package:flutter/material.dart';
import 'package:gecssmns/Models/battery_swaps.dart';
import 'package:gecssmns/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class RecordView extends StatelessWidget {
  final BatterySwaps recordData;
  const RecordView({ required this.recordData, super.key});

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
              "BATTERY SWAP DETAILS", style: TextStyle(
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
        height: 180,
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
                    Flexible(
                      child: SizedBox(
                        height: 32,
                        child: TextFormField(
                          initialValue: recordData.source,
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
                  ],
                ),
                  ],),
            ),
            const SizedBox(width: 20,),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text('Bike No.', style: TextStyle(
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
                          initialValue: recordData.bikeNo ,
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
                  ],
                ),
                  ],),
            ),
            const SizedBox(width: 20,),


            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text('Battery Code', style: TextStyle(
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
                          initialValue: recordData.batteryCode1 ,
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
                  ],
                ),
                  ],),
            ) 
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
                          initialValue: recordData.amount.toString(),
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
                  ],
                ),
                  ],),
            ),
            const SizedBox(width: 20,),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text('TimeStamp', style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).headTextColor
                ),
                ), 
                const SizedBox(height: 5,),             
                Row(
                  children: [
                    Flexible(
                      child: SizedBox(
                        height: 32,
                        child: TextFormField(
                          initialValue: DateFormat('E, d MMM yyyy HH:mm:ss').format(
                                        DateTime.parse(recordData.createdAt.toString())),
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
                  ],
                ),
                  ],),
            ),
            const SizedBox(width: 20,),


            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text('Status', style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).headTextColor
                ),
                ),
                const SizedBox(height: 5,),
              
                Row(
                  children: [
                    Flexible(
                      child: SizedBox(
                        height: 32,
                        child: TextFormField(
                          initialValue: recordData.status ,
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
                  ],
                ),
                  ],),
            ) 
          ],),

        ],
      ),)
      );
  }
}