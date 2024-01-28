import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:circle_bottom_navigation_bar/circle_bottom_navigation_bar.dart';
import 'package:circle_bottom_navigation_bar/widgets/tab_data.dart';
import 'package:get_it/get_it.dart';
import 'package:homescreen/api/chat_,manager.dart';
import 'package:homescreen/pages/CategoriesPage.dart';
import 'package:homescreen/pages/FavouritesProvider.dart';
import 'package:homescreen/pages/WelcomeScreen.dart';
import 'package:homescreen/pages/aboutUsPage.dart';
import 'package:homescreen/pages/bookmarkmodelnotifier.dart';
import 'package:homescreen/pages/home.dart';
import 'package:homescreen/pages/profile.dart';
import 'package:homescreen/pages/search_history_provider.dart';
import 'package:homescreen/pages/theme_provider.dart';
import 'package:homescreen/theme/theme_constants.dart';
import 'package:provider/provider.dart';

GetIt getIt = GetIt.instance;

Future<void> main() async {
  /*SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));*/
  // Set preferred orientations
  /*SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Portrait orientation only
  ]);*/
  getIt.registerSingleton<ChatManager>(ChatManager());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => SearchHistoryProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => BookmarkModel()),
      ],
      child: const MyApp(),
    ),
  );
}

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
      home: FlutterSplashScreen.fadeIn(
        animationDuration: Duration(milliseconds: 4500),
        //duration: Duration(seconds: 4),
        backgroundColor: Colors.white70,
        onInit: () {
          debugPrint("On Init");
        },
        onEnd: () {
          debugPrint("On End");
        },
        childWidget: SizedBox(
          height: 300,
          width: 300,
          child: Image.asset("assets/images/S1.png"),
        ),
        onAnimationEnd: () => debugPrint("On Fade In End"),
        defaultNextScreen: WelcomeScreen(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  static final GlobalKey<MyHomePageState> homePageKey =
      GlobalKey<MyHomePageState>();

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  static int currentPage = 2;

  final List<Widget> pages = [
    AboutUs(),
    Search(),
    HomeScreen(),
    Categories(),
    Profile(),
  ];

  int get getCurrentPage => currentPage;

  void goToPageTwo() {
    setState(() {
      currentPage = 2; // Index of Page Two in the bottom navigation bar
    });
  }

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
      body: pages[currentPage],
      bottomNavigationBar: CircleBottomNavigationBar(
        initialSelection: currentPage,
        barHeight: viewPadding.bottom > 0 ? barHeightWithNotch : barHeight,
        arcHeight: viewPadding.bottom > 0 ? arcHeightWithNotch : barHeight,
        itemTextOff: viewPadding.bottom > 0 ? 0 : 1.20,
        itemTextOn: viewPadding.bottom > 0 ? 0 : 1.35,
        barBackgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        circleOutline: 0.0,
        shadowAllowance: 7.0,
        circleSize: 55.0,
        blurShadowRadius: 1.0,
        hasElevationShadows: true,
        circleColor:
            Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        activeIconColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        inactiveIconColor:
            Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
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
