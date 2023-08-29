import 'package:flutter/material.dart';
import 'package:period_tracker/providers/story_provider.dart';
import 'package:period_tracker/ui/intro/intro_story.dart';

// import 'package:period_tracker/statistics/statistics_screen.dart';
import 'package:period_tracker/ui/profile/profile_screen.dart';
import 'package:period_tracker/ui/self_care/self_care_screen.dart';
import 'package:period_tracker/utils/constants.dart';
import 'package:period_tracker/widgets/calendar_controller.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'custom_calendar.dart';
import 'dates_provider.dart';
import 'providers/feeling_provider.dart';
import 'ui/calendar/calendar_screen.dart';

void main() {
  runApp(const MyApp());
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
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            brightness: Brightness.light,
            colorScheme: ColorScheme.fromSeed(seedColor: accentColor),
            useMaterial3: false,
            primarySwatch: primarySwatch),
        // home: const IntroStory(),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          /* dark theme settings */
        ),
        themeMode: ThemeMode.light,
        routes: {
          '/': (context) => const IntroStory(),
          home_screen: (context) => const HomeScreen(),
          profile_screen: (context) => ProfileScreen(),
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
        return Container(
          child: Center(
            child: Text('Coming Soon'),
          ),
        );
      // return StatisticsScreen();
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
