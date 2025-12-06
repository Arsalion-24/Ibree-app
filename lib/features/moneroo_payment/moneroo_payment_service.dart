import 'dart:convert';
import 'dart:io';

import 'package:ebeere/core/constants/api_exception.dart';
import 'package:ebeere/core/constants/constants.dart';
import 'package:ebeere/utils/api_utils.dart';
import 'package:http/http.dart' as http;

final class MonerooPaymentService {
  static const String monerooBaseUrl = 'https://api.moneroo.io';
  static const String monerooPublicKey = 'YOUR_MONEROO_PUBLIC_KEY';
  static const String monerooSecretKey = 'YOUR_MONEROO_SECRET_KEY';

  Future<Map<String, dynamic>> initiatePayment({
    required String userId,
    required double amount,
    required String currency,
    required String description,
  }) async {
    try {
      final rawRes = await http.post(
        Uri.parse('$monerooBaseUrl/v1/payments/initialize'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $monerooPublicKey',
        },
        body: jsonEncode({
          'amount': amount,
          'currency': currency,
          'description': description,
          'return_url': 'https://ebeere.com/payment/success',
          'cancel_url': 'https://ebeere.com/payment/cancel',
          'customer': {
            'user_id': userId,
          },
        }),
      );

      final res = jsonDecode(rawRes.body) as Map<String, dynamic>;

      if (res['error'] != null && res['error'] as bool) {
        throw ApiException(res['message'].toString());
      }

      return res;
    } on SocketException catch (_) {
      throw const ApiException(errorCodeNoInternet);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> verifyPayment({required String transactionId}) async {
    try {
      final rawRes = await http.get(
        Uri.parse('$monerooBaseUrl/v1/payments/$transactionId'),
        headers: {
          'Authorization': 'Bearer $monerooSecretKey',
        },
      );

      final res = jsonDecode(rawRes.body) as Map<String, dynamic>;

      if (res['error'] != null && res['error'] as bool) {
        throw ApiException(res['message'].toString());
      }

      final status = res['data']?['status'] as String?;
      return status == 'success' || status == 'completed';
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> processMobileMoneyPayment({
    required String userId,
    required double amount,
    required String phoneNumber,
    required String provider,
  }) async {
    try {
      final rawRes = await http.post(
        Uri.parse('$monerooBaseUrl/v1/payments/mobile-money'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $monerooPublicKey',
        },
        body: jsonEncode({
          'amount': amount,
          'currency': 'XOF',
          'phone_number': phoneNumber,
          'provider': provider,
          'description': 'Kauris Purchase',
          'customer': {
            'user_id': userId,
          },
        }),
      );

      final res = jsonDecode(rawRes.body) as Map<String, dynamic>;

      if (res['error'] != null && res['error'] as bool) {
        throw ApiException(res['message'].toString());
      }

      return true;
    } on SocketException catch (_) {
      throw const ApiException(errorCodeNoInternet);
    } catch (e) {
      rethrow;
    }
  }
}
