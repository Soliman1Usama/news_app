import 'package:flutter/material.dart';

class UserData extends ChangeNotifier {
  String? surName;
  String? phone;

  void setUserDetails(String surName, String phone) {
    this.surName = surName;
    this.phone = phone;
    notifyListeners();
  }
}
UserData userData = UserData(); // Declare the provider instance globally
