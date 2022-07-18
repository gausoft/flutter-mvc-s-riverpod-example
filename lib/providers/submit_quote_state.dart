import 'package:equatable/equatable.dart';

import '../models/quote_model.dart';

abstract class SubmitQuoteState extends Equatable {}

class SubmitQuoteInitial extends SubmitQuoteState {
  @override
  List<Object> get props => [];
}

class SubmitQuoteLoading extends SubmitQuoteState {
  @override
  List<Object> get props => [];
}

class SubmitQuoteSuccess extends SubmitQuoteState {
  final Quote quote;

  SubmitQuoteSuccess(this.quote);
  
  @override
  List<Object> get props => [quote];
}

class SubmitQuoteError extends SubmitQuoteState {
  final String message;

  SubmitQuoteError(this.message);

  @override
  List<Object> get props => [message];
}
