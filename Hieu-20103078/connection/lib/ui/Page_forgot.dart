import 'package:connection/providers/forgotviewmodel.dart';
import 'package:connection/ui/AppConstant.dart';
import 'package:connection/ui/custom_control.dart';
import 'package:connection/ui/page_login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageForgot extends StatelessWidget {
  static String routename = '/Forgot';
  PageForgot({super.key});
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewmodel = Provider.of<ForgotViewmodel>(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: viewmodel.status == 3
              ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 200,
                      ),
                      Text(
                        "Gửi thành công",
                        style: AppConstant.textfancyheader,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Image(
                        image: AssetImage('assets/images/check.gif'),
                        width: 100,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            "Quay lại",
                            style: TextStyle(fontSize: 20),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.popAndPushNamed(
                                context, pageLogin.routename),
                            child: Text(
                              " Đăng nhập",
                              style: AppConstant.Textlink,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              : Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Image(
                            image: AssetImage("./assets/img/mail.gif"),
                            width: 150,
                          ),
                          Text("Hãy nhập email để xác nhận lại mật khẩu."),
                          CustomTestField(
                              textController: _emailController,
                              hinText: "Email",
                              obscureText: false),
                          Text(
                            viewmodel.errormessage,
                            style: AppConstant.texterror,
                          ),
                          GestureDetector(
                              onTap: () {
                                final email = _emailController.text.trim();
                                viewmodel.forgotPassword(email);
                              },
                              child: custombutton(textButton: 'Gửi yêu cầu')),
                          GestureDetector(
                            onTap: () => Navigator.of(context)
                                .popAndPushNamed(pageLogin.routename),
                            child: Text(
                              "<== Back",
                              style: AppConstant.Textlink1,
                            ),
                          )
                        ],
                      ),
                    ),
                    viewmodel.status == 1
                        ? CustomSpinner(size: size)
                        : Container()
                  ],
                ),
        ),
      ),
    );
  }
}
