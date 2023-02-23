import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/app_router.dart';

class QuoteRequestApp extends ConsumerWidget {
  const QuoteRequestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    return ProviderScope(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'MVC Riverpod Freezed App',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
        routerDelegate: router.routerDelegate,
      ),
    );
  }
}
