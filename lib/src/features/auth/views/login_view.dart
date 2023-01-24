import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/data_state.dart';
import '../../../core/form_validator.dart';
import '../../../core/providers.dart';
import '../../../core/styles.dart';
import '../../../core/widgets/loading_widget.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends ConsumerState<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _hidePassword = true;

  void _handleUserLogin() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Map<String, dynamic> credentials = {
        'email': _emailController.text,
        'password': _passwordController.text,
      };

      ref.read(authNotifier.notifier).login(credentials);
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifier);

    ref.listen<DataState>(authNotifier, (_, state) {
      state.maybeWhen(
        success: (user) => Navigator.pushReplacementNamed(
          context,
          '/request-list',
        ),
        error: (err, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(err),
              backgroundColor: Colors.red,
            ),
          );
        },
        orElse: () {},
      );
    });

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        elevation: 2.0,
        title: const Text(
          'Login',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Icon(Icons.lock_open, size: 64, color: Colors.white),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Email address",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'yourname@email.com',
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: AppInputBorder.enabledBorder,
                focusedBorder: AppInputBorder.focusedBorder,
                errorBorder: AppInputBorder.errorBorder,
                focusedErrorBorder: AppInputBorder.focusedErrorBorder,
                contentPadding: EdgeInsets.all(10),
              ),
              validator: FormValidator.validateEmail,
            ),
            const SizedBox(height: 16),
            const Text(
              "Password",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: _hidePassword,
              decoration: InputDecoration(
                hintText: '*******************',
                labelStyle: const TextStyle(color: Colors.grey),
                enabledBorder: AppInputBorder.enabledBorder,
                focusedBorder: AppInputBorder.focusedBorder,
                errorBorder: AppInputBorder.errorBorder,
                focusedErrorBorder: AppInputBorder.focusedErrorBorder,
                contentPadding: const EdgeInsets.all(10),
                suffixIcon: IconButton(
                  icon: Icon(
                    _hidePassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: _togglePasswordVisibility,
                ),
              ),
              validator: FormValidator.validatePassword,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: authState.maybeWhen(
                  loading: () => null,
                  orElse: () => _handleUserLogin,
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: authState.maybeWhen(
                  loading: () => const LoadingWidget(),
                  orElse: () => const Text('LOGIN'),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Divider(height: 64),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text("Don't have an account?"),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pushNamed(context, '/register'),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('CREATE ACCOUNT'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
