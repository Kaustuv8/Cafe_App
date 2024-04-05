import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

final auth = FirebaseAuth.instance;
final db = FirebaseFirestore.instance;


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextStyle loginTextStyle = const TextStyle(color: Colors.white, fontSize: 18);

  final _formKey = GlobalKey<FormState>();

  String _userName = "";

  String _password = "";

  Future<void> signin() async{
    _userName = "$_userName@cafe.com";
    try {
      await auth.createUserWithEmailAndPassword(email: _userName, password: _password);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Sign Up Successful"))
      );
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message!))
      );
    }    
  }

  Future<void> login() async{
    _userName = "$_userName@cafe.com";
    try {
      await auth.signInWithEmailAndPassword(
        email: _userName, password: _password);
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message!))
      );
    }    
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 700,
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Card(
                      color: const Color.fromARGB(69, 255, 255, 255),
                      margin: const EdgeInsets.fromLTRB(10,0,20,50),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const Text("Swift", style: TextStyle(fontSize: 52, color: Colors.white)),
                              const Text("Cafe", style: TextStyle(fontSize:42, color:Colors.white)),
                              const Text('"Latte but never late"', style: TextStyle(fontSize: 16, color: Color.fromARGB(111, 255, 255, 255))),
                              TextFormField(
                                decoration: InputDecoration(
                                  label: Text("Username", style: loginTextStyle,),
                                ),
                                validator: (value) {
                                  if(value==""){
                                    return "Username cannot be empty.";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.name,
                                onSaved: (value){
                                  _userName = value!;
                                },              
                              ),
                              const SizedBox(height: 5,),
                              TextFormField(
                                decoration: InputDecoration(
                                  label: Text("Password", style: loginTextStyle),
                                ),
                                validator: (value) {
                                  if(value != null && value.length < 6){
                                    return "Password too short";
                                  }
                                  return null;
                                },
                                onSaved: (value){
                                  _password = value!;
                                },
                              ),
                              const SizedBox(height: 30,),
                              SizedBox(
                                width: 200,
                                child: FloatingActionButton(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
                                  backgroundColor: Colors.transparent,
                                  child: Ink(
                                    width: double.maxFinite,
                                    height: double.maxFinite,
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: FractionalOffset.topLeft,
                                        end: FractionalOffset.bottomRight,
                                        colors: [
                                          Color.fromARGB(255, 45, 13, 13),
                                          Color.fromARGB(255, 76, 43, 31),
                                          Color.fromARGB(255, 155, 101, 82),
                                        ],
                                      ),
                                      borderRadius: const BorderRadius.all(Radius.circular(80)),
                                    ),
                                    child: Center(child: Text("Login", style: loginTextStyle,))),
                                  onPressed:(){
                                    login();
                                  }),
                              ),
                              const SizedBox(height: 30,),
                              SizedBox(
                                width: 200,
                                child: OutlinedButton(
                                  child: Text("Sign Up!", style: loginTextStyle,),
                                  onPressed: (){}),
                              ),
                              TextButton(
                                onPressed: (){
                                  signin();
                                }, 
                                child: const Text("Privacy Policy", style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}