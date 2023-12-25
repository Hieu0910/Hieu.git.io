import 'package:connection/models/profile.dart';
import 'package:connection/providers/forgotviewmodel.dart';
import 'package:connection/providers/loginviewmodel.dart';
import 'package:connection/providers/mainviewmodel.dart';
import 'package:connection/providers/menubarviewmodel.dart';
import 'package:connection/providers/profileviewmodel.dart';
import 'package:connection/providers/registerviewmodel.dart';
import 'package:connection/repositories/diachimodel.dart';
import 'package:connection/services/api_service.dart';
import 'package:connection/ui/PageDangKyLop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/Page_forgot.dart';
import 'ui/page_login.dart';
import 'ui/page_main.dart';
import 'ui/page_register.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Apiservice api = Apiservice();
  api.initialize();

  Profile profile = Profile();
  profile.initialize();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<loginViewModel>(
      create: (context) => loginViewModel(),
    ),
    ChangeNotifierProvider<RegisterViewModel>(
      create: (context) => RegisterViewModel(),
    ),
    ChangeNotifierProvider<ForgotViewmodel>(
      create: (context) => ForgotViewmodel(),
    ),
    ChangeNotifierProvider<MainViewModel>(
      create: (context) => MainViewModel(),
    ),
    ChangeNotifierProvider<MenuBarviewModel>(
      create: (context) => MenuBarviewModel(),
    ),
    ChangeNotifierProvider<ProfileViewmodel>(
      create: (context) => ProfileViewmodel(),
    ),
    ChangeNotifierProvider<DiachiModel>(
      create: (context) => DiachiModel(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => PageMain(),
        '/login': (context) => pageLogin(),
        '/register': (context) => PageRegister(),
        '/Forgot': (context) => PageForgot(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 16)),
        colorScheme: ColorScheme.fromSeed(
            seedColor: Color.fromRGBO(255, 219, 58, 0.965)),
        useMaterial3: true,
      ),
      home: PageMain(),
    );
  }
}


// ------------------------------------------------------------------------------------------------------------



