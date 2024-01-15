import 'package:flutter/material.dart';
import 'package:gecssmns/appPreferences/app_preferences.dart';
import 'package:gecssmns/main.dart';
import 'package:get/get.dart';

class DesktopTopNav extends StatelessWidget {
  const DesktopTopNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.only(left: 20, right: 20, top: 5.0),
      child: Row(
        children: [
          const Text(""),
          const Spacer(),

          ElevatedButton.icon(
            onPressed: (){}, 
            icon:Icon(Icons.person, color: Theme.of(context).lightTextColor,), 
            label:const Text(""),
            style: IconButton.styleFrom(
              backgroundColor:Theme.of(context).primaryBackground,
              padding:const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1),
              ),
            ),
            ),

            const SizedBox(width: 20,),

            ElevatedButton.icon(
            onPressed: (){
              Get.changeThemeMode(
                AppPreferences.isModeDark ? ThemeMode.light : ThemeMode.dark,
              );

              AppPreferences.isModeDark = !AppPreferences.isModeDark;
            }, 
            icon:Icon(Icons.brightness_2_outlined, color: Theme.of(context).lightTextColor, ), 
            label:const Text(""),
            style: IconButton.styleFrom(
              backgroundColor:Theme.of(context).primaryBackground,
              padding:const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1),
              ),
            ),
            ),

        ],
        ),
    );
  }
}