import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../views/auth/login_screen.dart';
import '../views/auth/register_screen.dart';
import '../views/home/request_list_screen.dart';
import '../views/home/submit_request_screen.dart';

enum AppRoutes {
  login('/login'),
  register('/register'),
  home('/home'),
  submitRequest('/submit');

  const AppRoutes(this.path);

  final String path;
}

Page errorPage(BuildContext context, GoRouterState state) {
  return CupertinoPage<Widget>(
    child: const Scaffold(),
    key: state.pageKey,
  );
}

class AppRouter {
  AppRouter(this.ref);

  final Ref ref;

  GoRouter get router {
    return GoRouter(
      initialLocation: AppRoutes.home.path,
      errorPageBuilder: errorPage,
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: AppRoutes.login.path,
          name: AppRoutes.login.name,
          pageBuilder: (context, state) => CupertinoPage<LoginScreen>(
            child: const LoginScreen(),
            key: state.pageKey,
            restorationId: state.pageKey.value,
          ),
        ),
        GoRoute(
          path: AppRoutes.register.path,
          name: AppRoutes.register.name,
          pageBuilder: (context, state) => CupertinoPage<RegisterScreen>(
            child: const RegisterScreen(),
            key: state.pageKey,
            restorationId: state.pageKey.value,
          ),
        ),
        GoRoute(
          path: AppRoutes.home.path,
          name: AppRoutes.home.name,
          pageBuilder: (context, state) => CupertinoPage<RequestListScreen>(
            child: const RequestListScreen(),
            key: state.pageKey,
            restorationId: state.pageKey.value,
          ),
        ),
        GoRoute(
          path: AppRoutes.submitRequest.path,
          name: AppRoutes.submitRequest.name,
          pageBuilder: (context, state) => CupertinoPage<RequestQuoteScreen>(
            child: const RequestQuoteScreen(),
            key: state.pageKey,
            restorationId: state.pageKey.value,
          ),
        ),
      ]
    );
  }
}

final goRouterProvider = Provider<GoRouter>((ref) {
  return AppRouter(ref).router;
});
