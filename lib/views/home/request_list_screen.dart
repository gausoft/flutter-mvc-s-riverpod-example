import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../common/app_router.dart';
import '../../common/providers.dart';
import '../widgets/no_data_widget.dart';
import '../widgets/request_quote_row.dart';

class RequestListScreen extends ConsumerStatefulWidget {
  const RequestListScreen({Key? key}) : super(key: key);

  @override
  RequestListScreenState createState() => RequestListScreenState();
}

class RequestListScreenState extends ConsumerState<RequestListScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(estimateNotifierProvider.notifier).getQuotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        elevation: 2.0,
        title: const Text(
          'Estimates list',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final quotesListState = ref.watch(estimateNotifierProvider);
          final aaaa = ref.watch(confirmDialogProvider(context));
          return quotesListState.maybeWhen(
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            success: (quotes) {
              if (quotes.isEmpty) return const NoDataWidget();

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: quotes.length,
                itemBuilder: (context, index) {
                  final quote = quotes[index];
                  return Dismissible(
                    key: UniqueKey(),
                    confirmDismiss: (_) => ref.watch(
                      confirmDialogProvider(context),
                    ),
                    onDismissed: (direction) {
                      ref
                          .read(estimateNotifierProvider.notifier)
                          .delete(quote.id!);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Quote deleted successfully!'),
                        ),
                      );
                    },
                    child: RequestQuoteRow(quote: quote),
                  );
                },
              );
            },
            error: (err, _) => Center(child: Text(err)),
            orElse: () => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.pushNamed(AppRoutes.submitRequest.name),
        label: Row(
          children: const [
            Icon(Icons.pending_actions),
            SizedBox(width: 8),
            Text(
              'Request estimate',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    );
  }
}
