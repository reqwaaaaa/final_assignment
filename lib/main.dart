import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'router/router.dart';
import 'state/auth_state.dart';
import 'state/spin_wheel_state.dart';
import 'state/truth_or_dare_state.dart';
import 'state/theme_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthState()),
        ChangeNotifierProvider(create: (_) => SpinWheelState()),
        ChangeNotifierProvider(create: (_) => TruthOrDareState()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '命运飞镖',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: generateRoute,
    );
  }
}




/*  auth_state中
使用 ChangeNotifier：AuthState 类继承了 ChangeNotifier，这意味着可以向其监听者（通常是界面组件）发送通知，以便在状态发生变化时更新界面。

使用 Provider：在需要访问 AuthState 状态的地方使用了 Provider.of<AuthState>(context) 来获取 AuthState 对象。这样，界面组件就可以监听 AuthState 对象的状态变化，并根据需要更新界面。*/

/*
使用 SharedPreferences：在 AuthState 类中， SharedPreferences 进行本地数据的持久化存储.在 _loadUser() 方法中，使用 SharedPreferences 从本地存储中获取了保存的用户信息，包括用户名、登录状态、是否为管理员等信息，并将其加载到 _username、_isLoggedIn 和 _isAdmin 等属性中。

保存用户信息：在用户登录成功后，调用 SharedPreferences 的 setString 和 setBool 方法，将用户的用户名和登录状态保存到本地存储中。这样，在下次应用启动时，就可以从本地存储中读取到上次登录的用户信息，实现自动登录的功能。*/