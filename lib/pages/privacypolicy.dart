// ignore: file_names
import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  final List<PrivacyPolicyItem> privacyPolicyItems = [
    PrivacyPolicyItem(
        question: 'Personal information we collect',
        answer:
            'Account data, location data, usage data, device data and identity verification data.'),
    PrivacyPolicyItem(
      question: 'How we use your personal information?',
      answer:
          'To provide and operate the services, to facilitate your login, to personalize or customize your user experience and process transactions and send notices about your transactions.',
    ),
    PrivacyPolicyItem(
      question: 'How we disclose your personal information?',
      answer:
          'With service providers, third-party platforms and social media networks.',
    ),
    PrivacyPolicyItem(
      question: 'Other important information?',
      answer:
          'We ask you not to send us, and not disclose any sensitive information. The services are not intended for anyone under the age of 18 and we do not collect personal information from users under the age of 18.',
    ),
    PrivacyPolicyItem(
      question: 'Security',
      answer:
          'We employ a number of technical, physical and organizational measures designed to protect information against unauthorized access, destruction or alteration while it is under our control. However, no method of transmitting or storing information can be 100% secure and we cannot guarantee the security of your personal information.',
    ),
    PrivacyPolicyItem(
      question: 'Changes to privacy policy',
      answer:
          'We may change the privacy policy. Your use of the services following these changes means that you accept the revised Privacy Policy, If you do not agree to these changes, you can contact us to close your account.',
    ),
    PrivacyPolicyItem(
        question: 'Contact',
        answer:
            'You may contact us via the contact page itself, or by phone call or email.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Privacy Policy',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      ),
      body: ListView.builder(
        itemCount: privacyPolicyItems.length,
        itemBuilder: (context, index) {
          return PrivacyPolicyItemWidget(
              privacyPolicyItem: privacyPolicyItems[index]);
        },
      ),
    );
  }
}

class PrivacyPolicyItem {
  final String question;
  final String answer;

  PrivacyPolicyItem({required this.question, required this.answer});
}

class PrivacyPolicyItemWidget extends StatefulWidget {
  final PrivacyPolicyItem privacyPolicyItem;

  const PrivacyPolicyItemWidget({super.key, required this.privacyPolicyItem});

  @override
  // ignore: library_private_types_in_public_api
  _PrivacyPolicyItemWidgetState createState() =>
      _PrivacyPolicyItemWidgetState();
}

class _PrivacyPolicyItemWidgetState extends State<PrivacyPolicyItemWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      margin: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        iconColor: Colors.white,
        title: Text(
          widget.privacyPolicyItem.question,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              widget.privacyPolicyItem.answer,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.white,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
