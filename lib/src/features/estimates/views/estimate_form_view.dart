import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_request_app/src/core/widgets/estimate_form.dart';

import '../../../core/data_state.dart';
import '../../../core/providers.dart';
import '../models/quote_model.dart';

class EstimateFormView extends ConsumerStatefulWidget {
  const EstimateFormView({Key? key}) : super(key: key);

  @override
  EstimateFormViewState createState() => EstimateFormViewState();
}

class EstimateFormViewState extends ConsumerState<EstimateFormView> {
  void _onSubmitted(Quote quote) {
    ref.read(estimateNotifierProvider.notifier).submitQuote(quote.toJson());
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
      body: EstimateForm(onSubmitted: _onSubmitted),
    );
  }
}
