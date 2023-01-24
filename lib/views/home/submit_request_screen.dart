import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_request_app/common/data_state.dart';
import '../widgets/loading_widget.dart';

import '../../common/form_validator.dart';
import '../../common/providers.dart';
import '../../common/styles.dart';

class RequestQuoteScreen extends ConsumerStatefulWidget {
  const RequestQuoteScreen({Key? key}) : super(key: key);

  @override
  RequestQuoteScreenState createState() => RequestQuoteScreenState();
}

class RequestQuoteScreenState extends ConsumerState<RequestQuoteScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _productLinkController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  void _handleFormSubmission() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Map<String, dynamic> data = {
        'product_name': _productNameController.text,
        'product_link': _productLinkController.text,
        'description': _descriptionController.text,
        'quantity': _quantityController.text,
      };

      ref.read(estimateNotifierProvider.notifier).submitQuote(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<DataState>(estimateNotifierProvider, (_, state) {
      state.maybeWhen(
        success: (_) => Navigator.of(context).pop(),
        error: (error, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $error')),
          );
        },
        orElse: () {},
      );
    });

    final quoteState = ref.watch(estimateNotifierProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        elevation: 2.0,
        title: const Text(
          'Request an estimate',
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
            const Text(
              "Link to the product",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _productLinkController,
              keyboardType: TextInputType.url,
              decoration: const InputDecoration(
                hintText: 'https://www.amazon.fr/dp/289225955X',
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: AppInputBorder.enabledBorder,
                focusedBorder: AppInputBorder.focusedBorder,
                errorBorder: AppInputBorder.errorBorder,
                focusedErrorBorder: AppInputBorder.focusedErrorBorder,
                contentPadding: EdgeInsets.all(10),
              ),
              validator: FormValidator.validateProductLink,
            ),
            const SizedBox(height: 16),
            const Text(
              "Product name",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _productNameController,
              decoration: const InputDecoration(
                hintText: 'Enter product name',
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: AppInputBorder.enabledBorder,
                focusedBorder: AppInputBorder.focusedBorder,
                errorBorder: AppInputBorder.errorBorder,
                contentPadding: EdgeInsets.all(10),
              ),
              validator: FormValidator.validateProductName,
            ),
            const SizedBox(height: 16),
            const Text(
              "Description",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                hintText: 'Product details',
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: AppInputBorder.enabledBorder,
                focusedBorder: AppInputBorder.focusedBorder,
                errorBorder: AppInputBorder.errorBorder,
                contentPadding: EdgeInsets.all(10),
              ),
              maxLines: 6,
              validator: FormValidator.validateProductDescription,
            ),
            const SizedBox(height: 16),
            const Text(
              "Quantity",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Product quantity',
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: AppInputBorder.enabledBorder,
                focusedBorder: AppInputBorder.focusedBorder,
                errorBorder: AppInputBorder.errorBorder,
                contentPadding: EdgeInsets.all(10),
              ),
              validator: FormValidator.validateProductQuantity,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: quoteState.maybeWhen(
                loading: () => null,
                orElse: () => _handleFormSubmission,
              ),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: quoteState.maybeWhen(
                loading: () => const LoadingWidget(),
                orElse: () => const Text('SUBMIT REQUEST'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
