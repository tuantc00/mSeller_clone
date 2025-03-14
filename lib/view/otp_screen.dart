import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import 'package:provider/provider.dart';

import '../model/user_model.dart';
import '../view_model/authentication_view_model.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<StatefulWidget> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  UserModel? data;
  AuthenticationViewModel? resendOTP;
  //AuthenticationOtpViewModel? authenOtp;
  bool otpValid = true;
  String errorMess = '';
  final formGlobalKeyOTP = GlobalKey<FormState>();
  final TextEditingController otpController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data;
    //resendOTP = AuthenticationViewModel();
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as UserModel;
    if (data == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Lỗi'),
        ),
        body: const Center(
          child: Text('Không có dữ liệu truyền vào'),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Xác thực số điện thoại',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        leading: _buildIconBtn(context),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white54,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 15, color: Colors.grey),
                children: [
                  const TextSpan(
                      text: 'Chúng tôi đã gửi mã OTP đến \n số điện thoại '),
                  TextSpan(
                    text: data!.phone,
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 35),
            _buildOtpCodeField(),
            const SizedBox(height: 25),
            _buildTextError(),
            const SizedBox(height: 20),
            _buildTextBody(),
          ],
        ),
      ),
    );
  }

  Widget _buildIconBtn(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.of(context).pop(),
      icon: const Icon(
        Icons.arrow_back_outlined,
        color: Colors.black,
      ),
    );
  }

  Widget _buildTextBody() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Chưa nhận được mã? Gửi lại mã',
          style: TextStyle(color: Colors.grey, fontSize: 15),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 2),
          child: IconButton(
            icon: const Icon(Icons.settings_backup_restore_outlined),
            iconSize: 15,
            color: Colors.greenAccent,
            onPressed: () async {
              final authViewModel =
                  Provider.of<AuthenticationViewModel>(context, listen: false);
              await authViewModel.initializeUser(authViewModel.generateOTP());
              data!.storedOTP = authViewModel.user!.storedOTP;
              /*await resendOTP
                  ?.initializeUser(resendOTP!.generateOTP().toString());
              data['otp'] = resendOTP?.generateOTP().toString();*/
              //print('New otp: ${resendOTP?.generateOTP().toString()}');
              print('new otp: ${data?.storedOTP}');
              //resendOTP?.sendOTP()
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTextError() {
    return Text(
      errorMess,
      style: const TextStyle(color: Colors.red, fontSize: 15),
    );
  }

  Widget _buildOtpCodeField() {
    return Form(
      key: formGlobalKeyOTP,
      child: OtpTextField(
        keyboardType: TextInputType.number,
        numberOfFields: 6,
        fillColor: Colors.white54,
        filled: true,
        borderColor: otpValid ? Colors.grey : Colors.red,
        focusedBorderColor: otpValid ? Colors.greenAccent : Colors.red,
        borderRadius: BorderRadius.circular(12),
        showFieldAsBox: true,
        onSubmit: (value) {
          if (value == data?.storedOTP) {
            print('OTP đúng');
            Navigator.pushNamed(context, '/shopinput');
            setState(() {
              errorMess = '';
              otpValid = true;
            });
          } else {
            print('OTP sai');
            setState(() {
              errorMess = 'Mã OTP không chính xác. Vui lòng nhập lại';
              otpValid = false;
            });
          }
        },
      ),
    );
  }
}
