import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mseller/Views/OtpScreen.dart';
import 'package:mseller/ViewModels/authentication_view_model.dart';

class Phonenumberscreen extends StatefulWidget {
  const Phonenumberscreen({super.key});

  @override
  State<Phonenumberscreen> createState() => _PhonenumberScreenState();
}

class _PhonenumberScreenState extends State<Phonenumberscreen> {
  authenticationViewModel? _initUser;
  authenticationViewModel? _authenOTP;
  String phone = '';
  final _formGlobalKeyOTP = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
            )),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.greenAccent,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLogo(),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: _buildPhoneField(),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 170,
              height: 50,
              child: _buildOTPbtn(context),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: double.infinity,
      child: SvgPicture.asset('assets/phone_logo.svg', height: 170),
    );
  }

  Widget _buildPhoneField() {
    return Form(
      key: _formGlobalKeyOTP,
      child: IntlPhoneField(
        validator: (value) {
          if (value == null || !value.isValidNumber()) {
            return 'Please enter a valid phone number';
          }
          if (value.number.length != 10)
          {
            return 'Phone number must be 10 digits';
          }
          return null;
        },
        onSaved: (value) => phone = value.toString(),
        focusNode: FocusNode(),
        keyboardType: TextInputType.number,
        controller: phoneController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(16)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        initialCountryCode: 'VN',
        // disableLengthCheck: true,1
      ),
    );
  }

  Widget _buildOTPbtn(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _initUser!.initializeUser(phone, '', '');
        if (_formGlobalKeyOTP.currentState!.validate()) {
          if (_initUser != null) {
            _initUser!.initializeUser(phone, '', '');
            print('User: ${phone}');
          } else {
            print("Lỗi: _initUser chưa được khởi tạo");
            return;
          }
          Navigator.pushNamed(context, '/otpcode', arguments: {
            //_userModel.token='',
          });
          _formGlobalKeyOTP.currentState!.reset();
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Row(
          children: [
            Text(
              'Gửi mã OTP',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
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
          )),
    );
  }

}
