import 'package:avatar_glow/avatar_glow.dart';
import 'package:connection/providers/mainviewmodel.dart';
import 'package:connection/providers/menubarviewmodel.dart';
import 'package:connection/ui/AppConstant.dart';
import 'package:connection/ui/PageDangKyLop.dart';
import 'package:connection/ui/custom_control.dart';
import 'package:connection/ui/page_login.dart';
import 'package:connection/ui/subpagediemdanh.dart';
import 'package:connection/ui/subpagedshocphan.dart';
import 'package:connection/ui/subpagedslop.dart';
import 'package:connection/ui/subpageprofile.dart';
import 'package:connection/ui/subpagetimkiem.dart';
import 'package:connection/ui/subpagetintuc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/profile.dart';

class PageMain extends StatelessWidget {
  static String routename = '/register';
  PageMain({super.key});
  final List<String> menuTitles = [
    'Tin tức',
    "Profile",
    'Điểm danh',
    'Tìm kiếm',
    'Danh sách lớp',
    'Danh sách HP',
    "  Đăng Xuất "
  ];
  final menuBar = MenuItemList();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewmodel = Provider.of<MainViewModel>(context);
    Profile profile = Profile();
    if (profile.token == "") {
      return pageLogin();
    }
    if (profile.student.mssv == "") {
      return PageDangKyLop();
    }
    Widget body = SubPageTintuc();
    if (viewmodel.activemenu == SubPageProfile.idpage) {
      body = SubPageProfile();
    } else if (viewmodel.activemenu == SubPageDiemdanh.idpage) {
      body = SubPageDiemdanh();
    } else if (viewmodel.activemenu == SubPageTimkiem.idpage) {
      body = SubPageTimkiem();
    } else if (viewmodel.activemenu == SubPageDslop.idpage) {
      body = SubPageDslop();
    } else if (viewmodel.activemenu == SubPageDshocphan.idpage) {
      body = SubPageDshocphan();
    }

    menuBar.initialize(menuTitles);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appbarcolor,
        leading: GestureDetector(
          onTap: () => viewmodel.togglemenu(),
          child: Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Consumer<MenuBarviewModel>(
            builder: (context, menuBarmodel, child) {
              return Container(
                color: Colors.white,
                child: Center(
                  child: body,
                ),
              );
            },
          ),
          viewmodel.menustatus == 1
              ? Consumer<MenuBarviewModel>(
                  builder: (context, menuBarmodel, child) {
                    return GestureDetector(
                        onPanUpdate: (details) {
                          menuBarmodel.setOfset(details.localPosition);
                        },
                        onPanEnd: (details) {
                          menuBarmodel.setOfset(Offset(0, 0));
                          viewmodel.CloseMenu();
                        },
                        child: Stack(
                          children: [CustomMenuSideBAr(size: size), menuBar],
                        ));
                  },
                )
              : Container(),
        ],
      )),
    );
  }
}

// 'Tin tức',
// "Profile",
// 'Điểm danh',
// 'Tìm kiếm',
// 'Danh sách lớp',
// 'Danh sách HP'

class MenuItemList extends StatelessWidget {
  MenuItemList({
    super.key,
  });

  final List<MenuBarItem> menuBarItems = [];
  void initialize(List<String> menuTitles) {
    menuBarItems.clear();
    for (int i = 0; i < menuTitles.length; i++) {
      menuBarItems.add(MenuBarItem(
        idpage: i,
        containerkey: GlobalKey(),
        title: menuTitles[i],
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.20,
          width: size.width * 0.65,
          child: Center(
            child: AvatarGlow(
              duration: Duration(milliseconds: 2000),
              repeat: true,
              showTwoGlows: true,
              repeatPauseDuration: Duration(milliseconds: 100),
              endRadius: size.height * 0.15,
              glowColor: AppConstant.backgroundcolor1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(size.height),
                child: SizedBox(
                  height: size.height * 0.15,
                  width: size.width * 0.25,
                  child: Image(
                    image: AssetImage('assets/img/960x0.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 2,
          width: size.width * 0.65,
          color: AppConstant.appbarcolor,
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: size.height * 0.6,
          width: size.width * 0.65,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: menuBarItems.length,
              itemBuilder: (context, index) {
                return menuBarItems[index];
              },
            ),
          ),
        ),
      ],
    );
  }
}

class MenuBarItem extends StatelessWidget {
  MenuBarItem({
    super.key,
    required this.title,
    required this.containerkey,
    required this.idpage,
  });
  final int idpage;
  final String title;
  final GlobalKey containerkey;
  TextStyle style = AppConstant.textbody;
  void onPanmove(Offset offset) {
    if (offset.dy == 0) {
      style = AppConstant.textbody;
    }
    if (containerkey.currentContext != null) {
      RenderBox box =
          containerkey.currentContext!.findRenderObject() as RenderBox;
      Offset position = box.localToGlobal(Offset.zero);
      if (offset.dy < position.dy - 40 && offset.dy > position.dy - 80) {
        style = AppConstant.textbodyfocus;
        MainViewModel().activemenu = idpage;
      } else {
        style = AppConstant.textbody;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final menuBarModer = Provider.of<MenuBarviewModel>(context);
    onPanmove(menuBarModer.offset);
    return GestureDetector(
      onTap: () => MainViewModel().setActiveMenu(idpage),
      child: Container(
        key: containerkey,
        alignment: Alignment.centerLeft,
        height: 40,
        child: Text(
          title,
          style: style,
        ),
      ),
    );
  }
}

class CustomMenuSideBAr extends StatelessWidget {
  const CustomMenuSideBAr({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final sizeBarModel = Provider.of<MenuBarviewModel>(context);
    final size = MediaQuery.of(context).size;
    return CustomPaint(
      size: Size(size.width * 0.65, size.height),
      painter: DrawerCustomPaint(offset: sizeBarModel.offset),
    );
  }
}

class DrawerCustomPaint extends CustomPainter {
  final Offset offset;

  DrawerCustomPaint({super.repaint, required this.offset});
  double generatePointX(double width) {
    double kq = 0;
    if (offset.dx == 0) {
      kq = width;
    } else if (offset.dx < width) {
      kq = width + 35;
    } else {
      kq = offset.dx;
    }
    return kq;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paint = Paint()
      ..color = Color.fromARGB(255, 88, 116, 201)
      ..style = PaintingStyle.fill;
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    //path.lineTo(size.width, size.height);
    path.quadraticBezierTo(
        generatePointX(size.width), offset.dy, size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    //throw UnimplementedError();
    return true;
  }
}
