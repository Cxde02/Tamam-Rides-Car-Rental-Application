import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_credit_card/custom_card_type_icon.dart';
import 'package:flutter_credit_card/glassmorphism_config.dart';
import 'package:lottie/lottie.dart';

import '../data/car.dart';
import '../data/car2.dart';
import '../main.dart';
import '../theme/app_colors.dart';
import 'books.dart';

class PaymentMethodScreen extends StatefulWidget {
  late final Car car;
  late final Car2 car2;
  late final Book book;
  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String selectedPaymentMethod = 'Card';
  bool isExpanded = false;

  void changePaymentMethod(String method) {
    setState(() {
      selectedPaymentMethod = method;
      isExpanded = false;
    });
  }

  List<ExpansionPanel> _buildExpansionPanelList() {
    return [
      ExpansionPanel(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        canTapOnHeader: true,
        headerBuilder: (context, isExpanded) {
          IconData selectedIcon =
              CupertinoIcons.money_dollar_circle; // Default icon
          if (selectedPaymentMethod == 'Card') {
            selectedIcon = Icons.credit_card;
          } else if (selectedPaymentMethod == 'PayPal') {
            selectedIcon = Icons.paypal_outlined;
          } else if (selectedPaymentMethod == 'Juice') {
            selectedIcon = Icons.payments_outlined;
          }

          return ListTile(
            selectedTileColor: Theme.of(context).scaffoldBackgroundColor,
            tileColor: Theme.of(context).scaffoldBackgroundColor,
            /*onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },*/
            leading: Icon(
              selectedIcon,
              color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            ),
            title: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontFamily: 'Barlow',
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                      text: selectedPaymentMethod.isNotEmpty
                          ? 'Selected Payment Method: $selectedPaymentMethod\n'
                          : 'Choose Payment Method\n',
                      style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context)
                              .bottomNavigationBarTheme
                              .backgroundColor)),
                  if (selectedPaymentMethod.isNotEmpty)
                    TextSpan(
                      text: '(Tap here to change)',
                      style: TextStyle(
                        fontSize: 11, // You can adjust the font size here
                        color: Colors.grey, // You can adjust the color here
                      ),
                    ),
                ],
              ),
            ),
          );
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: ListTile(
                onTap: () => changePaymentMethod('Card'),
                title: Text('Credit Card',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 14)),
                leading: Icon(
                  Icons.credit_card, // Use the appropriate icon for Credit
                  color: Colors.greenAccent, // You can adjust the color here
                ),
                trailing: Radio(
                  activeColor: Theme.of(context)
                      .bottomNavigationBarTheme
                      .backgroundColor,
                  value: 'Card',
                  groupValue: selectedPaymentMethod,
                  onChanged: (value) => changePaymentMethod(value!),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: ListTile(
                onTap: () => changePaymentMethod('PayPal'),
                title: Text('PayPal',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 14)),
                leading: Icon(
                  Icons.paypal_outlined, // Use the appropriate icon for PayPal
                  color: Colors.blueAccent, // You can adjust the color here
                ),
                trailing: Radio(
                  activeColor: Theme.of(context)
                      .bottomNavigationBarTheme
                      .backgroundColor,
                  value: 'PayPal',
                  groupValue: selectedPaymentMethod,
                  onChanged: (value) => changePaymentMethod(value!),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: ListTile(
                onTap: () => changePaymentMethod('Juice'),
                title: Text('Juice',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 14)),
                leading: Icon(
                  Icons.payments_outlined, // Use the appropriate icon for Juice
                  color: Colors.redAccent, // You can adjust the color here
                ),
                trailing: Radio(
                  activeColor: Theme.of(context)
                      .bottomNavigationBarTheme
                      .backgroundColor,
                  value: 'Juice',
                  groupValue: selectedPaymentMethod,
                  onChanged: (value) => changePaymentMethod(value!),
                ),
              ),
            ),
          ],
        ),
        isExpanded: isExpanded,
      ),
    ];
  }

  Widget buildPaymentMethodPage(String method) {
    switch (method) {
      case 'PayPal':
        return PayPalPaymentPage();
      case 'Card':
        return CreditPaymentPage();
      case 'Juice':
        return JuicePaymentPage();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      /*appBar: AppBar(
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Payment',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
      ),*/
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 50, 16, 15),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  /*child: Container(
                                  height: size.width * 0.1,
                                  width: size.width * 0.1,
                                  decoration: BoxDecoration(
                                    color: kTextColor.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Image.asset('assets/images/back-arrow.png'),
                                  ),
                                ),*/
                  child: Container(
                    height: size.width * 0.1,
                    width: size.width * 0.1,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          offset: Offset(2, 2),
                          blurRadius: 2,
                        ),
                      ],
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: Icon(
                      CupertinoIcons.back,
                      //color: Colors.transparent,
                    )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(2, 35, 0, 0),
                child: Text(
                  'Payment',
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 23),
                ),
              )
            ],
          ),
          ExpansionPanelList(
            expansionCallback: (panelIndex, isExpanded) {
              setState(() {
                this.isExpanded = !isExpanded;
              });
            },
            children: _buildExpansionPanelList(),
          ),

          /*Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
            //color: Colors.blue,
            child: Center(
              child: Text(
                '$selectedPaymentMethod',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  letterSpacing: 1,
                  fontSize: 18,
                ),
              ),
            ),
          ),*/
          Expanded(
            child: AnimatedSwitcher(
              duration: Duration(seconds: 1),
              child: buildPaymentMethodPage(selectedPaymentMethod),
            ),
          ),
        ],
      ),
    );
  }
}

