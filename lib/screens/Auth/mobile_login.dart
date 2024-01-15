// ignore_for_file: use_build_context_synchronously, prefer_final_fields

import 'dart:convert';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:gecssmns/Apis/base_url.dart';
import 'package:gecssmns/main.dart';
import 'package:gecssmns/screens/home/home_screen.dart';
import 'package:gecssmns/widgets/progress_dialog.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;

class MobileLoginScreen extends StatefulWidget {
  const MobileLoginScreen({super.key});

  @override
  State<MobileLoginScreen> createState() => _MobileLoginScreenState();
}

class _MobileLoginScreenState extends State<MobileLoginScreen> {

  LocalStorage storage = LocalStorage('usertoken');
  String _username = '';
  String _password = '';

  final _form = GlobalKey<FormState>();

  bool _isObscure = true;

  _loginNow() async {
    var isvalid = _form.currentState!.validate();
    if (!isvalid) {
      return;
    }
    _form.currentState!.save();
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext c)
      {
        return ProgressDialog(message: "Autheticating, Please wait...",);
      }
    );

    var baseur = AdsType.baseurl;
    String url = '$baseur/v1/auth/login';

    http.Response response = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({
          "username": _username, 
          "password": _password,
          }));
    var data = json.decode(response.body) as Map;

    if (data.containsKey("token")) {
        storage.setItem("token", data['token']);

        Navigator.of(context).pop();

        Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => const HomeScreen(),
        ));
      }

      if(data['non_field_errors'][0].length > 0 ){

        Navigator.of(context).pop();

        var loginErr = data['non_field_errors'][0];
        ArtSweetAlert.show(
          barrierDismissible: false,
          context: context,
          artDialogArgs: ArtDialogArgs(
            title: loginErr,
            confirmButtonText: "Ok",
            type: ArtSweetAlertType.danger
          ));
      }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryBackground,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin:const EdgeInsets.fromLTRB(20, 0, 20, 40),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Image.asset("assets/images/logo.png", height: 100,),
            const SizedBox(height: 40,),
            Container(
              padding:const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * .80,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryBackground,
                borderRadius: BorderRadius.circular(10.0)
              ),
              child: Form(
                key: _form,
                child: Column(children: [
                   TextFormField(
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'Enter Your Username';
                        }
                        return null;
                      },
                      
                      decoration:InputDecoration(
                         border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    //fillColor: Colors.orange[50],
                       // filled: true,
                        hintText: "Username",
                        labelText: 'Username'
                      ),
                      onSaved: (v) {
                        _username = v!;
                      },
                    ),
                    const SizedBox(height: 30,),
                    TextFormField(
                      //keyboardType: TextInputType.number,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'Enter your password';
                        }
                        return null;
                      },
                      obscureText: _isObscure,
                      decoration:InputDecoration(
                         border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: "Password",
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        onPressed: (){
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        }, 
                        icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off, color: Colors.purple, size: 25,)
                        )
                      ),
                      onSaved: (v) {
                        _password = v!;
                      },
                    ),
                      
                    const SizedBox(height: 50,),
                      
                      
                 Row(children: [
                  Expanded(
                    child:ElevatedButton(
                      onPressed: () {
                       _loginNow();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:Theme.of(context).btnBackground ,
                        padding:const EdgeInsets.symmetric(horizontal: 1, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                      child: Text("Login", style: TextStyle(
                        fontSize: 20.0,
                        color: Theme.of(context).headTextColor
                        ),),
                    ),
                    )
                ],),
                ],)
                ),
            )
          ],),
        ),
      ),
    ));
  }
}