import 'package:flutter/material.dart';
import 'package:gecssmns/Models/battery.dart';
import 'package:gecssmns/main.dart';
import 'package:google_fonts/google_fonts.dart';

class RecordView extends StatelessWidget {
  final BatteryModel recordData;
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
              "BATTERY DETAILS", style: TextStyle(
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
        height: 420,
        width: 700,
        child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(children: [

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text('Serial', style: TextStyle(
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
                          initialValue: recordData.code,
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
                          initialValue: recordData.batteryCapacity ,
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
                Text('Purchase Price', style: TextStyle(
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
                          initialValue: '${recordData.purchasePriceCurrency }  ${recordData.purchasePrice.toString()}' ,
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
                          initialValue: recordData.location.toString(),
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
                Text('Model', style: TextStyle(
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
                          initialValue: recordData.model.toString(),
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
                Text('Make', style: TextStyle(
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
                          initialValue: recordData.make ,
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
                          initialValue: recordData.productionYear.toString(),
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
                Text('Deployment Date', style: TextStyle(
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
                          initialValue: recordData.deploymentDate.toString(),
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
                Text('Estimated SOH', style: TextStyle(
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
                          initialValue: recordData.estimatedSoh ,
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
                Text('Battery Condition', style: TextStyle(
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
                          initialValue: recordData.batteryCondition.toString(),
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
                Text('Battery Condition Date', style: TextStyle(
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
                          initialValue: recordData.batteryConditionDate.toString(),
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
                Text('Battery Status', style: TextStyle(
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
                          initialValue: recordData.status,
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
                Text('Remarks', style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).headTextColor
                ),),
                const SizedBox(height: 5,),
                Row(
                  children: [
                    Flexible(
                      child: SizedBox(
                        child: TextFormField(
                          initialValue: recordData.remarks.toString(),
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
                      ),
                  ],
                ),
                  ],),
            ),

          ],),

          
        ],
      ),)
      );
  }
}