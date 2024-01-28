import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  final void Function()? onPressed;
  const MyTextBox({
    super.key,
    required this.text,
    required this.sectionName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 17),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor!,
            ),
            //color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.only(
          left: 15,
          bottom: 15,
        ),
        margin: const EdgeInsets.only(left: 20, bottom: 20, top: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sectionName,
                style: TextStyle(
                    fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
              ),
              IconButton(
                  onPressed: onPressed,
                  icon: Icon(
                    Icons.edit,
                    color: Theme.of(context)
                        .bottomNavigationBarTheme
                        .backgroundColor,
                  ))
            ],
          ),
          Text(
            text,
            style: TextStyle(fontFamily: 'Barlow', fontSize: 15),
          ),
        ]),
      ),
    );
  }
}
