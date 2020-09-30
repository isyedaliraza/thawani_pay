import 'dart:convert';

import 'package:simple_rsa/simple_rsa.dart';

class ThawaniPayRequest {
  final double amount;
  final String merchantRef;
  final String remark;
  final String email;
  final String language;
  final DateTime paymentExpiryDate;
  final String returnUrl;
  final String callbackUrl;
  final Map<String, dynamic> merchantFields;
  final String successUrl;
  final String nextUrl;

  const ThawaniPayRequest({
    this.amount,
    this.merchantRef,
    this.remark,
    this.email,
    this.language,
    this.paymentExpiryDate,
    this.returnUrl,
    this.callbackUrl,
    this.merchantFields,
    this.successUrl,
    this.nextUrl,
  });

  Future<Map<String, String>> toEncryptedMap(String pbk) async {
    final amount = await encryptString(this.amount.toString(), pbk);
    final merchantRef = await encryptString(this.merchantRef, pbk);
    final remark = await encryptString(this.remark, pbk);
    final email = await encryptString(this.email, pbk);
    final language = await encryptString(this.language, pbk);
    final paymentExpiryDate = await encryptString(
        this.paymentExpiryDate?.toIso8601String() ?? '', pbk);
    final returnUrl = await encryptString(this.returnUrl, pbk);
    final callbackUrl = await encryptString(this.callbackUrl, pbk);
    final merchantFields =
        await encryptString(this.merchantFields.toString(), pbk);
    final successUrl = await encryptString(this.successUrl, pbk);
    final nextUrl = await encryptString(this.nextUrl, pbk);

    return {
      'amount': amount,
      'merchant_reference': merchantRef,
      'remark': remark,
      'email': email,
      'language': language,
      'payment_expiry_date': paymentExpiryDate,
      'return_url': returnUrl,
      'callback_url': callbackUrl,
      'merchant_fields': merchantFields,
      'sucess_url': successUrl,
      'next_url': nextUrl,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'merchant_reference': merchantRef,
      'remark': remark,
      'email': email,
      'language': language,
      'payment_expiry_date': paymentExpiryDate?.millisecondsSinceEpoch,
      'return_url': returnUrl,
      'callback_url': callbackUrl,
      'merchant_fields': merchantFields,
      'sucess_url': successUrl,
      'next_url': nextUrl,
    };
  }

  factory ThawaniPayRequest.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ThawaniPayRequest(
      amount: map['amount'],
      merchantRef: map['merchant_reference'],
      remark: map['remark'],
      email: map['email'],
      language: map['language'],
      paymentExpiryDate: DateTime.parse(map['payment_expiry_date']),
      returnUrl: map['return_url'],
      callbackUrl: map['callback_url'],
      merchantFields: Map<String, dynamic>.from(map['merchant_fields']),
      successUrl: map['sucess_url'],
      nextUrl: map['next_url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ThawaniPayRequest.fromJson(String source) =>
      ThawaniPayRequest.fromMap(json.decode(source));

  ThawaniPayRequest copyWith({
    double amount,
    String merchantRef,
    String remark,
    String email,
    String language,
    DateTime paymentExpiryDate,
    String returnUrl,
    String callbackUrl,
    Map<String, dynamic> merchantFields,
    String successUrl,
    String nextUrl,
  }) {
    return ThawaniPayRequest(
      amount: amount ?? this.amount,
      merchantRef: merchantRef ?? this.merchantRef,
      remark: remark ?? this.remark,
      email: email ?? this.email,
      language: language ?? this.language,
      paymentExpiryDate: paymentExpiryDate ?? this.paymentExpiryDate,
      returnUrl: returnUrl ?? this.returnUrl,
      callbackUrl: callbackUrl ?? this.callbackUrl,
      merchantFields: merchantFields ?? this.merchantFields,
      successUrl: successUrl ?? this.successUrl,
      nextUrl: nextUrl ?? this.nextUrl,
    );
  }
}
