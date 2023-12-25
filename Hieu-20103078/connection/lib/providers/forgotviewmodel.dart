import 'package:connection/repositories/forgot_repository.dart';
import 'package:flutter/material.dart';

class ForgotViewmodel with ChangeNotifier {
  final forgoRepo = forgotRepository();
  int status = 0;
  String errormessage = "";
  // 0 chưa 1 đang 2 lỗi 3 success
  Future<void> forgotPassword(String email) async {
    status = 1;
    notifyListeners();
    errormessage = "";
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (emailValid == false) {
      status = 2;
      errormessage += "Email không hợp lệ!\n";
    }
    if (status != 2) {
      if (await forgoRepo.forgotPassword(email) == true) {
        status = 3;
      } else {
        status = 2;
        errormessage = "Email không tồn tại!";
      }
    }
    notifyListeners();
  }
}
