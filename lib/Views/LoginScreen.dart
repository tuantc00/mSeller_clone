import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mseller/ViewModels/authentication_view_model.dart';
import 'package:mseller/Views/PhoneNumberScreen.dart';
import 'package:provider/provider.dart';
import '../ViewModels/authentication_view_model.dart';

class Loginscreen extends StatefulWidget {
  Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<Loginscreen> {
  bool _isPasswordVisible = false;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<authenticationViewModel>(context);
    return Scaffold(
      body: authenticationViewModel().isAuthenticated ? Scaffold(
        body: Phonenumberscreen(),
      ) : Stack(
        children: [
          _buildLogo(),
          Padding(
            padding: const EdgeInsets.only(top: 280),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(20),
                      topLeft: Radius.circular(30))
              ),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10,),
                    _buildTextheader(),
                    SizedBox(height: 20,),
                    _buildInputField(),
                    _buildText(),
                    SizedBox(height: 10,),
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
      child: Column(
        children: [
          Container(
            child:
            Padding(
              padding: const EdgeInsets.only(top: 168),
              child: SvgPicture.asset(
                'assets/logo.svg',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField() {
    return Form(child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your phonenumbers ';
              }
              return null;
            },
            keyboardType: TextInputType.number,
            controller: phoneController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintText: 'Nhập số điện thoại',
              label: Text('Số điện thoại',
                style: TextStyle(fontWeight: FontWeight.bold),),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              right: 15, left: 15, top: 20, bottom: 20),
          child: TextFormField(
            obscureText: !_isPasswordVisible,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your username or email';
              }
              return null;
            },
            controller: passwordController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible
                    ? Icons.visibility_outlined
                      :Icons.visibility_off_outlined,
                ),
                onPressed: () {
                    setState(() {
                      _isPasswordVisible=!_isPasswordVisible;
                    });
                },

              ),
              hintText: 'Nhập mật khẩu',
              label: Text('Mật khẩu',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),

      ],
    )
    );
  }

  Widget _buildText() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Text(
          'Quên mật khẩu ?', style: TextStyle(color: Colors.greenAccent),),
      ),
    );
  }

  Widget _buildLoginbtn(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            width: double.infinity,
            child:
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: ElevatedButton(onPressed: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context) => Phonenumberscreen()));
                Navigator.pushNamed(context, '/phone');
              },
                child: Text('Đăng nhập', style: TextStyle(fontSize: 20),),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    minimumSize: Size.fromHeight(57),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),)
              ,
            )
        ),
        SizedBox(height: 20,),
        Text(
          'Bạn chưa có tài khoản? Đăng kí ngay', textAlign: TextAlign.center,),
      ],
    );
  }

  Widget _buildTextheader() {
    return Text('Đăng nhập',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}



