import 'package:flutter/material.dart';
import 'package:thawani_pay/thawani_pay.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thawani Pay Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Thawani Pay Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: RaisedButton(
                  onPressed: _payViaThawani,
                  color: Colors.green,
                  textColor: Colors.white,
                  shape: StadiumBorder(),
                  child: Text('Pay via Thawani'),
                ),
              ),
      ),
    );
  }

  void _payViaThawani() {
    setState(() {
      _loading = true;
    });

    String merchantPublicKey =
        'MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCZ9dLQREi8B01ZYXAbabjwNuEXLbUnWTvbAJWKgiX7yzZ9khG6TKZgW6jCy4j6zuAu3PaeS3ULi07yz4tzw5C2HHLwU2YLJmDF5/nNxPoSYa9G/W1OzT4+XuznOKCAsEqR353wzy3ZG6D2B4kNSXu6mXAGnyEKZUMl0/x1e1Nj9wIDAQAB';
    String merchantPrivateKey = 'nc1Zbyl5o0QHHV5E3E2iARHj2aPzjvvjQLAEqn29t14=';

    final ThawaniPay _thawaniPay = ThawaniPay(
      merchantPublicKey: merchantPublicKey,
      merchantPrivateKey: merchantPrivateKey,
      thawaniPayRequest: ThawaniPayRequest(
        amount: .100,
        merchantRef: '060320202',
        remark: 'Thawani pay flutter demo',
        email: '1@2.com',
        language: 'ar',
        paymentExpiryDate: DateTime.now().add(Duration(minutes: 90)),
        returnUrl: '',
        callbackUrl: '',
        merchantFields: {},
        successUrl: 'https://bdtc.io',
        nextUrl: '',
      ),
    );

    _thawaniPay
        .initiatePaymentFlow(context)
        .then((value) => setState(() => _loading = false));
  }
}
