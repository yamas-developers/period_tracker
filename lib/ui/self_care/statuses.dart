import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/status.dart';
import '../../providers/story_provider.dart';
import '../../utils/constants.dart';
import 'status_view.dart';

class Statuses extends StatelessWidget {
  const Statuses({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<StoryProvider>(builder: (context, storyPro, _) {
      return SizedBox(
        height: 90,
        child: ListView.builder(
          itemCount: storyPro.stories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return _buildStatusCard(context, storyPro.stories[index]);
          },
        ),
      );
    });
  }

  Widget _buildStatusCard(BuildContext context, Story story) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(context,
            MaterialPageRoute(builder: (context) => StatusView(story: story)));
        context.read<StoryProvider>().notifyListeners();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6),
        decoration: story.seen
            ? null
            : BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: ovulationDayColor, width: 2)),
        child: Container(
          height: 72,
          width: 72,
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
              color: accentColor,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(story.statuses.first.image ?? ''),
                fit: BoxFit.cover,
              )),
          // child: ClipRRect(
          //     borderRadius: BorderRadius.circular(100),
          //     child: Image.asset(
          //       story.statuses.first.image ?? '',
          //       fit: BoxFit.cover,
          //     )),
        ),
      ),
    );
  }
}

class RectangularStatuses extends StatelessWidget {
  const RectangularStatuses({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<StoryProvider>(builder: (context, storyPro, _) {
      return SizedBox(
        height: 166,
        child: ListView.builder(
          itemCount: storyPro.stories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: EdgeInsets.only(
                    left: index == 0 ? 14 : 0,
                    right: index == storyPro.stories.length - 1 ? 14 : 0),
                child: _buildStatusCard(context, storyPro.stories[index]));
          },
        ),
      );
    });
  }

  Widget _buildStatusCard(BuildContext context, Story story) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(context,
            MaterialPageRoute(builder: (context) => StatusView(story: story)));
        context.read<StoryProvider>().notifyListeners();
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 6,
        ),
        decoration: story.seen
            ? null
            : BoxDecoration(
                // shape: BoxShape.circle,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: ovulationDayColor, width: 2)),
        child: Container(
          // height: 142,
          width: 128,
          margin: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          decoration: BoxDecoration(
            color: accentColor,
            // shape: BoxShape.circle,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              story.statuses.first.image ?? '',
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
