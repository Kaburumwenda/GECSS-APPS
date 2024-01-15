import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gecssmns/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class StatisticTotalsCard extends StatelessWidget {

   String title = '';
   int totals = 0;
   Color iconColorbg;
   Color iconColor;
   IconData iconType;

   StatisticTotalsCard({
    super.key,
    required this.title,
    required this.totals,
    required this.iconColor,
    required this.iconColorbg,
    required this.iconType,
    });


  @override
  Widget build(BuildContext context) {

    final formatter = NumberFormat('#,###', 'en_US');

    return  Container(
      height: 40,
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      decoration: BoxDecoration(
        color: Theme.of(context).secondaryBackground,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color:iconColorbg,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child:  FaIcon(iconType, size: 15, color: iconColor, ),
              ),
              //Icon(Icons.more_vert, color: Theme.of(context).colorScheme.onSecondary )
            ],
          ),
          const SizedBox(height: 5,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Text(
          title,
          style: GoogleFonts.teko(textStyle: TextStyle(
          color: Theme.of(context).lightTextColor,
          letterSpacing: 1.0,
          fontSize: 16
        )),
        ),
        const Spacer(),
        Text(formatter.format(totals), style: GoogleFonts.teko(textStyle: TextStyle(
          color: const Color(0xFF1ccaa7).withOpacity(0.6),
          fontSize: 20
        )) ),
        const SizedBox(width: 10,)
        ],),

      ],),
    );
  }
}