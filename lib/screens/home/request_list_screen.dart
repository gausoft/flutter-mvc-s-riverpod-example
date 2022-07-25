import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/providers.dart';
import '../../common/utils.dart';
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
    ref.read(quotesListNotifier.notifier).getQuotes();
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
          final quotesListState = ref.watch(quotesListNotifier);

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
                    confirmDismiss: (_) async => openConfirmDialog(context),
                    onDismissed: (direction) {
                      ref.read(quotesListNotifier.notifier).delete(quote.id!);
                      
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
            error: (err) => Center(child: Text(err)),
            orElse: () => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, '/request-quote'),
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
