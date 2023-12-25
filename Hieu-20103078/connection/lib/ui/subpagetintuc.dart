import 'package:flutter/material.dart';
import '../providers/mainviewmodel.dart';
import 'AppConstant.dart';

class SubPageTintuc extends StatelessWidget {
  const SubPageTintuc({super.key});
  static int idpage = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => MainViewModel().CloseMenu(),
      child: Container(
          color: AppConstant.appbarbackground,
          child: Center(
            child: Text("Tin tức"),
          )),
    );
  }
}
