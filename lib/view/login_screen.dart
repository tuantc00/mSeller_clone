import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mseller/view/phone_number_screen.dart';
import 'package:provider/provider.dart';
import '../view_model/authentication_view_model.dart';
import '../widgets/style_input_field.dart';
import '../widgets/style_toast_card.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

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
          ? Center(child: const Text('!!!!!!!!!!'))
          : Stack(
        children: [
          _buildLogo(),
          Padding(
            padding: const EdgeInsets.only(top: 280),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Form(
                key: _formGlobalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    _buildTextheader(),
                    const SizedBox(height: 20),
                    _buildInputFields(),
                    _buildText(),
                    const SizedBox(height: 10),
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
          child: StyleInputField(
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
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextFormField(
            obscureText: !_isPasswordVisible,
            validator: (value) {
              if (value!.isEmpty) return 'Please enter your password';
              return null;
            },
            controller: passwordController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
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
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
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
        child: const Text(
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
              onPressed: () async {
                if (_formGlobalKey.currentState!.validate()) {
                  _formGlobalKey.currentState!.save();
                  final authViewModel = Provider.of<AuthenticationViewModel>(
                      context,
                      listen: false);
                  await authViewModel.login(
                      phoneController.text, passwordController.text);
                  if (authViewModel.isAuthenticated) {
                     Navigator.pushNamed(context, '/package');
                  } else {
                    // print(phoneController.text);
                    // print(passwordController.text);
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(content: Text('Đăng nhập thất bại'),duration: Durations.short1,),
                    // );
                    print('Log ${authViewModel.errorMess}');
                    DelightToastBar(
                      builder: (context) {
                        return StyleToastCard(
                          Colors.red,
                          null,
                          authViewModel.errorMess,
                          '', () {},
                        );
                      },
                      position: DelightSnackbarPosition.top,
                      autoDismiss: true,
                      snackbarDuration: const Duration(seconds: 1),
                    ).show(context);
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                minimumSize: const Size.fromHeight(57),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Đăng nhập', style: TextStyle(fontSize: 20)),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
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
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 15),
                ),
                child: const Text('Đăng kí ngay'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextheader() {
    return const Text(
      'Đăng nhập',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }
}