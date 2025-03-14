import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mseller/view/phone_number_screen.dart';
import 'package:provider/provider.dart';

import '../view_model/authentication_view_model.dart';
import '../widgets/style_input_field.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
  final _formGlobalKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthenticationViewModel>(context);

    return Scaffold(
      body: authViewModel.isAuthenticated
          ? PhoneNumberScreen()
          : Stack(
              children: [
                _buildLogo(),
                Padding(
                  padding: const EdgeInsets.only(top: 280),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(30))),
                    child: Form(
                      key: _formGlobalKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 10),
                          _buildTextheader(),
                          SizedBox(height: 20),
                          _buildInputFields(),
                          _buildText(),
                          SizedBox(height: 10),
                          _buildLoginbtn(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildLogo() {
    return Container(
      height: 300,
      width: double.infinity,
      color: Colors.greenAccent,
      child: Padding(
        padding: const EdgeInsets.only(top: 168),
        child: SvgPicture.asset('assets/logo.svg'),
      ),
    );
  }

  Widget _buildInputFields() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: /*TextFormField(
            validator: (value) {
              if (value!.isEmpty) return 'Please enter your phone number';
              return null;
            },
            // onSaved: (value) => _userModel.phone = value!,
            keyboardType: TextInputType.number,
            controller: phoneController,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              hintText: 'Nhập số điện thoại',
              labelText: 'Số điện thoại',
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
            ),
          )*/
              StyleInputField(
            onPressed: () {},
            hintText: 'Nhập số điện thoại',
            labelName: 'Số điện thoại',
            controller: phoneController,
            validator: (value) {
              if (value!.isEmpty) return 'Please enter your phone number';
              return null;
            },
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextFormField(
            obscureText: !_isPasswordVisible,
            validator: (value) {
              if (value!.isEmpty) return 'Please enter your password';
              return null;
            },
            //onSaved: (value) => _userModel.token = value!,
            controller: passwordController,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                onPressed: () {
                  setState(() => _isPasswordVisible = !_isPasswordVisible);
                },
              ),
              hintText: 'Nhập mật khẩu',
              labelText: 'Mật khẩu',
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildText() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Text(
          'Quên mật khẩu?',
          style: TextStyle(color: Colors.greenAccent),
        ),
      ),
    );
  }

  Widget _buildLoginbtn(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ElevatedButton(
              onPressed: () {
                if (_formGlobalKey.currentState!.validate()) {
                  _formGlobalKey.currentState!.save();
                  //print('Số điện thoại: ${_userModel.phone}');
                  //print('Mật khẩu: ${_userModel.token}');
                  Navigator.pushNamed(context, '', arguments: {});
                }
              },
              child: Text('Đăng nhập', style: TextStyle(fontSize: 20)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                minimumSize: Size.fromHeight(57),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bạn chưa có tài khoản  ?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 1),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/phone');
                },
                child: const Text('Đăng kí ngay'),
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 15),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildTextheader() {
    return Text(
      'Đăng nhập',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }
}
