import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../view_model/authentication_view_model.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhonenumberScreenState();
}

class _PhonenumberScreenState extends State<PhoneNumberScreen> {
  AuthenticationViewModel? initUser;
  //authenticationViewModel? _authenOTP;
  String phone = '';
  final formGlobalKeyOTP = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initUser = AuthenticationViewModel();
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
    return SizedBox(
      width: double.infinity,
      child: SvgPicture.asset('assets/phone_logo.svg', height: 170),
    );
  }

  Widget _buildPhoneField() {
    return Form(
      key: formGlobalKeyOTP,
      child: IntlPhoneField(
        validator: (value) {
          if (value == null) {
            return 'Please enter a valid phone number';
          }
          if (value.number.length != 10) {
            return 'Phone number must be 11 digits';
          }
          return null;
        },
        onSaved: (value) => phone = value!.completeNumber,
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
      onPressed: () async {
        if (formGlobalKeyOTP.currentState!.validate()) {
          formGlobalKeyOTP.currentState!.save();
          await initUser?.initializeUser(phone);
          print(initUser?.user.toString());
          Navigator.pushNamed(
            context, '/otpcode',
            //     arguments: {
            //    'phone':initUser?.user?.phone.toString(),
            //   'pass': initUser?.user?.pass.toString(),
            //   'otp': initUser?.user?.storedOTP.toString(),
            // }
            arguments: initUser?.user,
          );
          formGlobalKeyOTP.currentState!.reset();
        }
      },
      style: ElevatedButton.styleFrom(
          //minimumSize: Size(),
          backgroundColor: Colors.teal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          )),
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
    );
  }
}
