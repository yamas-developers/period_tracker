import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:period_tracker/providers/user_data_provider.dart';
import 'package:period_tracker/routes/session_manager.dart';
import 'package:period_tracker/themes.dart';
import 'package:period_tracker/ui/statistics/statistics_screen.dart';

import 'routes/router_helper.dart' as router;
import 'package:flutter/material.dart';
import 'package:period_tracker/models/user_data.dart';
import 'package:period_tracker/providers/app_data_provider.dart';
import 'package:period_tracker/providers/story_provider.dart';
import 'package:period_tracker/ui/intro/intro_story.dart';

// import 'package:period_tracker/statistics/statistics_screen.dart';
import 'package:period_tracker/ui/profile/profile_screen.dart';
import 'package:period_tracker/ui/self_care/self_care_screen.dart';
import 'package:period_tracker/utils/constants.dart';
import 'package:period_tracker/widgets/calendar_controller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';
import 'custom_calendar.dart';
import 'dates_provider.dart';
import 'providers/feeling_provider.dart';
import 'ui/calendar/calendar_screen.dart';

// String? userData;
// String? calendarData;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

Future<void> checkAndSaveData(context) async{
  final userDataProvider=Provider.of<UserDataProvider>(context, listen: false);
  final appDataProvider=Provider.of<AppDataProvider>(context, listen: false);
  SessionManager _sessionManager=SessionManager();
  userDataProvider.checkIntroData=await _sessionManager.checkData("introScreensData");
  userDataProvider.checkCalendarData=await _sessionManager.checkData("CalendarData");
  appDataProvider.checkDarkTheme=await _sessionManager.checkBoolData("isDarkMode");
  if(appDataProvider.checkDarkTheme==false){
    appDataProvider.isDarkMode=appDataProvider.checkDarkTheme??false;
  }else if(appDataProvider.checkDarkTheme==true){
    appDataProvider.isDarkMode=appDataProvider.checkDarkTheme??false;
  }
  if(userDataProvider.checkIntroData==true){
   userDataProvider.introScreenData=await  _sessionManager.getData("introScreensData");
  }
  if(userDataProvider.checkCalendarData==true){
   userDataProvider.calendarData=await  _sessionManager.getData("CalendarData");
   print("calendarData${userDataProvider.calendarData}");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DatesProvider()),
        ChangeNotifierProvider(create: (_) => StoryProvider()),
        ChangeNotifierProvider(create: (_) => FeelingProvider()),
        ChangeNotifierProvider(create: (_) => AppDataProvider()),
        ChangeNotifierProvider(create: (_) => UserDataProvider()),
      ],
      child: Builder(
        builder: (context) {
          final appDataProvider=Provider.of<AppDataProvider>(context, listen: false);
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            checkAndSaveData(context);
            final datesProvider = Provider.of<DatesProvider>(context, listen: false);
            final userDataProvider = Provider.of<UserDataProvider>(context, listen: false);
            datesProvider.calendarData = userDataProvider.calendarData;
            appDataProvider.currentTheme=await appDataProvider.loadTheme();
          });
          return Consumer<UserDataProvider>(
            builder: (context, userDataProvider, child){
              print("dark mode${appDataProvider.isDarkMode}");
              return MaterialApp(
                title: 'Flutter Demo',
                debugShowCheckedModeBanner: false,
                home: userDataProvider.introScreenData != null ? HomeScreen() : IntroStory(),
                theme: ThemeData(
                  brightness: Brightness.light,
                  primaryColor: bgColor,
                  appBarTheme: AppBarTheme(
                    color:bgColor
                  ),
                 scaffoldBackgroundColor: bgColor
                ),
                darkTheme: ThemeData(
                  brightness: Brightness.dark,
                  fontFamily: "poppins",
                  useMaterial3: false,
                  scaffoldBackgroundColor: fontColor,
                  primarySwatch: primarySwatch,
                  primaryColor: bgColor
                ),
                // themeMode: appDataProvider.isDarkMode!=false ? ThemeMode.light : ThemeMode.dark,
                // themeMode: appDataProvider.currentTheme==false ? ThemeMode.light : ThemeMode.dark ,
                themeMode: appDataProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
                // themeMode: ThemeMode.dark,

                // theme: appDataProvider.isDarkMode
                //     ? ThemeData(brightness: Brightness.dark)
                //     : ThemeData(brightness: Brightness.light),
                // ThemeData(
                //     brightness: ThemeClass.light,
                //     fontFamily: "poppins",
                //     colorScheme: ColorScheme.fromSeed(seedColor: accentColor),
                //     useMaterial3: false,
                //     primarySwatch: primarySwatch),
                // darkTheme: ThemeClass.darkTheme,
                // themeMode: ThemeMode.system,
                onGenerateRoute: router.generateRoute,
              );
            },
          );
        },
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Track the selected index

  // Define the icons and labels for the navigation items
  final List<IconData> _icons = [
    Icons.calendar_today,
    Icons.favorite,
    Icons.insert_chart,
    Icons.face,
  ];

  final List<String> _labels = [
    'Calendar',
    'Self Care',
    'Statistics',
    'Profile',
  ];

  // List of navigation bar items
  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.calendar_month),
      label: 'Calendar',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Self Care',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.bar_chart),
      label: 'Statistics',
    ),
    BottomNavigationBarItem(
      icon: Image.asset('assets/icons/girl_icon.png'),
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScreen(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildScreen() {
    switch (_selectedIndex) {
      case 0:
        return CalendarScreen();
      case 1:
        return SelfCareScreen();
      case 2:
        return StatisticsScreen();
      case 3:
        return ProfileScreen();
      default:
        return Container();
    }
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: _icons
          .asMap()
          .map((index, icon) => MapEntry(
                index,
                BottomNavigationBarItem(
                  icon: Icon(icon),
                  label: _selectedIndex == index ? _labels[index] : '',
                ),
              ))
          .values
          .toList(),
      currentIndex: _selectedIndex,
      selectedItemColor: accentColor,
      unselectedItemColor: greyDisabledColor,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
