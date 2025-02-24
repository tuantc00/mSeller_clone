// import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Models/news_test.dart';

class NewsCard extends StatelessWidget {
  final News news;

  NewsCard({required this.news});

  /*void _launchURL(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url, mode: LaunchMode.inAppWebView)) {
      throw 'Could not launch $url';
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: 1,color: Colors.greenAccent),
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16)),
              ),
              height: double.infinity,
              child: SvgPicture.asset('assets/logo_package.svg'),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              height: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(news.title,style: TextStyle(color: Colors.greenAccent),),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                border: Border(left: BorderSide(color: Colors.black12,width: 1)),
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
              ),
              height: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(news.title,style: TextStyle(color: Colors.black)
                  ),
                ),
              ),
            ),
          ),

        ],
      ),

    );

    //   Card(
    //   shape: RoundedRectangleBorder(
    //       side: BorderSide(color: Colors.green, width: 1),
    //       borderRadius: BorderRadius.all(Radius.circular(16))),
    //   margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    //   child: ListTile(
    //     enabled:false,
    //     //leading: Image.network(news.image),
    //     leading: Container(
    //       width: 40,
    //       height: 40,
    //       decoration: BoxDecoration(
    //         color: Colors.greenAccent,
    //         borderRadius: BorderRadius.circular(8),
    //       ),
    //       child: SvgPicture.asset('assets/logo_package.svg'),
    //     ),
    //     title: Text(
    //       news.title,
    //       style: TextStyle(
    //           color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400),
    //     ),
    //     // /*children: <Widget>[
    //     //   Padding(
    //     //     padding: EdgeInsets.all(10.0),
    //     //     child: Text(
    //     //       news.content,
    //     //       style: TextStyle(fontSize: 16.0),
    //     //     ),
    //     //   ),
    //     //   *//*InkWell(
    //     //     child: Text(
    //     //       "Read More",
    //     //       style: TextStyle(color: Colors.blue, height: 3),
    //     //     ),
    //     //     onTap: () {
    //     //       _launchURL(news.url);
    //     //     },
    //     //   ),*//*
    //     // ]*/,
    //   ),
    // );
  }
}
