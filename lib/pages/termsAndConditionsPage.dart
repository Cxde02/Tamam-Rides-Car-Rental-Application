import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Terms and Conditions',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '1. Agreement',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'By using this car rental app, you agree to abide by the terms and conditions set forth in this agreement.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Barlow',
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '2. Rental Period',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'The rental period starts from the time of vehicle pickup and ends at the designated return time as specified on the app.',
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Barlow',
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '3. Vehicle Condition',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'You are responsible for returning the vehicle in the same condition as when you received it or penalties may apply, such as additional charges or even legal actions.',
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Barlow',
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '4. Payment and Fees',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Payment is required at the time of reservation and additional fees may apply for late returns.',
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Barlow',
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '5. Insurance Coverage',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'The rental includes insurance coverage for up 50 % for damages or accidents.',
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Barlow',
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '6. Age and License Requirements',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'You must be at least 18 years old and hold a valid driver\'s license for atleast 1 year.',
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Barlow',
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '7. Fuel Policy',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'You are responsible for refueling the vehicle before returning it as a full-to-full fuel policy is applied to all cars.',
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Barlow',
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '8. Prohibited Activities',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Smoking, drunken driving, off-road usage, and exceeding speed limits are strictly prohibited. Legal actions may apply.',
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Barlow',
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '9. Termination of Rental Agreement',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'We reserve the right to terminate the rental agreement if terms and conditions are violated.',
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Barlow',
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '10. Maintenance and Repairs',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'We are responsible for regular maintenance and repairs of the rental vehicles.',
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Barlow',
              ),
            ),
            SizedBox(height: 16.0),
            // Add more terms and conditions as needed
          ],
        ),
      ),
    );
  }
}
