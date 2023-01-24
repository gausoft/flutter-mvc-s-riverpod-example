import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../controllers/auth_notifier.dart';
import '../controllers/estimate_notifier.dart';
import '../services/auth_service.dart';
import '../services/estimate_service.dart';
import '../views/widgets/delete_item_dialog.dart';
import 'constants.dart';
import 'data_state.dart';

final dioProvider = Provider<Dio>(
  (ref) => Dio(
    BaseOptions(
      headers: {
        'apikey': kApiKey,
        'Prefer': 'return=representation',
      },
      baseUrl: kBaseUrl,
    ),
  ),
);

final dateFormatProvider = Provider((_) {
  initializeDateFormatting();

  return DateFormat('yyyy-MM-dd hh:mm');
});

final confirmDialogProvider =
    Provider.family((ref, BuildContext context) async {
  return await showDialog<Future<bool?>>(
    context: context,
    builder: (BuildContext context) {
      return const DeteleItemDialog();
    },
  );
});

//Services
final estimateServiceProvider = Provider<EstimateService>(
  (ref) => EstimateService(ref.read(dioProvider)),
);

final authServiceProvider = Provider<AuthService>(
  (ref) => AuthService(ref.read(dioProvider)),
);

//Notifiers
final estimateNotifierProvider =
    StateNotifierProvider<EstimateNotifier, DataState>(
  (ref) => EstimateNotifier(ref.read(estimateServiceProvider)),
);

final authNotifier = StateNotifierProvider<AuthNotifier, DataState>(
  (ref) => AuthNotifier(ref.read(authServiceProvider)),
);
