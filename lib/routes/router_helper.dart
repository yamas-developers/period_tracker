

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:period_tracker/intro/goals_screens.dart';
import 'package:period_tracker/intro/set_code.dart';
import 'package:period_tracker/main.dart';
import 'package:period_tracker/routes/route_constants.dart';

import '../intro/code_screens.dart';
import '../ui/intro/intro_story.dart';
import '../ui/profile/notifications/contraception_notification.dart';
import '../ui/profile/notifications/end_of_periods_notification.dart';
import '../ui/profile/notifications/late_notification.dart';
import '../ui/profile/notifications/notifications_screen.dart';
import '../ui/profile/notifications/ovolation_notification.dart';
import '../ui/profile/notifications/period_notification.dart';
import '../ui/profile/use_access_code.dart';
import '../ui/self_care/status_view.dart';
import '../widgets/showModalBottomSheet.dart';
import 'animate_route.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (BuildContext buildContext) {
        return const IntroStory(); //splash screen
      });
    case homeScreen:
      debugPrint(settings.name);
      return routeOne(
          settings: settings,
          widget: const HomeScreen(),
          routeName: homeScreen);
    case notificationScreen:
      debugPrint(settings.name);
      return routeOne(
          settings: settings,
          widget: const NotificationsScreen(),
          routeName: notificationScreen);
    case notificationPeriodScreen:
      debugPrint(settings.name);
      return routeOne(
          settings: settings,
          widget: const NotificationPeriodScreen(),
          routeName: notificationPeriodScreen);
    case notificationLateScreen:
      debugPrint(settings.name);
      return routeOne(
          settings: settings,
          widget: const NotificationLateScreen(),
          routeName: notificationLateScreen);
    case notificationEndOfPeriodsScreen:
      debugPrint(settings.name);
      return routeOne(
          settings: settings,
          widget: const NotificationEndOfPeriodsScreen(),
          routeName: notificationEndOfPeriodsScreen);
    case notificationOvulationScreen:
      debugPrint(settings.name);
      return routeOne(
          settings: settings,
          widget: const NotificationOvulationScreen(),
          routeName: notificationOvulationScreen);
    case notificationContraceptionScreen:
      debugPrint(settings.name);
      return routeOne(
          settings: settings,
          widget: const NotificationContraceptionScreen(),
          routeName: notificationContraceptionScreen);
    case showModalBottomSheetScreen:
      debugPrint(settings.name);
      return routeOne(
          settings: settings,
          widget: const ShowModalBottomSheet(),
          routeName: showModalBottomSheetScreen);
    case goalsScreen:
      debugPrint(settings.name);
      return routeOne(
          settings: settings,
          widget:  GoalsScreen(),
          routeName: goalsScreen);
    case useAccessCodeScreen:
      debugPrint(settings.name);
      return routeOne(
          settings: settings,
          widget:  UseAccessCodeScreen(),
          routeName: useAccessCodeScreen);
    case setCode:
      debugPrint(settings.name);
      return routeOne(
          settings: settings,
          widget:  SetCode(),
          routeName: setCode);
    case pinCodeScreen:
      debugPrint(settings.name);
      return routeOne(
          settings: settings,
          widget:  PinCodeScreen(),
          routeName: pinCodeScreen);

    default:
      debugPrint("default");
      return routeOne(
          settings: settings,
          widget: const IntroStory(), //login screen
          routeName: homeScreen);
  }
}
