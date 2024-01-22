
import 'package:bus_ticket_booking_app/models/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



//Function to move to login page
moveTologinpage(BuildContext context)async{
  if(_formkey.currentState!.validate()){
    setState(() {
      changebutton = true;
    });
    await Future.delayed(Duration(seconds: 2));
    await authController.forgotPassword(email.text);
    setState(() {
      changebutton = false;
    });
  }
}

