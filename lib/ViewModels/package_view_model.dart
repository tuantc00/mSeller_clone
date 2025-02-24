import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/news_test.dart';

class NewsViewModel with ChangeNotifier {
  List<News> _news = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<News> get news => _news;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchNews() async {
    _isLoading = true;
    notifyListeners();
    try {
      String apiKey = "";
      String urlString =
          "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=$apiKey";
      Uri uri = Uri.parse(urlString);
      final newsResponse = await http.get(uri);

      if (newsResponse.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(newsResponse.body);
        if (jsonData['articles'] != null) {
          List<dynamic> articles = jsonData['articles'];
          _news = articles.map((json) => News.fromJson(json)).toList();
        } else {
          throw Exception('No articles found in the response');
        }
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      _errorMessage = "Error fetching news: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
