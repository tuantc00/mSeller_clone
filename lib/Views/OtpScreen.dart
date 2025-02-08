import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class Otpscreen extends StatelessWidget {
  const Otpscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Xác thực số điện thoại',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
        leading: IconButton(
            onPressed: ()=> Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_outlined,color: Colors.black,),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white54,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Chúng tôi đã gửi mã OTP đến \n số điện thoại 0339 523 422',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,),
            SizedBox(height: 35,),
            OtpTextField(
              keyboardType: TextInputType.number,
              numberOfFields: 6,
              fillColor: Colors.white,
              filled: true,
              borderRadius: BorderRadius.circular(12),

            ),
            SizedBox(height: 35,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Chưa nhận được mã? Gửi lại mã  ',style: TextStyle( color: Colors.grey ),textAlign: TextAlign.center,),
                Icon(
                  Icons.settings_backup_restore_outlined,
                  color: Colors.greenAccent,
                  size: 15,
                ),
              ],
            ),

          ],
        ),

      ),
    );
  }
}
