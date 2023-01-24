import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_router.dart';
import '../../../core/data_state.dart';
import '../../../core/form_validator.dart';
import '../../../core/providers.dart';
import '../../../core/styles.dart';
import '../../../core/widgets/loading_widget.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  RegisterViewState createState() => RegisterViewState();
}

class RegisterViewState extends ConsumerState<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _fullnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _addressController = TextEditingController();

  bool _hidePassword = true;
  bool _hidePasswordConfirm = true;

  void _handleUserRegistration() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final Map<String, dynamic> userData = {
        'email': _emailController.text,
        'password': _passwordController.text,
        'data': {
          'fullname': _fullnameController.text,
          'address': _addressController.text,
        },
      };

      ref.read(authNotifier.notifier).register(userData);
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  void _togglePasswordConfirmVisibility() {
    setState(() {
      _hidePasswordConfirm = !_hidePasswordConfirm;
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<DataState>(authNotifier, (_, state) {
      state.maybeWhen(
        success: (user) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Registration successful. Please login.'),
              backgroundColor: Colors.green,
            ),
          );
          context.goNamed(AppRoutes.login.name);
        },
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

    final authState = ref.watch(authNotifier);

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        elevation: 2.0,
        title: const Text(
          'Register',
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
            const SizedBox(height: 16),
            const Text(
              "Fullname",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _fullnameController,
              decoration: const InputDecoration(
                hintText: 'Enter your fullname',
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: AppInputBorder.enabledBorder,
                focusedBorder: AppInputBorder.focusedBorder,
                errorBorder: AppInputBorder.errorBorder,
                focusedErrorBorder: AppInputBorder.focusedErrorBorder,
                contentPadding: EdgeInsets.all(10),
              ),
              validator: FormValidator.validateFullName,
            ),
            const SizedBox(height: 16),
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
                    _hidePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: _togglePasswordVisibility,
                ),
              ),
              validator: FormValidator.validatePassword,
            ),
            const SizedBox(height: 16),
            const Text(
              "Password confirmation",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _passwordConfirmController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: _hidePasswordConfirm,
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
                    _hidePasswordConfirm
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: _togglePasswordConfirmVisibility,
                ),
              ),
              validator: (value) => FormValidator.validatePasswordConfirmation(
                value,
                _passwordController.text,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Address",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _addressController,
              keyboardType: TextInputType.streetAddress,
              decoration: const InputDecoration(
                hintText: 'Enter your address',
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: AppInputBorder.enabledBorder,
                focusedBorder: AppInputBorder.focusedBorder,
                errorBorder: AppInputBorder.errorBorder,
                focusedErrorBorder: AppInputBorder.focusedErrorBorder,
                contentPadding: EdgeInsets.all(10),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: authState.maybeWhen(
                  loading: () => null,
                  orElse: () => _handleUserRegistration,
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
                  orElse: () => const Text('REGISTER'),
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
                Text("You already have an account?"),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('LOGIN'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
