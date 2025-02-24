import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

import '../Models/news_test.dart';
import '../ViewModels/package_view_model.dart';
import '../Widget/news_card_test.dart';

class PackageScreen extends StatelessWidget {
  const PackageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final newsViewModel = Provider.of<NewsViewModel>(context,listen: false );

    // Fetch data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      newsViewModel.fetchNews();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gói & thanh toán',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 37, 169, 135),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.white,
          ),
        ),
      ),
      body: Consumer<NewsViewModel>(
        builder: (context, newsViewModel, child) {
          if (newsViewModel.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (newsViewModel.errorMessage.isNotEmpty) {
            return Center(child: Text(newsViewModel.errorMessage));
          }

          return BodyBuild(news: newsViewModel.news);
        },
      ),
    );
  }
}

class BodyBuild extends StatelessWidget {
  final List<News> news; // Thêm thuộc tính để nhận dữ liệu

  const BodyBuild({super.key, required this.news}); // Sửa constructor

  @override
  Widget build(BuildContext context) {
    int days = 5;
    return Stack(
      children: <Widget>[
        // Red background container
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white10,
          ),
        ),

        Positioned(
          left: 0,
          right: 0,
          child: Container(
            height: 230,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 37, 169, 135),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
          ),
        ),

        Positioned(
          top: 20,
          left: 20,
          right: 20,
          child: Stack(
            children: [
              Container(
                height: 270,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.info_rounded,
                                    size: 15, color: Colors.white),
                                SizedBox(width: 4),
                                Text('Sắp hết hạn',
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                            Text('Còn lại: $days',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 230,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                child: SvgPicture.asset('assets/shop_logo.svg',
                                    width: 44, height: 44),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Cửa hàng \nPhở thìn 247',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Chip(
                            avatar: null,
                            label: Text('Đã kích hoạt',
                                style: TextStyle(color: Colors.white)),
                            backgroundColor: Color.fromARGB(255, 37, 169, 135),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(65),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      width: 331,
                      height: 90,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 249, 250, 251),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Gia hạn cuối cùng: '),
                                Text('date 23423'),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Ngày hết hạn: '),
                                Text('date34 23'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 300,
          left: 0,
          right: 0,
          bottom: 0,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Mã kích hoạt gói tài khoản',
                          style: TextStyle(color: Colors.grey, fontSize: 15)),
                      SizedBox(height: 10),
                      Form(
                        child: TextFormField(
                          decoration: InputDecoration(
                            suffix: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.greenAccent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                              ),
                              onPressed: () {},
                              child: Text('Kích hoạt',
                                  style: TextStyle(color: Colors.white)),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Nhập mã kích hoạt',
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            constraints: BoxConstraints(
                                maxHeight: 60), // Giới hạn chiều cao
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ButtonsTabBar(
                              radius:16 ,
                              backgroundColor: Colors.greenAccent,
                              unselectedBackgroundColor: Colors.white,
                              unselectedLabelStyle:
                                  const TextStyle(color: Colors.red),
                              splashColor: Colors.greenAccent,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              labelStyle: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                              tabs: [
                                Tab(
                                  child: Text(
                                    'Gói gia hạn',
                                  ),
                                ),
                                Tab(
                                  child: Text('Lịch sử gia hạn'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            ListView.builder(
                              itemCount: news.length,
                              itemBuilder: (context, index) {
                                return NewsCard(news: news[index]);
                              },
                            ),
                            Center(child: Text('Null')),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
