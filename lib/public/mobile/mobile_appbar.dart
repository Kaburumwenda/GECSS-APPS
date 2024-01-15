import 'package:flutter/material.dart';
import 'package:gecssmns/appPreferences/app_preferences.dart';
import 'package:gecssmns/main.dart';
import 'package:get/get.dart';

class MobileAppbar extends StatelessWidget {
  const MobileAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryBackground,
      // automaticallyImplyLeading: false,
      title: const Text("GECSS", style: TextStyle(fontSize: 14.0),),
      actions: [
        IconButton(
        onPressed: (){
          Get.changeThemeMode(
            AppPreferences.isModeDark ? ThemeMode.light : ThemeMode.dark,
          );

          AppPreferences.isModeDark = !AppPreferences.isModeDark;
        },
          icon: Icon(
            Icons.brightness_2_outlined , 
            color: Theme.of(context).lightTextColor
            ),
        ),
      ],
    );
  }
}