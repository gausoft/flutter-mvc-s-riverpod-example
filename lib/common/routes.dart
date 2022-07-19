import 'package:flutter/cupertino.dart';

import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/home/request_list_screen.dart';
import '../screens/home/submit_request_screen.dart';

Route<dynamic> onGenerate(RouteSettings settings) {
  switch (settings.name) {
    case '/request-list':
      return CupertinoPageRoute(
        builder: (_) => const RequestListScreen(),
        settings: settings,
      );
    case '/request-quote':
      return CupertinoPageRoute(
        settings: settings,
        builder: (BuildContext context) => const RequestQuoteScreen(),
      );
    case '/login':
      return CupertinoPageRoute(
        settings: settings,
        builder: (BuildContext context) => const LoginScreen(),
      );
    case '/register':
      return CupertinoPageRoute(
        settings: settings,
        builder: (BuildContext context) => const RegisterScreen(),
      );
    default:
      return CupertinoPageRoute(
        settings: settings,
        builder: (_) => const CupertinoPageScaffold(
          child: Center(child: Text('Not Found')),
        ),
      );
  }
}
