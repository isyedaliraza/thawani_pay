import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';
import 'models/thawani_pay_request.dart';

class ThawaniPay {
  final String _merchantPublicKey;
  final String _merchantPrivateKey;
  final ThawaniPayRequest _thawaniPayRequest;

  const ThawaniPay({
    @required String merchantPublicKey,
    @required String merchantPrivateKey,
    @required ThawaniPayRequest thawaniPayRequest,
  })  : assert(merchantPublicKey != null &&
            merchantPrivateKey != null &&
            thawaniPayRequest != null),
        _merchantPublicKey = merchantPublicKey,
        _merchantPrivateKey = merchantPrivateKey,
        _thawaniPayRequest = thawaniPayRequest;

  Future<void> initiatePaymentFlow(BuildContext context) async {
    final encryptedBody =
        await _thawaniPayRequest.toEncryptedMap(_merchantPublicKey);

    final result = await http.post(
      K.thawaniNewPaymentPostUrl,
      headers: {
        'authorization': 'Bearer $_merchantPrivateKey',
        'content-type': 'application/json',
      },
      body: jsonEncode(encryptedBody),
    );

    print(result.body);
  }
}
