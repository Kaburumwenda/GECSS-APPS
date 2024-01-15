import 'package:flutter/material.dart';
import 'package:gecssmns/appPreferences/app_preferences.dart';
import 'package:gecssmns/screens/screens.dart';
import 'package:get/get.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await AppPreferences.initHive();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: 'GECSS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      
      themeMode: AppPreferences.isModeDark ? ThemeMode.dark : ThemeMode.light,

      darkTheme: ThemeData(
          brightness: Brightness.dark
      ),

      home: const LoginScreen()// HomeScreen(), // LoginScreen()
    );
  }
}


extension AppTheme on ThemeData
{
  Color get lightTextColor => AppPreferences.isModeDark ? Colors.white70 : Colors.black54;
  Color get headTextColor => AppPreferences.isModeDark ? Colors.white : Colors.black;
  Color get thinTextColor => AppPreferences.isModeDark ? Colors.white54 : Colors.black54;
  Color get bottomNavigationColor => AppPreferences.isModeDark ? Colors.white12 : Colors.grey[200]!;
  Color get appBarNavigationColor => AppPreferences.isModeDark ? Colors.white12 : Colors.grey[200]!;
  Color get speedNavigationColor => AppPreferences.isModeDark ? Colors.white12 : Colors.grey[200]!;

  //final
  Color get primaryBackground => AppPreferences.isModeDark ? const Color(0xFF141414) : Colors.grey[200]!;
  Color get secondaryBackground => AppPreferences.isModeDark ? const Color(0xFF22242a) : Colors.white;
  Color get btnBackground => AppPreferences.isModeDark ? const Color(0xFF4d4d4d) : const Color(0xFFE5E5E5);
  Color get iconsColors => AppPreferences.isModeDark ? const Color(0xFF045cc8) : Colors.black54;
  Color get loadingColors => AppPreferences.isModeDark ? const Color(0xFFf2f2f2) : Colors.blue;
  Color get modalHeader => AppPreferences.isModeDark ? Colors.white : Colors.black;
  Color get modalHeaderTitle => AppPreferences.isModeDark ? Colors.black : Colors.white;
  Color get modalSubmitBtn => AppPreferences.isModeDark ? Colors.black : Colors.white;

}
// #24262C