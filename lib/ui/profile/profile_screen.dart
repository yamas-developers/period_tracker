import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:period_tracker/providers/app_data_provider.dart';
import 'package:period_tracker/providers/story_provider.dart';
import 'package:period_tracker/routes/session_manager.dart';
import 'package:period_tracker/ui/profile/birth.dart';
import 'package:period_tracker/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cycle.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool metricSystem = false;
  int currentTheme = 0;
  List<Map> themeColors = [
    {
      "image": "assets/icons/light_theme.png",
    },
    {
      "image": "assets/icons/dark_theme.png",
    },
  ];
  String? theme;
  bool isDarkMode=false;
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      await getCurrentTheme();
      setState(() {
      });
    });
  }

  Future<int> getCurrentTheme()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isDarkMode=await prefs.getBool("isLightMode");
    print("MA: profileScreen=>isDarkModel$isDarkMode");
    currentTheme=isDarkMode==true?1:0;
    print("MA: profileScreen=>currentTheme$currentTheme");
    return currentTheme;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: Consumer<AppDataProvider>(
        builder: (context, appDataProvider, child) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18, 18, 0),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Profile',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                    ),
                    SizedBox(height: 14),
                    ListTile(
                      leading: Icon(
                        Icons.palette_outlined,
                        color: accentColor,
                      ),
                      title: Text('Select Theme'),
                    ),
                    SizedBox(height: 8),
                    Container(
                      height: 160,
                      margin: EdgeInsets.only(left: 50),
                      child: Row(
                        children: [
                          ...List.generate(themeColors.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                //lightMode
                                if (index == 0 && !appDataProvider.isDarkMode) {
                                  setState(() {
                                    currentTheme = index;
                                    print("lightMode${!appDataProvider.isDarkMode}");
                                    appDataProvider.toggleTheme();
                                  });
                                  //darkMode
                                } else if (index == 1 && appDataProvider.isDarkMode) {
                                  setState(() {
                                    currentTheme = index;
                                    print("darkMode${appDataProvider.isDarkMode}");
                                    appDataProvider.toggleTheme();
                                  });
                                }
                              },
                              child: ThemeWidget(
                                imagePath: '${themeColors[index]["image"]}',
                                isSelected:
                                currentTheme == index? true : false,
                              ),
                            );
                          })
                          // ThemeWidget(
                          //   imagePath: 'assets/icons/dark_theme.png',
                          //   isSelected: true,
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    ListTile(
                        leading: Icon(
                          Icons.adjust_rounded,
                          color: accentColor,
                        ),
                        title: Text('Goal'),
                        subtitle: Text(
                          'Keep track of your cycle',
                          // style: TextStyle(color: fontColor)
                        )),
                    SizedBox(height: 8),
                    ListTile(
                      leading: Icon(
                        Icons.cyclone,
                        color: accentColor,
                      ),
                      title: Text('Cycle'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CycleInputScreen()));
                      },
                    ),
                    SizedBox(height: 8),
                    ListTile(
                      leading: Icon(
                        Icons.adjust_rounded,
                        color: accentColor,
                      ),
                      title: Text('Year of Birth'),
                      subtitle: Text(
                        '2000',
                        // style: TextStyle(color: fontColor)
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BirthInputScreen()));
                      },
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "notificationScreen");
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.notifications_outlined,
                          color: accentColor,
                        ),
                        title: Text('Notiifications'),
                      ),
                    ),
                    SizedBox(height: 8),
                    ListTile(
                      leading: Icon(
                        Icons.face,
                        color: accentColor,
                      ),
                      title: Text('Use access code'),
                    ),
                    SizedBox(height: 8),
                    ListTile(
                      leading: Icon(
                        Icons.monitor_weight_outlined,
                        color: accentColor,
                      ),
                      title: Text('Metric system'),
                      trailing: Switch(
                        value: metricSystem,
                        onChanged: (bool value) {
                          setState(() {
                            metricSystem = !metricSystem;
                          });
                        },
                        activeColor: accentColor,
                      ),
                    ),
                    SizedBox(height: 8),
                    ListTile(
                      leading: Icon(
                        Icons.star_border,
                        color: accentColor,
                      ),
                      title: Text('Rate the app'),
                    ),
                    SizedBox(height: 8),
                    ListTile(
                      leading: Icon(
                        Icons.feedback_outlined,
                        color: accentColor,
                      ),
                      title: Text('Feedback'),
                    ),
                    SizedBox(height: 8),
                    ListTile(
                      leading: Icon(
                        Icons.sticky_note_2_sharp,
                        color: accentColor,
                      ),
                      title: Text('Terms of Use'),
                    ),
                    SizedBox(height: 8),
                    ListTile(
                      leading: Icon(
                        Icons.privacy_tip_outlined,
                        color: accentColor,
                      ),
                      title: Text('Privacy Policy'),
                    ),
                    SizedBox(height: 8),
                    Consumer<StoryProvider>(builder: (context, pro3, _) {
                      return ListTile(
                        onTap: () {
                          StoryProvider pro =
                              Provider.of<StoryProvider>(context);
                          ///////update receiveing
                          StoryProvider pro2 = context.read<StoryProvider>();

                          Navigator.pop(context);

                          Navigator.of(context).pop();

                          log('My name is ${pro.name}');

                          pro.name = 'Shuja';

                          log('My name is ${pro.name}');
                        },
                        leading: Icon(
                          Icons.subscriptions_outlined,
                          color: accentColor,
                        ),
                        title: Text('Subscription on Google Play'),
                      );
                    }),
                  ]),
            ),
          );
        },
      ),
    );
  }
}

class ThemeWidget extends StatelessWidget {
  const ThemeWidget(
      {super.key, required this.imagePath, this.isSelected = false});

  final String imagePath;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 140,
      // width: 40,
      margin: EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 4,
                spreadRadius: 4)
          ]),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(
              '$imagePath',
              height: 160,
              width: 120,
              fit: BoxFit.fitHeight,
            ),
          ),
          if (isSelected)
            Positioned(
              right: 4,
              bottom: 4,
              child: Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
            )
        ],
      ),
    );
  }
}
