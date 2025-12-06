import 'package:bloc/bloc.dart';
import 'package:ebeere/features/moneroo_payment/moneroo_payment_service.dart';
import 'package:equatable/equatable.dart';

abstract class MonerooPaymentState extends Equatable {
  const MonerooPaymentState();

  @override
  List<Object?> get props => [];
}

class MonerooPaymentInitial extends MonerooPaymentState {}

class MonerooPaymentInProgress extends MonerooPaymentState {}

class MonerooPaymentSuccess extends MonerooPaymentState {
  const MonerooPaymentSuccess({required this.transactionId});

  final String transactionId;

  @override
  List<Object?> get props => [transactionId];
}

class MonerooPaymentFailure extends MonerooPaymentState {
  const MonerooPaymentFailure({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}

class MonerooPaymentCubit extends Cubit<MonerooPaymentState> {
  MonerooPaymentCubit() : super(MonerooPaymentInitial());

  final MonerooPaymentService _paymentService = MonerooPaymentService();

  Future<void> initiatePayment({
    required String userId,
    required double amount,
    required String currency,
    required String description,
  }) async {
    emit(MonerooPaymentInProgress());
    try {
      final result = await _paymentService.initiatePayment(
        userId: userId,
        amount: amount,
        currency: currency,
        description: description,
      );

      final transactionId = result['data']?['transaction_id'] as String?;
      if (transactionId != null) {
        emit(MonerooPaymentSuccess(transactionId: transactionId));
      } else {
        emit(const MonerooPaymentFailure(errorMessage: 'Payment initialization failed'));
      }
    } catch (e) {
      emit(MonerooPaymentFailure(errorMessage: e.toString()));
    }
  }

  Future<void> processMobileMoneyPayment({
    required String userId,
    required double amount,
    required String phoneNumber,
    required String provider,
  }) async {
    emit(MonerooPaymentInProgress());
    try {
      final success = await _paymentService.processMobileMoneyPayment(
        userId: userId,
        amount: amount,
        phoneNumber: phoneNumber,
        provider: provider,
      );

      if (success) {
        emit(const MonerooPaymentSuccess(transactionId: 'mobile_money_tx'));
      } else {
        emit(const MonerooPaymentFailure(errorMessage: 'Mobile money payment failed'));
      }
    } catch (e) {
      emit(MonerooPaymentFailure(errorMessage: e.toString()));
    }
  }

  Future<void> verifyPayment({required String transactionId}) async {
    try {
      final isVerified = await _paymentService.verifyPayment(
        transactionId: transactionId,
      );

      if (isVerified) {
        emit(MonerooPaymentSuccess(transactionId: transactionId));
      } else {
        emit(const MonerooPaymentFailure(errorMessage: 'Payment verification failed'));
      }
    } catch (e) {
      emit(MonerooPaymentFailure(errorMessage: e.toString()));
    }
  }
}
