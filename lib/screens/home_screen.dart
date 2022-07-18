import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/providers.dart';
import '../common/utils.dart';
import '../providers/quotes_list_state.dart';
import 'widgets/no_data_widget.dart';
import 'widgets/request_quote_row.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
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

          if (quotesListState is QuotesListLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (quotesListState is QuotesListError) {
            return Center(
              child: Text(quotesListState.message),
            );
          } else {
            final quotesList = (quotesListState as QuotesListLoaded).quotes;
            return quotesList.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: quotesList.length,
                    itemBuilder: (context, index) {
                      final quote = quotesList[index];
                      return Dismissible(
                        key: UniqueKey(),
                        confirmDismiss: (_) async => openConfirmDialog(context),
                        onDismissed: (direction) {
                          ref
                              .read(quotesListNotifier.notifier)
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
                  )
                : const Center(child: NoDataWidget());
          }
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