class PayPalPaymentPage extends StatefulWidget {
  @override
  _PayPalPaymentPageState createState() => _PayPalPaymentPageState();
}

class _PayPalPaymentPageState extends State<PayPalPaymentPage> {
  TextEditingController _payPalController = TextEditingController();
  TextEditingController _payPalControllerA = TextEditingController();
  TextEditingController _payPalControllerE = TextEditingController();
  TextEditingController _payPalControllerP = TextEditingController();

  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/paypal-vector-logo.png',
                width: 250, height: 150),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: TextField(
                cursorColor:
                    Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                controller: _payPalController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(
                      color: Theme.of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor!,
                      fontFamily: 'Montserrat'),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Colors.green)),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: TextField(
                keyboardType: TextInputType.number,
                cursorColor:
                    Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                controller: _payPalControllerA,
                decoration: InputDecoration(
                  labelText: 'Account Number',
                  labelStyle: TextStyle(
                      color: Theme.of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor!,
                      fontFamily: 'Montserrat'),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Colors.green)),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                cursorColor:
                    Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                controller: _payPalControllerE,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  labelStyle: TextStyle(
                      color: Theme.of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor!,
                      fontFamily: 'Montserrat'),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Colors.green)),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: TextField(
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                cursorColor:
                    Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                controller: _payPalControllerP,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                      color: Theme.of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor!,
                      fontFamily: 'Montserrat'),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Colors.green)),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                if (_payPalController.text.isEmpty ||
                    _payPalControllerA.text.isEmpty ||
                    _payPalControllerE.text.isEmpty ||
                    _payPalControllerP.text.isEmpty) {
                  {
                    setState(
                      () {
                        _errorMessage =
                            'Empty fields. Please enter PayPal details.';
                      },
                    );
                  }
                } else {
                  // Perform PayPal Payment
                  _payPalPaymentFunction();
                }
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .bottomNavigationBarTheme
                      .backgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 13),
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  'Validate and Pay',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    //package: 'flutter_credit_card',
                  ),
                ),
              ),
            ),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _errorMessage,
                  style: TextStyle(
                      color: Colors.red,
                      fontFamily: 'Barlow',
                      letterSpacing: 0.5),
                ),
              ),
          ],
        ),
      ],
    );
  }

  // Replace this with your PayPal payment logic
  void _payPalPaymentFunction() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Show a loading indicator while performing PayPal payment
        return Center(
          child: Lottie.asset('assets/images/loading_1.json',
              width: 100,
              height: 100), // You can use any loading indicator widget
        );
      },
    );

    // Simulate payment processing delay
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context); // Close the loading dialog

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Payment Successful',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Theme.of(context)
                      .bottomNavigationBarTheme
                      .backgroundColor),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  'assets/images/animation_lkzlqxs6.json', // Replace with your Lottie animation JSON file path
                  height: 100,
                  width: 100,
                ),
                SizedBox(height: 16),
                Text(
                  'Your payment was successful. You will receive an email soon.',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Theme.of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Text(
                  'OK',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Theme.of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor),
                ),
              ),
            ],
          );
        },
      );
    });
  }
}

class CreditPaymentPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreditPaymentPageState();
  }
}

