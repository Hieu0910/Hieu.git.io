import 'package:flutter/material.dart';

import '../providers/mainviewmodel.dart';
import 'AppConstant.dart';

class SubPageDslop extends StatelessWidget {
  const SubPageDslop({super.key});
  static int idpage = 4;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => MainViewModel().CloseMenu(),
      child: Container(
          color: AppConstant.appbarbackground,
          child: Center(
            child: Text("Danh sách lớp"),
          )),
    );
  }
}
