import 'package:equatable/equatable.dart';

import '../models/quote_model.dart';

abstract class QuotesListState extends Equatable {
  const QuotesListState();
}

class QuotesListInitial extends QuotesListState {
  const QuotesListInitial();
  
  @override
  List<Object?> get props => [];
}

class QuotesListLoading extends QuotesListState {
  const QuotesListLoading();
  
  @override
  List<Object?> get props => [];
}

class QuotesListLoaded extends QuotesListState {
  const QuotesListLoaded(this.quotes);

  final List<Quote> quotes;

  @override
  List<Object?> get props => [quotes];
}

class QuotesListError extends QuotesListState {
  const QuotesListError(this.message);

  final String message;
  
  @override
  List<Object?> get props => [message];
}
