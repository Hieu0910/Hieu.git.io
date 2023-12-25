import 'package:flutter/material.dart';

import '../providers/mainviewmodel.dart';
import 'AppConstant.dart';

class SubPageDiemdanh extends StatelessWidget {
  const SubPageDiemdanh({super.key});
  static int idpage = 2;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => MainViewModel().CloseMenu(),
      child: Container(
          color: AppConstant.appbarbackground,
          child: Center(
            child: Text("Điểm danh"),
          )),
    );
  }
}
