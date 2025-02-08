import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mseller/ViewModels/authentication_view_model.dart';
import 'package:mseller/Views/PhoneNumberScreen.dart';
import 'package:provider/provider.dart';
import '../ViewModels/authentication_view_model.dart';

class Loginscreen extends StatelessWidget {
   Loginscreen({super.key});
  final TextEditingController phoneController= TextEditingController();
  final TextEditingController passwordController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authViewModel= Provider.of<authenticationViewModel>(context);
    return  Scaffold(
       body:  authenticationViewModel().isAuthenticated  ?  Scaffold(
         body: Phonenumberscreen(),

       ) :Stack(
         children: [
           Container(
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
           ),
           Padding(
             padding: const EdgeInsets.only(top: 280),
             child: Container(
               decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.only(topRight: Radius.circular(20),
                       topLeft: Radius.circular(30))
               ),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   SizedBox(height: 10,),
                   Text('Đăng nhập',
                     style: TextStyle(
                       fontSize: 20,
                       fontWeight: FontWeight.bold,
                     ),
                     textAlign: TextAlign.center,),
                   SizedBox(height: 20,),
                   Padding(
                     padding: const EdgeInsets.only(left: 15,right: 15),
                     child: TextField(
                       keyboardType: TextInputType.number,
                       controller: phoneController,
                       decoration: InputDecoration(
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(10.0),
                         ),
                         hintText: 'Nhập số điện thoại',
                         label: Text('Số điện thoại',style: TextStyle(fontWeight: FontWeight.bold),),
                       ),
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(right: 15, left: 15,top: 20,bottom: 20),
                     child: TextField(
                       controller: passwordController,
                       decoration: InputDecoration(
                         border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(10)
                         ),
                         suffixIcon: Icon(Icons.remove_red_eye_outlined),
                         hintText: 'Nhập mật khẩu',
                         label: Text('Mật khẩu',
                           style: TextStyle(fontWeight: FontWeight.bold),
                         ),
                       ),
                     ),
                   ),
                   Align(
                     alignment: Alignment.centerRight,
                     child: Padding(
                       padding: const EdgeInsets.only(right: 15),
                       child: Text('Quên mật khẩu ?',style: TextStyle(color: Colors.greenAccent),),
                     ),
                   ),
                   SizedBox(height: 10,),
                   SizedBox(
                       width: double.infinity,
                       child:
                       Padding(
                         padding: const EdgeInsets.only(left: 15,right: 15),
                         child: ElevatedButton(onPressed: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context) => Phonenumberscreen()));
                         },
                           child: Text('Đăng nhập',style: TextStyle(fontSize: 20),),
                           style: ElevatedButton.styleFrom(
                               backgroundColor: Colors.greenAccent,
                               minimumSize: Size.fromHeight(57),
                               shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(10),
                               )
                           ),)
                         ,
                       )),
                   SizedBox(height: 20,),
                   Text('Bạn chưa có tài khoản? Đăng kí ngay',textAlign: TextAlign.center,),
                 ],
               ),
             ),
           ),
         ],

       ),
    );
  }


}
