import 'package:connection/models/profile.dart';
import 'package:connection/providers/registerviewmodel.dart';
import 'package:connection/ui/AppConstant.dart';
import 'package:connection/ui/custom_control.dart';
import 'package:connection/ui/page_login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'page_main.dart';

// ignore: must_be_immutable
class PageRegister extends StatelessWidget {
  PageRegister({super.key});
  static String routename = '/register';
  final _usernameController = TextEditingController();
  final _emailnameController = TextEditingController();
  final _pass1nameController = TextEditingController();
  final _pass2nameController = TextEditingController();
  bool agree = true;
  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<RegisterViewModel>(context);
    final size = MediaQuery.of(context).size;
    final profile = Profile();
    if (profile.token != "") {
      //check login
      Future.delayed(
        Duration.zero,
        () {
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PageMain(),
              ));
        },
      );
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(184, 224, 224, 224),
      body: SafeArea(
          child: Center(
        child: viewmodel.status == 3 || viewmodel.status == 4
            ? Column(
                children: [
                  SizedBox(
                    height: 200,
                  ),
                  Text(
                    "Đăng ký thành công",
                    style: AppConstant.textfancyheader,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Image(
                    image: AssetImage('assets/images/check.gif'),
                    width: 100,
                  ),
                  viewmodel.status == 3
                      ? Text("Bạn cần xác nhận email trước khi đăng ký!")
                      : Text(" "),
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
              )
            : Stack(
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.stream_sharp,
                          color: Color.fromARGB(255, 4, 71, 126),
                          size: 100,
                        ),
                        Text('Sign up', style: AppConstant.textfancyheader),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTestField(
                            textController: _usernameController,
                            hinText: '👤Username',
                            obscureText: false),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTestField(
                            textController: _emailnameController,
                            hinText: '📧Email',
                            obscureText: false),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTestField(
                            textController: _pass1nameController,
                            hinText: '🔒Password',
                            obscureText: true),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTestField(
                            textController: _pass2nameController,
                            hinText: '🔒Re-Password',
                            obscureText: true),
                        Text(
                          viewmodel.errormessage,
                          style: AppConstant.texterror,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Checkbox(
                                value: viewmodel.agree,
                                onChanged: (value) {
                                  viewmodel.setAgree(value!);
                                },
                              ),
                              Text('Accept'),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text(" Privacy Policy"),
                                      content: Text(viewmodel.quydinh),
                                    ),
                                  );
                                },
                                child: Text(
                                  ' privacy policy ',
                                  style: AppConstant.Textlink,
                                ),
                              ),
                              Text('and terms '),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: GestureDetector(
                              onTap: () {
                                final email = _emailnameController.text.trim();
                                final usermane =
                                    _usernameController.text.trim();
                                final pass1 = _pass1nameController.text.trim();
                                final pass2 = _pass2nameController.text.trim();
                                viewmodel.register(
                                    email, usermane, pass1, pass2);
                              },
                              child:
                                  custombutton(textButton: 'Create account')),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context)
                              .popAndPushNamed(pageLogin.routename),
                          child: Text(
                            "<== Back",
                            style: AppConstant.Textlink1,
                          ),
                        )
                      ]),
                  viewmodel.status == 1
                      ? CustomSpinner(size: size)
                      : Container()
                ],
              ),
      )),
    );
  }
}
