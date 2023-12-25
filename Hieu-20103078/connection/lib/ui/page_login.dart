import 'package:connection/ui/AppConstant.dart';
import 'package:connection/ui/Page_forgot.dart';
import 'package:connection/ui/page_register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/loginviewmodel.dart';
import 'custom_control.dart';
import 'page_main.dart';

class pageLogin extends StatelessWidget {
  pageLogin({super.key});
  static String routename = '/login';
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<loginViewModel>(context);
    final size = MediaQuery.of(context).size;
    if (viewmodel.status == 3) {
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
      backgroundColor: const Color.fromARGB(184, 224, 224, 224),
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  const Icon(
                    Icons.stream_sharp,
                    color: Color.fromARGB(255, 4, 71, 126),
                    size: 100,
                  ),
                  const Text(
                    "Sign in ",
                    style: TextStyle(fontSize: 25),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTestField(
                    hinText: "👤Username",
                    textController: _emailController,
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTestField(
                    hinText: "🔒Password",
                    textController: _passwordController,
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  viewmodel.status == 2
                      ? Text(
                          viewmodel.errorMessage,
                          style: const TextStyle(color: Colors.red),
                        )
                      : const Text(
                          ' ',
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: GestureDetector(
                      onTap: () {
                        String username = _emailController.text.trim();
                        String password = _passwordController.text.trim();
                        viewmodel.login(username, password);
                      },
                      child: const custombutton(
                        textButton: 'Log in',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context)
                        .popAndPushNamed(PageForgot.routename),
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(
                          color: Color.fromARGB(255, 4, 71, 126), fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context)
                          .popAndPushNamed(PageRegister.routename),
                      child: Container(
                        padding: const EdgeInsets.all(17),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 19, 175, 8),
                            borderRadius: BorderRadius.circular(12)),
                        child: const custombutton2(
                          textButton: 'Create A New Account',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              viewmodel.status == 1 ? CustomSpinner(size: size) : Container(),
            ],
          ),
        ),
      )),
    );
  }
}
