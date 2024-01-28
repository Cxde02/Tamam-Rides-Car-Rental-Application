import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:circle_bottom_navigation_bar/circle_bottom_navigation_bar.dart';
import 'package:circle_bottom_navigation_bar/widgets/tab_data.dart';
import 'package:homescreen/pages/CategoriesPage.dart';
import 'package:homescreen/pages/aboutUsPage.dart';
import 'package:homescreen/pages/book_page.dart';
import 'package:homescreen/pages/books.dart';
import 'package:homescreen/pages/home.dart';
import 'package:homescreen/pages/profile.dart';
import 'package:homescreen/pages/recentlysearched.dart';
import 'package:homescreen/pages/search_history_provider.dart';
import 'package:homescreen/pages/theme_provider.dart';
import 'package:homescreen/theme/theme_constants.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: Provider.of<ThemeProvider>(context).themeMode,
      /*theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),*/
      //theme: ThemeData(fontFamily: 'Roboto'),
      home: const MyHomePage1(),
    );
  }
}

class MyHomePage1 extends StatefulWidget {
  const MyHomePage1({super.key});

  @override
  _MyHomePageState1 createState() => _MyHomePageState1();
}

class _MyHomePageState1 extends State<MyHomePage1> {
  int currentPage = 1;
  final List<Widget> _pages = [
    AboutUs(),
    Search(),
    HomeScreen(),
    Categories(),
    Profile(),
  ];

  @override
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewPadding = MediaQuery.of(context).viewPadding;
    double barHeight;
    double barHeightWithNotch = 65;
    double arcHeightWithNotch = 65;

    if (size.height > 700) {
      barHeight = 57;
    } else {
      barHeight = size.height * 0.1;
    }

    if (viewPadding.bottom > 0) {
      barHeightWithNotch = (size.height * 0.07) + viewPadding.bottom;
      arcHeightWithNotch = (size.height * 0.075) + viewPadding.bottom;
    }

    return Scaffold(
      /* appBar: AppBar(
        title: const Center(
          child: Text(
            'Circle Bottom Navigation Bar Example',
          ),
        ),
      ),*/
      body: _pages[currentPage],
      bottomNavigationBar: CircleBottomNavigationBar(
        initialSelection: currentPage,
        barHeight: viewPadding.bottom > 0 ? barHeightWithNotch : barHeight,
        arcHeight: viewPadding.bottom > 0 ? arcHeightWithNotch : barHeight,
        itemTextOff: viewPadding.bottom > 0 ? 0 : 1.20,
        itemTextOn: viewPadding.bottom > 0 ? 0 : 1.35,
        //barBackgroundColor: const Color(0xFF002346),
        //barBackgroundColor: darkTheme.bottomNavigationBarTheme.backgroundColor,
        barBackgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        circleOutline: 0.0,
        shadowAllowance: 7.0,
        circleSize: 55.0,
        blurShadowRadius: 1.0,
        hasElevationShadows: true,

        //circleColor: const Color(0xFF2E8970),
        circleColor:
            Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        activeIconColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        inactiveIconColor:
            Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        //textColor: const Color(0xFF76E595),
        textColor: Colors.white,
        arcWidth: 79.0,
        tabs: getTabsData(),
        onTabChangedListener: (index) => setState(() => currentPage = index),
      ),
    );
  }
}

