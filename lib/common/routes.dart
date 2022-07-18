import 'package:flutter/cupertino.dart';

import '../screens/home_screen.dart';
import '../screens/submit_request_screen.dart';

Route<dynamic> onGenerate(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return CupertinoPageRoute(
        settings: settings,
        builder: (_) => const HomeScreen(),
      );
    case '/request-quote':
      return CupertinoPageRoute(
        settings: settings,
        builder: (BuildContext context) => const RequestQuoteScreen(),
      );
    default:
      return CupertinoPageRoute(
        settings: settings,
        builder: (_) => const CupertinoPageScaffold(child: SizedBox()),
      );
  }
}
