import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:period_tracker/intro/goals_screens.dart';
import 'package:period_tracker/intro/last_period_screen.dart';
import 'package:period_tracker/providers/story_provider.dart';
import 'package:period_tracker/utils/public_methods.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/status.dart';
import '../../utils/constants.dart';
import '../../widgets/stories/story_view.dart';

class IntroStory extends StatefulWidget {
  const IntroStory({Key? key}) : super(key: key);

  @override
  State<IntroStory> createState() => _IntroStoryState();
}

class _IntroStoryState extends State<IntroStory> {
  final storyController = StoryController();
  List<StoryItem> storyItems = <StoryItem>[];

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      initializeStory(context.read<StoryProvider>().introStory);
    });
  }

  initializeStory(Story story) {
    storyItems.clear();
    for (int i = 0; i < story.statuses.length; i++) {
      // list.add(story!.stories[i]);
      if (story.statuses[i].image != null) {
        storyItems.add(StoryItem.pageProviderImage(
            AssetImage(story.statuses[i].image ?? ''),
            // controller: storyController,
            duration: const Duration(seconds: 3),
            caption: story.statuses[i].description,
            captionStyle: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            captionPositionFromBottom: 45
            // url: widget.statuses[i].image!
            ));
      } else {
        storyItems.add(StoryItem.text(
            title: story.statuses[i].description!,
            backgroundColor: (story.statuses[i].color)!));
      }
    }
    setState(() {});
  }

  bool shownLast = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<StoryProvider>(builder: (context, storyPro, _) {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: accentColor,
        ),
        body: storyItems.isEmpty
            ? CircularProgressIndicator()
            : Stack(
                children: [
                  StoryView(
                    storyItems: storyItems,
                    onStoryShow: (s) {
                      shownLast = shownLast || storyItems.last == s;
                    },
                    onComplete: () {
                      print("Completed a cycle");
                    },
                    progressPosition: ProgressPosition.top,
                    repeat: true,
                    controller: storyController,
                    showTopCancelButton: false,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    // alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 18.0,
                            left: 18,
                            right: 18,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              if (!shownLast) {
                                storyController.next();
                              } else {
                                log('MK: go to next screen');
                                // Navigator.pushReplacementNamed(context, home_screen);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GoalsScreen()));
                              }
                            },
                            child: Container(
                                width: getWidth(context) * 0.9,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: accentColor,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  'Next',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
      );
    });
  }
}