List<TabData> getTabsData() {
  return [
    TabData(
      icon: CupertinoIcons.info,
      iconSize: 23,
      title: 'About us',
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
    TabData(
      icon: CupertinoIcons.search,
      iconSize: 23,
      title: 'Search',
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
    TabData(
      icon: CupertinoIcons.home,
      iconSize: 23.0,
      title: 'Home',
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
    TabData(
      icon: CupertinoIcons.car_detailed,
      iconSize: 23,
      title: 'Categories',
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
    TabData(
      icon: CupertinoIcons.person,
      iconSize: 23,
      title: 'Profile',
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
  ];
}

/*class Aboutus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: const Center(
          child: Text(
            'About Us',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}*/

class Search extends StatefulWidget {
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _searchController = TextEditingController();

  final stt.SpeechToText speech = stt.SpeechToText();
  final TextEditingController textController = TextEditingController();

  DateTime?
      currentBackPressTime; // Track the time of the last back button press

  bool isTapped = false;
  bool isTyping = false;

  void _onTextChanged() {
    setState(() {
      isTyping = textController.text.isNotEmpty;
    });
  }

  String searchQuery = '';

  void navigateToSearchHistoryPage() async {
    final selectedQuery = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchHistoryPage(),
      ),
    );
    if (selectedQuery != null) {
      _searchController.text = selectedQuery;
      searchBook(selectedQuery);
    }
  }

  void initSpeechToText() async {
    bool isAvailable = await speech.initialize();
    if (isAvailable) {
      speech.listen(
        onResult: (SpeechRecognitionResult result) {
          setState(() {
            textController.text = result.recognizedWords;
          });
          if (result.finalResult) {
            searchBook(textController.text);
          }
        },
      );
    } else {
      print('The user has denied speech recognition permissions.');
    }
  }

  void handleTap() {
    setState(() {
      isTapped = !isTapped;
    });
  }

  List<Book> books = allBooks;
  List<String> searchHistory = [];

  void addToSearchHistory(String query) {
    if (!searchHistory.contains(query)) {
      setState(() {
        searchHistory.add(query);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Check if currentBackPressTime is null or the difference between current time and last back press time is more than 2 seconds (2000 milliseconds).
        if (currentBackPressTime == null ||
            DateTime.now().difference(currentBackPressTime!) >
                Duration(milliseconds: 2000)) {
          // Show a snackbar to notify the user to tap twice to exit
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            content: Center(
              child: Text(
                'Tap again to exit',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            duration: Duration(seconds: 2),
          ));

          // Update the currentBackPressTime to the current time
          currentBackPressTime = DateTime.now();

          // Prevent the app from closing on the first back button press
          return false;
        }
        // Allow the app to close when tapped twice within the time window
        return true;
      },
      child: Scaffold(
        body: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 60, 0, 0),
                child: Text(
                  'Rev Up Your Search',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
            /*FloatingActionButton(
              splashColor: Colors.greenAccent,
              focusElevation: 15,
              elevation: 5,
              highlightElevation: 20,
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              onPressed: () {
                navigateToSearchHistoryPage();
              },
              child: Icon(Icons.mic),
            ),*/
            Container(
              margin: const EdgeInsets.fromLTRB(15, 20, 16, 24),
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: TextField(
                  controller: textController,
                  autofocus: true,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search by Model, Year, CC, Color...',
                    hintStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Theme.of(context)
                            .bottomNavigationBarTheme
                            .backgroundColor,
                        fontWeight: FontWeight.w100),
                    suffixIcon: InkWell(
                      onTap: () => initSpeechToText(),
                      child: Icon(
                        Icons.mic,
                        size: 28,
                      ),
                    ),
                    suffixIconColor: Theme.of(context)
                        .bottomNavigationBarTheme
                        .backgroundColor,
                  ),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    color: Color(0xFF0A486D),
                  ),
                  onChanged: searchBook,
                  onSubmitted: myCallback,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemExtent: 110,
                padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];

                  return Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Theme.of(context)
                            .bottomNavigationBarTheme
                            .backgroundColor!
                            .withOpacity(0.8),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.only(top: 5),
                    margin: EdgeInsets.only(
                      top: 3.5,
                      bottom: 20,
                      left: 7,
                      right: 7,
                    ),
                    child: ListTile(
                      subtitle: Text(
                        "Year: " +
                            book.date +
                            " " +
                            "\t" +
                            "\t"
                                "CC: " +
                            book.cc,
                        style: TextStyle(
                            fontSize: 10,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1),
                      ),
                      trailing: Icon(
                        Icons.arrow_circle_right,
                        color: Theme.of(context)
                            .bottomNavigationBarTheme
                            .backgroundColor,
                      ),
                      splashColor: Colors.greenAccent,
                      textColor: Theme.of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor,
                      leading: Image.asset(
                        book.imageUrl,
                        fit: BoxFit.fitWidth,
                        width: 102,
                        height: 100,
                      ),
                      title: Text(
                        book.name + ' ' + book.model,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookPage(
                            book: book,
                            cars: [],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void searchBook(String query) {
    final suggestions = allBooks.where(
      (book) {
        final bookTitle = book.name.toLowerCase() +
            " " +
            book.model.toLowerCase() +
            book.cc +
            book.color.toLowerCase() +
            book.date;
        final input = query.toLowerCase();

        return bookTitle.contains(input);
      },
    ).toList();
    setState(() => books = suggestions);
  }

  void myCallback(String query) {
    searchBook(query);
    Provider.of<SearchHistoryProvider>(context, listen: false)
        .addToSearchHistory(query);
  }
}










/*class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: const Center(
          child: Text(
            'Profile ',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}*/

/*class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: const Center(
          child: Text(
            'Categories ',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}*/
