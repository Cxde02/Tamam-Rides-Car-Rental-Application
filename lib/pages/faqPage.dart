// ignore: file_names
import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  final List<FAQItem> faqItems = [
    FAQItem(
      question: 'How do I make a reservation?',
      answer:
          'To make a reservation, navigate to the reservation page, select the car of your choice, and click on the add to cart option.',
    ),
    FAQItem(
      question: 'Can I modify or cancel my reservation?',
      answer: 'Yes, you can modify or cancel your reservation via phone call',
    ),
    FAQItem(
      question: 'What is the minimum age to rent a car?',
      answer: 'The minimum age requirement to rent a car is 18 years old',
    ),
    FAQItem(
      question: 'What types of payment are accepted?',
      answer:
          'We accept major credit cards such as Visa, MasterCard, and even through MCB Juice.',
    ),
    FAQItem(
      question: 'Is insurance included in the rental price?',
      answer: 'Yes, insurance coverage is included in the rental price.',
    ),
    FAQItem(
      question: 'Do I need an international driving license?',
      answer:
          'An international driving license is required only for foreigners',
    ),
    FAQItem(
        question: 'What is the fuel policy?',
        answer:
            'Our fuel policy is full-to-full fuel policy, which states that the car should be dropped off with the same amount of fuel that it had when picked up'),
    FAQItem(
      question: 'Are there any mileage restrictions?',
      answer: 'There are no mileage restrictions.',
    ),
    FAQItem(
      question: 'What happens if the car breaks down?',
      answer:
          'In case of a breakdown, please contact us on the help and support page, we will do the necessary and 50% of the reservation fee will be refunded. Actions taken independently will not be accounted for a refund',
    ),
    FAQItem(
      question: 'Is there a late return fee?',
      answer:
          'A late return fee may apply if no official permissions were given in case of late returns. Please contact us in case of late returns for more details',
    ),
    FAQItem(
      question: 'Can I pick up the car from a different location?',
      answer:
          'Yes, we offer the option of picking up the car from a different location, additional fees may be charged',
    ),
    FAQItem(
      question: 'Are child seats available for rent?',
      answer: 'Yes, we provide child seats for rent at no additional prices',
    ),
    FAQItem(
      question: 'What documents do I need to provide for renting a car?',
      answer:
          'You need to provide a valid driver\'s license held atleast for a year, and your identity card',
    ),
    FAQItem(
      question: 'Is roadside assistance included?',
      answer: 'Yes, roadside assistance is included',
    ),
    FAQItem(
      question: 'Can I add an additional driver?',
      answer:
          'Yes, you can add an additional driver by contacting us via phone call',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FAQs',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      ),
      body: ListView.builder(
        itemCount: faqItems.length,
        itemBuilder: (context, index) {
          return FAQItemWidget(faqItem: faqItems[index]);
        },
      ),
    );
  }
}

class FAQItem {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});
}

class FAQItemWidget extends StatefulWidget {
  final FAQItem faqItem;

  const FAQItemWidget({super.key, required this.faqItem});

  @override
  // ignore: library_private_types_in_public_api
  _FAQItemWidgetState createState() => _FAQItemWidgetState();
}

class _FAQItemWidgetState extends State<FAQItemWidget> {
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
          widget.faqItem.question,
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
              widget.faqItem.answer,
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
