import 'package:flutter/material.dart';

import '../widgets/style_input_field.dart';

class ShopInputInforScreen extends StatefulWidget {
  const ShopInputInforScreen({super.key});

  @override
  State<ShopInputInforScreen> createState() => _ShopInputInforScreenState();
}

class _ShopInputInforScreenState extends State<ShopInputInforScreen> {
  bool _isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    //final authOtpViewModel = Provider.of<AuthenticationOtpViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Khai báo thông tin'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Phần "Tên cửa hàng"
              Text('Tên cửa hàng *',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              StyleInputField(
                  onPressed: () {},
                  hintText: 'Nhập tên cửa hàng (bắt buộc)',
                  labelName: ''),
              SizedBox(height: 16),

              // Phần "Nhập một khóa"
              Text('Nhập mật khẩu *',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              TextFormField(
                obscureText: !_isPasswordVisible,
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter your password';
                  return null;
                },
                //onSaved: (value) => _userModel.token = value!,
                //controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
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
                  hintText: 'Nhập mật khẩu (bắt buộc)',
                  // labelText: 'Mật khẩu',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 16),

              // Phần "Nhập lại một khóa"
              Text('Nhập lại mật khẩu *',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              TextFormField(
                obscureText: !_isPasswordVisible,
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter your password';
                  return null;
                },
                //onSaved: (value) => _userModel.token = value!,
                //controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
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
                  hintText: 'Nhập mật khẩu (bắt buộc)',
                  //labelText: 'Mật khẩu',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 24),

              // Phần "Thông tin tài khoản"
              Text('Thông tin tài khoản',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),

              // Phần "Mã Bank"
              Text('Mã Bank', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                items: [
                  DropdownMenuItem(
                      value: 'TMCP Quận đội', child: Text('TMCP Quận đội')),
                  DropdownMenuItem(value: 'Khác', child: Text('Khác')),
                ],
                onChanged: (value) {
                  // Xử lý khi chọn ngân hàng
                },
              ),
              SizedBox(height: 16),

              // Phần "Số tài khoản"
              Text('Số tài khoản *',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Nhập số tài khoản',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Phần "Chủ tài khoản"
              Text('Chủ tài khoản *',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Tên chủ tài khoản',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Phần "Mã giới thiệu/ Mã RM"
              Text('Mã giới thiệu/ Mã RM',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Nhập mã giới thiệu (không bắt buộc)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 24),

              // Phần "Đăng ký tài khoản"
              ElevatedButton(
                onPressed: () {
                  // Xử lý đăng ký tài khoản
                },
                child: Text('Đăng ký tài khoản'),
              ),
              SizedBox(height: 16),

              // Phần "Đã có tài khoản? Đăng nhập"
              Center(
                child: TextButton(
                  onPressed: () {
                    // Xử lý chuyển đến màn hình đăng nhập
                  },
                  child: Text('Đã có tài khoản? Đăng nhập'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
