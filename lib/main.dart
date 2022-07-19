import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quote_request_app/screens/auth/login_screen.dart';

import 'common/routes.dart' as routes;

void main() {
  runApp(const QuoteRequestApp());
}

class QuoteRequestApp extends StatelessWidget {
  const QuoteRequestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Riverpod Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          textTheme: GoogleFonts.dosisTextTheme(),
        ),
        onGenerateRoute: routes.onGenerate,
        home: const LoginScreen(),
      ),
    );
  }
}
