import 'dart:math';
import 'package:homescreen/api/chat_,manager.dart';

class Dashbot {
  List<String> responses = [
    'Could you be more specific about the question? Or you can find more help on the help and support page' /*Insert help and support page link*/,
    'I did not understand the question!, you can find additional help on the help and support page' /*Insert contact us link*/,
    'Sorry, I did not get that!, you may find your answers on the FAQs page if it relates to the use of the app' /*Insert help and support page link*/,
  ];

  Message getResponseMessage(Message input) {
    if (input.message.contains(
        RegExp(r'\bHello\b|\bHi\b|\bSup\b|\bYo\b', caseSensitive: false))) {
      return Message(
        sender: 'Dash',
        message: 'Hello, ${input.sender}! Nice to meet you!',
      );
    } else if (input.message.contains(RegExp(
        r'\bblind\b|\bhandicapped\b|\bdisabled\b|\bdeaf\b',
        caseSensitive: false))) {
      return Message(
        sender: 'Dash',
        message:
            'Kindly note that we provide drivers for handicapped people. If you have any more queries, please contact us.',
      );
    } else if (input.message.contains(RegExp(
        r'\btype\b|\bbrand\b|\bmodel\b|\bcars\b|\bmodels\b|\boffer\b|\bbrands\b|\boffers\b|\bvehicles\b',
        caseSensitive: false))) {
      return Message(
        sender: 'Dash',
        message: 'Sure, here are some of the car brands we offer:\n'
            'Toyota\n'
            'Honda\n'
            'Nissan\n'
            'Suzuki\n'
            'Mitsubishi\n'
            'BMW\n'
            'Mazda\n'
            'Kia\n'
            'Hyundai\n'
            'Peugeot\n'
            'Mercedes\n'
            'Volkswagen\n'
            'Porsche\n'
            'Mini Cooper\n'
            'Audi',
      );
    } else if (input.message
        .contains(RegExp(r'\bquestion\b', caseSensitive: false))) {
      return Message(
        sender: 'Dash',
        message: 'If you have any questions, you can check the FAQs page.',
      );
    } else if (input.message
        .contains(RegExp(r'\bhelp\b', caseSensitive: false))) {
      return Message(
        sender: 'Dash',
        message: 'Hello, ${input.sender}! How can I assist you today?',
      );
    } else if (input.message.contains(RegExp(
        r'\bprice\b|\bcost\b|\bprices\b|\bcosts\b',
        caseSensitive: false))) {
      return Message(
        sender: 'Dash',
        message:
            'Sure, our rental prices vary depending on the car model and duration. You can find detailed pricing information on each vehicle\'s page.',
      );
    } else if (input.message.contains(RegExp(
        r'\breservation\b|\bbook\b|\bavailability\b',
        caseSensitive: false))) {
      return Message(
        sender: 'Dash',
        message:
            'To make a reservation, simply choose your desired car, color, and dates. Our system will guide you through the process.',
      );
    } else if (input.message.contains(
        RegExp(r'\bfeatures\b|\bservices\b|\boptions\b|\boption\b|\bservice\b', caseSensitive: false))) {
      return Message(
        sender: 'Dash',
        message:
            'We offer a range of services including GPS navigation, child seats, and roadside assistance. You can explore the available features during the reservation process.',
      );
    } else if (input.message.contains(RegExp(r'\brent\b|\bsteps\b|\bsteps\b', caseSensitive: false))) {
      return Message(
        sender: 'Dash',
        message:
            'To rent a car, you can go through the procedures through the app itself. For any queries, see the help page..',
      );
    } else if (input.message.contains(RegExp(r'\bpayment\b|\bmethod\b|\bpay\b', caseSensitive: false))) {
      return Message(
        sender: 'Dash',
        message:
            'We accept various payment methods, including credit/debit cards and online payment platforms. You can choose your preferred payment option while making the reservation.',
      );
    } else if (input.message.contains(RegExp(r'\bcancellation\b|\bcancel\b', caseSensitive: false))) {
      return Message(
        sender: 'Dash',
        message:
            'If you need to cancel a reservation, You will have to call the owners or send an email',
      );
    } else if (input.message.contains(RegExp(r'\bmodify\b|\bchange\b', caseSensitive: false))) {
      return Message(
        sender: 'Dash',
        message:
            'You can modify your reservation details such as pick-up/drop-off location, date, and time by call or by email',
      );
    } else if (input.message.contains(RegExp(r'\breturn\b|\breturn car\b', caseSensitive: false))) {
      return Message(
        sender: 'Dash',
        message:
            'To return the car, simply park it at the designated drop-off location and follow the return instructions provided during the rental.',
      );
    } else if (input.message.contains(RegExp(r'\brent for someone else\b', caseSensitive: false))) {
      return Message(
        sender: 'Dash',
        message:
            'Yes, you can rent a car for someone else. You\'ll need to provide their details and ensure they meet the rental requirements.',
      );
    } else if (input.message.contains(RegExp(r'\brequirements\b|\bdocuments\b', caseSensitive: false))) {
      return Message(
        sender: 'Dash',
        message:
            'To rent a car, you typically need a valid driver\'s license, credit/debit card, and proof of identification. Specific requirements may vary based on your location.',
      );
    } else if (input.message.contains(RegExp(r'\baccount\b|\bedit\b|\bprofile\b', caseSensitive: false))) {
      return Message(
        sender: 'Dash',
        message: 'To edit an account, enter the edit profile section.',
      );
    } else if (input.message.contains(RegExp(r'\bduration\b|\brental duration\b', caseSensitive: false))) {
      return Message(
        sender: 'Dash',
        message:
            'Our rental durations vary from daily, weekly to monthly options. You can choose the duration that suits your needs.',
      );
    } else if (input.message.contains(RegExp(r'\bextend\b|\bextend rental\b', caseSensitive: false))) {
      return Message(
        sender: 'Dash',
        message:
            'Yes, you can extend your rental period. Please contact our support team (+23059220603) to assist you with the extension process.',
      );
    } else if (input.message.contains(RegExp(r'\bage restrictions\b|\bage limit\b', caseSensitive: false))) {
      return Message(
        sender: 'Dash',
        message:
            'Yes, there are age restrictions for renting a car. You need to be at least 18 years old to rent a car with us.',
      );
    } else if (input.message.contains(RegExp(r'\bvehicle problems\b|\bvehicle issues\b', caseSensitive: false))) {
      return Message(
        sender: 'Dash',
        message:
            'If you encounter any problems with the vehicle during the rental, please contact our roadside assistance team at +23059220603 or +2304385962.',
      );
    } else if (input.message.contains(RegExp(r'\brent specific car\b|\bmodel not listed\b', caseSensitive: false))) {
      return Message(
        sender: 'Dash',
        message:
            'If a specific car model is not listed on our app, then it means that we do have the model YET and we are trying to accomodate more models to ensure a smooth experience for our clients.',
      );
    } else if (input.message.contains(RegExp(r'\bcheck car availability\b|\bdesired dates\b', caseSensitive: false))) {
      return Message(
        sender: 'Dash',
        message:
            'You can rent any vehicle anytime you want. Just pick a date and we provide!.',
      );
    } else if (input.message.contains(RegExp(r'\blate return\b|\breturn car late\b', caseSensitive: false))) {
      return Message(
        sender: 'Dash',
        message:
            'Returning the car late may result in additional charges. It\'s important to adhere to the agreed-upon return time to avoid any inconvenience and extra fees.',
      );
    } else if (input.message.contains(RegExp(r'\bpick up and return\b|\bdifferent locations\b', caseSensitive: false))) {
      return Message(
        sender: 'Dash',
        message:
            'Yes, you can pick up the rental car from one location and return it to another. However, additional fees may apply. Please let us know your preferred pick-up and drop-off locations during the reservation process.',
      );
    } else if (input.message.contains(RegExp(r'\bpets in rental\b|\bpet-friendly\b|\bpets allowed\b', caseSensitive: false))) {
      return Message(
        sender: 'Dash',
        message:
            'Pets are generally not allowed in our rental vehicles to ensure the comfort and cleanliness for all customers. We appreciate your understanding.',
      );
    } else if (input.message.contains(RegExp(r'\bdamages or issues\b|\breport before rental\b', caseSensitive: false))) {
      return Message(
        sender: 'Dash',
        message:
            'Before starting the rental, carefully inspect the vehicle for any existing damages or issues. If you notice anything, please report it to our staff or take photos as evidence. This will help prevent any misunderstandings.',
      );
    } else if (input.message.contains(RegExp(r'\blost keys\b|\bkeys to rental\b|\blost\b|\bkey\b|\bkeys\b', caseSensitive: false))) {
      return Message(
        sender: 'Dash',
        message:
            'If you lose the keys to the rental car, please contact our fixed line immediately. Depending on the situation, our team will provide guidance on key replacement and any associated costs.',
      );
    }

    return Message(
      sender: 'Dash',
      message: responses[Random().nextInt(responses.length)],
    );
  }

  Message getFirstMessage() {
    return Message(
      sender: 'Dash',
      message: 'Hello, how can I assist you today?',
    );
  }
}
