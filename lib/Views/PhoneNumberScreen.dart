import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mseller/Views/OtpScreen.dart';

class Phonenumberscreen extends StatelessWidget {
  const Phonenumberscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        leading: IconButton(
            onPressed: ()=> Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_outlined,color: Colors.white,)
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.greenAccent,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              child: SvgPicture.asset('assets/phone_logo.svg',height: 170),
            ),
            SizedBox(height:25),
            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15),
              child: IntlPhoneField(
                focusNode: FocusNode(),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                 // hoverColor: Colors.white,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(16),
                  )
                ),
                initialCountryCode: 'VN',
              ),
            ),
            SizedBox(height: 30,),
            SizedBox(
              width: 170,
              height: 50,
              child: ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Otpscreen()));
              }, child: Padding(
                padding: const EdgeInsets.only(left:15),
                child: Row(
                  children: [
                    Text('Gửi mã OTP ',style: TextStyle(fontSize: 15,color: Colors.white), ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.white,
                      size: 15,
                    ),
                  ],
                ),
              ),
                style: ElevatedButton.styleFrom(
                  //minimumSize: Size(),
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
