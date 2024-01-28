import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:homescreen/api/chat_,manager.dart';
import 'package:homescreen/ui/bubbles.dart';
import 'dart:async';
import 'dart:math';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

GetIt getIt = GetIt.instance;

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final ScrollController scrollController = ScrollController();
  final TextEditingController controller = TextEditingController();

  final speech = SpeechToText();
  final TextEditingController textController = TextEditingController();

  List<Message> messages = getIt<ChatManager>().messages;

  bool _isFirstOpen = true;

  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 50),
      curve: Curves.easeInOut,
    );
  }

  void initSpeechToText() async {
    bool isAvailable = await speech.initialize();
    if (isAvailable) {
      speech.listen(
        onResult: (SpeechRecognitionResult result) {
          setState(() {
            controller.text = result.recognizedWords;
          });

          // Check if the recognition is complete (finalized)
          if (result.finalResult) {
            // Automatically send the message
            onSend();
          }
        },
      );

      // Show a Snackbar when microphone is enabled
      _showMicStatusSnackBar("Microphone is enabled");
    } else {
      print('The user has denied speech recognition permissions.');

      // Show a Snackbar when microphone is disabled
      _showMicStatusSnackBar("Microphone is disabled");
    }
  }

  void getMessages() {
    setState(() {
      messages = getIt<ChatManager>().messages;
    });
  }

  void onSend() {
    String inputText = controller.text.trim();
    if (inputText != '') {
      Message inputMessage = Message(sender: 'Sir', message: inputText);

      getIt<ChatManager>().newMessage(inputMessage);

      controller.clear();

      getMessages();

      Duration fakeNetworkDelay =
          Duration(milliseconds: (Random().nextInt(26) * 100) + 500);

      Timer(fakeNetworkDelay, () {
        getIt<ChatManager>().getResponse(inputMessage);
        getMessages();
      });
    }
  }

  @override
  void initState() {
    super.initState();

    if (_isFirstOpen) {
      // Get and add first message
      Message firstMessage = dash.getFirstMessage(); // Use the correct method
      getIt<ChatManager>().newMessage(firstMessage);

      getMessages();

      // Mark as not first open
      _isFirstOpen = false;
    }
  }

  @override
  void dispose() {
    _isFirstOpen = false;
    // Clear the messages list when leaving the page
    getIt<ChatManager>().clearMessages();

    super.dispose();
  }

  // Helper method to show a Snackbar
  void _showMicStatusSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: EdgeInsets.only(top: 4, bottom: 4),
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        content: Text(
          message,
          style: TextStyle(fontFamily: 'Barlow'),
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 25, 0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: size.width * 0.1,
                      width: size.width * 0.1,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
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
                      )),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Chat',
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 22),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  String message = messages[index].message;

                  return messages[index].sender == 'Dash'
                      ? DashBubble(message: message)
                      : UserBubble(
                          message: message, userImage: 'assets/images/S2.png');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
              child: Material(
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    cursorColor: Theme.of(context)
                        .bottomNavigationBarTheme
                        .backgroundColor,
                    controller: controller,
                    decoration: InputDecoration(
                      prefixIcon: GestureDetector(
                        onTap: () => initSpeechToText(),
                        child: Icon(
                          CupertinoIcons.mic,
                          color: Theme.of(context)
                              .bottomNavigationBarTheme
                              .backgroundColor,
                        ),
                      ),
                      filled: true,
                      fillColor: Theme.of(context).scaffoldBackgroundColor,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                            color: Theme.of(context)
                                .bottomNavigationBarTheme
                                .backgroundColor!),
                      ),
                      hoverColor: Theme.of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor,
                      focusColor: Theme.of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context)
                                .bottomNavigationBarTheme
                                .backgroundColor!),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      hintText: 'Start typing...',
                      hintStyle: TextStyle(
                        fontFamily: 'Barlow',
                        color: Theme.of(context)
                            .bottomNavigationBarTheme
                            .backgroundColor,
                        letterSpacing: 0.7,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: onSend,
                        child: Icon(
                          Icons.send,
                          color: Theme.of(context)
                              .bottomNavigationBarTheme
                              .backgroundColor!,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
