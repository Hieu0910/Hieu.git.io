import 'package:connection/repositories/register_repository.dart';
import 'package:flutter/material.dart';

class RegisterViewModel with ChangeNotifier {
  int status = 0;
  String errormessage = "";
  bool agree = false;
  final registerRepo = RegisterRepository();
  String quydinh =
      "Theo quy định tại Điều 8 Luật Công nghệ thông tin 2006 thì quyền của tổ chức, cá nhân tham gia hoạt động ứng dụng và phát triển công nghệ thông tin được quy định cụ thể như sau:\n"
      "+ Tìm kiếm, trao đổi, sử dụng thông tin trên môi trường mạng, trừ thông tin có nội dung quy định tại khoản 2 Điều 12 của Luật Công nghệ thông tin 2006\n"
      "+ Tìm kiếm, trao đổi, sử dụng thông tin trên môi trường mạng, trừ thông tin có nội dung quy định tại khoản 2 Điều 12 của Luật Công nghệ thông tin 2006\n"
      "+ Phân phát các địa chỉ liên lạc có trên môi trường mạng khi có sự đồng ý của chủ sở hữu địa chỉ liên lạc đó;";
  void setAgree(bool value) {
    agree = value;
    notifyListeners();
  }

  Future<void> register(
      String email, String username, String pass1, String pass2) async {
    status = 1;
    notifyListeners();
    errormessage = "";
    if (agree == false) {
      status = 2;
      errormessage += "Bạn phải đồng ý điều khoản trước khi đăng ký!\n";
    }
    if (email.isEmpty || username.isEmpty || pass1.isEmpty) {
      status = 2;
      errormessage += "Email, Username, Password không được để trống!\n";
    }
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (emailValid == false) {
      status = 2;
      errormessage += "Email không hợp lệ!\n";
    }
    if (pass1.length < 8) {
      status = 2;
      errormessage += "Mật khẩu phải có độ dài trên 8 kí tự\n";
    }
    if (pass1 != pass2) {
      status = 2;
      errormessage = "Mật khẩu không trùng nhau!\n";
    }

    if (status != 2) {
      status = await registerRepo.register(email, username, pass1);
      print(status);
    }

    notifyListeners();
  }
}
