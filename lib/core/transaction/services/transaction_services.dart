import 'dart:developer';

import 'package:bankly_task/core/transaction/model/transaction_model/transaction_model.dart';
import 'package:dio/dio.dart';

class TransactionServices {
  final dio = Dio();

  Future<List<TransactionModel>> getTransactions() async {
    try {
      log("Get transactions initiated");

      final response = await dio.get(
          "https://646b7d727d3c1cae4ce3e29f.mockapi.io/api/vi/transactions");

      log("Get transaction response: ${response.data}");

      if (response.statusCode == 200) {
        List<TransactionModel> model = [];

        for (var element in response.data) {
          model.add(TransactionModel.fromJson(element));
        }
        return model;
      } else {
        throw response.data;
      }
    } catch (e) {
      rethrow;
    }
  }
}
