import 'package:dod1/screens/change_name_screen.dart';
import 'package:dod1/screens/change_picture_screen.dart';
import 'package:dod1/screens/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/home_screen.dart';
import '../screens/change_password_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/truth_or_dare_screen.dart';
import '../screens/truth_screen.dart';
import '../screens/dare_screen.dart';
import '../screens/admin_screen.dart';
import '../screens/manage_questions_screen.dart';
import '../screens/my_themes_screen.dart';
import '../screens/create_theme_screen.dart';
import '../screens/welcome_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/login':
      return MaterialPageRoute(builder: (_) => LoginScreen());
    case '/register':
      return MaterialPageRoute(builder: (_) => RegisterScreen());
    case '/home':
      return MaterialPageRoute(builder: (_) => HomeScreen());
    case '/change_password':
      return MaterialPageRoute(builder: (_) => ChangePasswordScreen());
    case '/profile':
      return MaterialPageRoute(builder: (_) => ProfileScreen());
    case '/truth_or_dare':
      return MaterialPageRoute(builder: (_) => TruthOrDareScreen());
    case '/truth':
      return MaterialPageRoute(builder: (_) => TruthPage());
    case '/dare':
      return MaterialPageRoute(builder: (_) => DarePage());
    case '/admin':
      return MaterialPageRoute(builder: (_) => AdminScreen());
    case '/manage_questions':
      return MaterialPageRoute(builder: (_) => ManageQuestionsScreen());
    case '/my_themes':
      return MaterialPageRoute(builder: (_) => MyThemesScreen());
    case '/create_theme':
      return MaterialPageRoute(builder: (_) => CreateThemeScreen());
       case '/welcome':
      return MaterialPageRoute(builder: (_) => WelcomeScreen());
    case '/change_nickname':
      return MaterialPageRoute(builder: (_) => ChangeNameScreen());
    case '/change_avatar':
      return MaterialPageRoute(builder: (_) => ChangePictureScreen());
    case '/history':
      return MaterialPageRoute(builder: (_) => HistoryScreen());


    default:
      return MaterialPageRoute(builder: (_) => LoginScreen());
  }
}
/*Switch Case 语句：通过 switch 语句根据路由名称 settings.name 匹配不同的路由设置，并返回对应的页面路由。

Route 构建：每个 case 分支中都返回一个 MaterialPageRoute 对象，该对象包含要导航到的页面的 builder 属性。builder 属性接受一个匿名函数，在这个函数中创建并返回要导航到的页面的实例。

默认路由：如果给定的路由名称不匹配任何已知的路由，那么就会返回一个默认的路由，通常是登录页面。

使用方法：在应用程序的主要路由器（通常是 MaterialApp 或 CupertinoApp 的 onGenerateRoute 属性）中，将 generateRoute 函数指定为路由生成器。*/