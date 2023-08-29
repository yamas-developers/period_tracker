import 'package:flutter/material.dart';
import 'package:period_tracker/providers/story_provider.dart';
import 'package:period_tracker/utils/constants.dart';
import 'package:provider/provider.dart';

// import 'package:story_view/controller/story_controller.dart';
// import 'package:story_view/widgets/story_view.dart';

import '../../models/status.dart';
import '../../widgets/stories/story_view.dart';

class StatusView extends StatefulWidget {
  StatusView({Key? key, required this.story}) : super(key: key);
  Story story;

  @override
  _StatusViewState createState() => _StatusViewState();
}

class _StatusViewState extends State<StatusView> {
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initilizeStory();
    });
  }

  initilizeStory() {
    storyItems.clear();
    for (int i = 0; i < widget.story.statuses.length; i++) {
      // list.add(story!.stories[i]);
      if (widget.story.statuses[i].image != null) {
        storyItems.add(StoryItem.pageProviderImage(
          AssetImage(widget.story.statuses[i].image ?? ''),
          // controller: storyController,
          duration: const Duration(seconds: 3),
          caption: widget.story.statuses[i].description,
          // url: widget.statuses[i].image!
        ));
      } else {
        storyItems.add(StoryItem.text(
            title: widget.story.statuses[i].description!,
            backgroundColor: (widget.story.statuses[i].color)!));
      }
    }
    setState(() {});
  }

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
            : StoryView(
                storyItems: storyItems,
                onStoryShow: (s) {
                  print("Showing a story");
                },
                onComplete: () {
                  print("Completed a cycle");
                  int index = storyPro.stories
                      .indexWhere((element) => element.id == widget.story.id);
                  widget.story.seen = true;
                  storyPro.stories[index] = widget.story;
                  if (storyPro.stories.length > (index + 1)) {
                    widget.story = storyPro.stories[index + 1];
                    initilizeStory();
                  } else {
                    Navigator.pop(context);
                  }
                },
                progressPosition: ProgressPosition.top,
                repeat: true,
                controller: storyController,
              ),
      );
    });
  }
}

// List<StoryItem> sampleStory = [
//   StoryItem.text(
//     title: "I guess you'd love to see more of our food. That's great.",
//     backgroundColor: Colors.blue,
//   ),
//   StoryItem.text(
//     title: "Nice!\n\nTap to continue.",
//     backgroundColor: Colors.red,
//     textStyle: TextStyle(
//       fontFamily: 'Dancing',
//       fontSize: 40,
//     ),
//   ),
//   StoryItem.pageImage(
//     url:
//     "https://image.ibb.co/cU4WGx/Omotuo-Groundnut-Soup-braperucci-com-1.jpg",
//     caption: "Still sampling",
//     controller: storyController,
//   ),
//   StoryItem.pageImage(
//       url: "https://media.giphy.com/media/5GoVLqeAOo6PK/giphy.gif",
//       caption: "Working with gifs",
//       controller: storyController,),
//   StoryItem.pageImage(
//     url: "https://media.giphy.com/media/XcA8krYsrEAYXKf4UQ/giphy.gif",
//     caption: "Hello, from the other side",
//     controller: storyController,
//   ),
//   StoryItem.pageImage(
//     url: "https://media.giphy.com/media/XcA8krYsrEAYXKf4UQ/giphy.gif",
//     caption: "Hello, from the other side2",
//     controller: storyController,
//   ),
// ];