class CreditPaymentPageState extends State<CreditPaymentPage> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = true;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bgcolor = Theme.of(context).scaffoldBackgroundColor;

    return MaterialApp(
      title: 'Flutter Credit Card View Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            color: bgcolor,
          ),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 0,
                ),
                CreditCardWidget(
                  height: 200,
                  width: 350,
                  glassmorphismConfig:
                      useGlassMorphism ? Glassmorphism.defaultConfig() : null,
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  bankName: 'Credit',
                  frontCardBorder: !useGlassMorphism
                      ? Border.all(
                          color: Theme.of(context)
                              .bottomNavigationBarTheme
                              .backgroundColor!)
                      : null,
                  backCardBorder:
                      !useGlassMorphism ? Border.all(color: Colors.grey) : null,
                  showBackView: isCvvFocused,
                  obscureCardNumber: true,
                  obscureCardCvv: true,
                  isHolderNameVisible: true,
                  cardBgColor: AppColors.cardBgColor,
                  backgroundImage:
                      useBackgroundImage ? "assets/images/mc.png" : null,
                  isSwipeGestureEnabled: true,
                  onCreditCardWidgetChange:
                      (CreditCardBrand creditCardBrand) {},
                  customCardTypeIcons: <CustomCardTypeIcon>[
                    CustomCardTypeIcon(
                      cardType: CardType.mastercard,
                      cardImage: Image.asset(
                        'assets/images/mastercard.png',
                        height: 48,
                        width: 48,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        CreditCardForm(
                          formKey: formKey,
                          obscureCvv: true,
                          obscureNumber: true,
                          cardNumber: cardNumber,
                          cvvCode: cvvCode,
                          isHolderNameVisible: true,
                          isCardNumberVisible: true,
                          isExpiryDateVisible: true,
                          cardHolderName: cardHolderName,
                          expiryDate: expiryDate,
                          themeColor: Colors.blue,
                          textColor: Theme.of(context)
                              .bottomNavigationBarTheme
                              .backgroundColor!,
                          cardNumberDecoration: InputDecoration(
                            labelText: 'Number',
                            hintText: 'XXXX XXXX XXXX XXXX',
                            hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .bottomNavigationBarTheme
                                    .backgroundColor!,
                                fontFamily: 'Barlow'),
                            labelStyle: TextStyle(
                                color: Theme.of(context)
                                    .bottomNavigationBarTheme
                                    .backgroundColor!,
                                fontFamily: 'Montserrat'),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Colors.green)),
                            border: OutlineInputBorder(),
                            enabledBorder: border,
                          ),
                          expiryDateDecoration: InputDecoration(
                            hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .bottomNavigationBarTheme
                                    .backgroundColor!,
                                fontFamily: 'Barlow'),
                            labelStyle: TextStyle(
                                color: Theme.of(context)
                                    .bottomNavigationBarTheme
                                    .backgroundColor!,
                                fontFamily: 'Montserrat'),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Colors.green)),
                            border: OutlineInputBorder(),
                            enabledBorder: border,
                            labelText: 'Expired Date',
                            hintText: 'XX/XX',
                          ),
                          cvvCodeDecoration: InputDecoration(
                            hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .bottomNavigationBarTheme
                                    .backgroundColor!,
                                fontFamily: 'Barlow'),
                            labelStyle: TextStyle(
                                color: Theme.of(context)
                                    .bottomNavigationBarTheme
                                    .backgroundColor!,
                                fontFamily: 'Montserrat'),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Colors.green)),
                            border: OutlineInputBorder(),
                            enabledBorder: border,
                            labelText: 'CVV',
                            hintText: 'XXX',
                          ),
                          cardHolderDecoration: InputDecoration(
                            hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .bottomNavigationBarTheme
                                    .backgroundColor!,
                                fontFamily: 'Barlow'),
                            labelStyle: TextStyle(
                                color: Theme.of(context)
                                    .bottomNavigationBarTheme
                                    .backgroundColor!,
                                fontFamily: 'Montserrat'),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Colors.green)),
                            border: OutlineInputBorder(),
                            enabledBorder: border,
                            labelText: 'Card Holder',
                          ),
                          onCreditCardModelChange: onCreditCardModelChange,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        /*Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                'Glassmorphism',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              const Spacer(),
                              Switch(
                                value: useGlassMorphism,
                                inactiveTrackColor: Colors.grey,
                                activeColor: Colors.white,
                                activeTrackColor: AppColors.colorE5D1B2,
                                onChanged: (bool value) => setState(() {
                                  useGlassMorphism = value;
                                }),
                              ),
                            ],
                          ),
                        ),*/
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Card Image',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .bottomNavigationBarTheme
                                      .backgroundColor!,
                                  fontFamily: 'Montserrat',
                                  fontSize: 15,
                                ),
                              ),
                              const Spacer(),
                              Switch(
                                value: useBackgroundImage,
                                inactiveTrackColor: Colors.grey,
                                activeColor: Colors.white,
                                activeTrackColor: AppColors.cardBgColor,
                                onChanged: (bool value) => setState(() {
                                  useBackgroundImage = value;
                                }),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        GestureDetector(
                          onTap: _onValidate,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .bottomNavigationBarTheme
                                  .backgroundColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Text(
                              'Validate and Pay',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                                //package: 'flutter_credit_card',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onValidate() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Lottie.asset('assets/images/loading_1.json',
              width: 100,
              height: 100), // You can use any loading indicator widget
        ); // Show loading animation dialog
      },
    );

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context);
      if (formKey.currentState!.validate()) {
        // Show payment successful pop-up
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Payment Successful',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Theme.of(context)
                        .bottomNavigationBarTheme
                        .backgroundColor),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset(
                    'assets/images/animation_lkzlqxs6.json', // Replace with your Lottie animation JSON file path
                    height: 100,
                    width: 100,
                  ),
                  SizedBox(height: 16),
                  Text(
                      'Your payment was successful. You will receive an email soon.',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Theme.of(context)
                              .bottomNavigationBarTheme
                              .backgroundColor)),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    //Navigator.pop(context);
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Theme.of(context)
                            .bottomNavigationBarTheme
                            .backgroundColor),
                  ),
                ),
              ],
            );
          },
        );
      } else {
        print('invalid!');
      }
    });
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}

