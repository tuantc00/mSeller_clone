import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:mseller/Models/User_Model.dart';
import 'package:mseller/ViewModels/authentication_view_model.dart';

class Otpscreen extends StatefulWidget {
  const Otpscreen({super.key});

  @override
  State<StatefulWidget> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<Otpscreen> {
  final _formGlobalKeyOTP = GlobalKey<FormState>();
  final TextEditingController otpController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
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
            const Text(
              'Chúng tôi đã gửi mã OTP đến \n số điện thoại   ',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 35,
            ),
            _buildOtpCodeField(),
            SizedBox(
              height: 35,
            ),
            _buildTextBody(),
          ],
        ),
      ),
    );
  }

  Widget _buildIconBtn(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.of(context).pop(),
      icon: Icon(
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
          'Chưa nhận được mã? Gửi lại mã  ',
          style: TextStyle(color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        Icon(
          Icons.settings_backup_restore_outlined,
          color: Colors.greenAccent,
          size: 15,
        ),
      ],
    );
  }

  Widget _buildOtpCodeField() {
    return Form(
      key: _formGlobalKeyOTP,
      child: OtpTextField(
        onSubmit: (value) => {},
        keyboardType: TextInputType.number,
        numberOfFields: 6,
        fillColor: Colors.white,
        filled: true,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
