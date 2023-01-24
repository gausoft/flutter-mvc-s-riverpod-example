import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/views/login_view.dart';
import '../features/auth/views/register_view.dart';
import '../features/estimates/views/estimate_form_view.dart';
import '../features/estimates/views/estimates_vew.dart';

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
          pageBuilder: (context, state) => CupertinoPage<LoginView>(
            child: const LoginView(),
            key: state.pageKey,
            restorationId: state.pageKey.value,
          ),
        ),
        GoRoute(
          path: AppRoutes.register.path,
          name: AppRoutes.register.name,
          pageBuilder: (context, state) => CupertinoPage<RegisterView>(
            child: const RegisterView(),
            key: state.pageKey,
            restorationId: state.pageKey.value,
          ),
        ),
        GoRoute(
          path: AppRoutes.home.path,
          name: AppRoutes.home.name,
          pageBuilder: (context, state) => CupertinoPage<EstimatesView>(
            child: const EstimatesView(),
            key: state.pageKey,
            restorationId: state.pageKey.value,
          ),
        ),
        GoRoute(
          path: AppRoutes.submitRequest.path,
          name: AppRoutes.submitRequest.name,
          pageBuilder: (context, state) => CupertinoPage<EstimateFormView>(
            child: const EstimateFormView(),
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
