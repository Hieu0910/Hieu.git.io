import 'package:flutter/material.dart';

import '../providers/mainviewmodel.dart';
import 'AppConstant.dart';

class SubPageTimkiem extends StatelessWidget {
  const SubPageTimkiem({super.key});
  static int idpage = 3;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => MainViewModel().CloseMenu(),
      child: Container(
          color: AppConstant.appbarbackground,
          child: Center(
            child: Text("Tìm kiếm"),
          )),
    );
  }
}
