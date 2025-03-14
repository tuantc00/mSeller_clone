import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../view_model/authentication_view_model.dart';
import 'otp_screen.dart';


class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhonenumberScreenState();
}

class _PhonenumberScreenState extends State<PhoneNumberScreen> {
  AuthenticationViewModel? initUser;
  String phone = '';
  final formGlobalKeyOTP = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
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
            icon: const Icon(
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
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: _buildPhoneField(),
            ),
            const SizedBox(height: 30),
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
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(16)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        initialCountryCode: 'VN',
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
          Navigator.pushNamed(context,
              '/otpcode',
              arguments: UserAgrument(
                phone: initUser?.user?.phone??'',
                otp: initUser?.user?.storedOTP??'',
                pass: initUser?.user?.pass ??'',
              )
          );
          formGlobalKeyOTP.currentState!.reset();
        }
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          )),
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Row(
          children: const [
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