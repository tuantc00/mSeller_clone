import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import '../datas/branches_data.dart';
import '../model/branches_model.dart';

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
