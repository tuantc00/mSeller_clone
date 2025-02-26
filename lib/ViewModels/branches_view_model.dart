import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mseller/Models/branches_model.dart';
import 'dart:convert';
import '../Data/branches_data.dart';
import '../Models/news_test.dart';

class BranchesViewModel with ChangeNotifier {
  Branch? branch;
  bool _isLoading = false;
  String _errorMessage = '';
  Branch? get branches => branch;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  Future<void> fetchBranch() async {
    _isLoading = true;
    notifyListeners();
    try {
      await Future.delayed(Duration(milliseconds: 500));
      branch = createMockBranch();
    } catch (e) {
      _errorMessage = "Error fetching data: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