class JuicePaymentPage extends StatefulWidget {
  @override
  _JuicePaymentPageState createState() => _JuicePaymentPageState();
}

class _JuicePaymentPageState extends State<JuicePaymentPage> {
  TextEditingController _payPalController = TextEditingController();
  TextEditingController _payPalControllerA = TextEditingController();

  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/juice.png', width: 250, height: 190),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: TextField(
                cursorColor:
                    Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                controller: _payPalController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(
                      color: Theme.of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor!,
                      fontFamily: 'Montserrat'),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Colors.green)),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: TextField(
                keyboardType: TextInputType.number,
                cursorColor:
                    Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                controller: _payPalControllerA,
                decoration: InputDecoration(
                  labelText: 'Account Number',
                  labelStyle: TextStyle(
                      color: Theme.of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor!,
                      fontFamily: 'Montserrat'),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Colors.green)),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                if (_payPalController.text.isEmpty ||
                    _payPalControllerA.text.isEmpty) {
                  {
                    setState(
                      () {
                        _errorMessage =
                            'Empty fields. Please enter Juice details.';
                      },
                    );
                  }
                } else {
                  // Perform PayPal Payment
                  _payPalPaymentFunction();
                }
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .bottomNavigationBarTheme
                      .backgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 13),
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  'Validate and Pay',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    //package: 'flutter_credit_card',
                  ),
                ),
              ),
            ),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _errorMessage,
                  style: TextStyle(
                      color: Colors.red,
                      fontFamily: 'Barlow',
                      letterSpacing: 0.5),
                ),
              ),
          ],
        ),
      ],
    );
  }

  // Replace this with your PayPal payment logic
  void _payPalPaymentFunction() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Show a loading indicator while performing PayPal payment
        return Center(
          child: Lottie.asset('assets/images/loading_1.json',
              width: 100,
              height: 100), // You can use any loading indicator widget
        );
      },
    );

    // Simulate payment processing delay
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context); // Close the loading dialog

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Payment Successful',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Theme.of(context)
                      .bottomNavigationBarTheme
                      .backgroundColor),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  'assets/images/animation_lkzlqxs6.json', // Replace with your Lottie animation JSON file path
                  height: 100,
                  width: 100,
                ),
                SizedBox(height: 16),
                Text(
                  'Your payment was successful. You will receive an email soon.',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Theme.of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Text(
                  'OK',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Theme.of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor),
                ),
              ),
            ],
          );
        },
      );
    });
  }
}
