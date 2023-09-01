import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

import '../../utils/constants.dart';
import '../../widgets/custom_app_button.dart';

// class StatisticsScreen extends StatelessWidget {
//   final StoryController controller = StoryController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Delicious Ghanaian Meals"),
//       ),
//       body: Container(
//         margin: EdgeInsets.all(
//           8,
//         ),
//         child: ListView(
//           children: <Widget>[
//             Container(
//               height: 300,
//               child: StoryView(
//                 controller: controller,
//                 storyItems: [
//                   StoryItem.text(
//                     title:
//                         "Hello world!\nHave a look at some great Ghanaian delicacies. I'm sorry if your mouth waters. \n\nTap!",
//                     backgroundColor: Colors.orange,
//                     roundedTop: true,
//                   ),
//                   StoryItem.inlineImage(
//                     url: "https://image.ibb.co/gCZFbx/Banku-and-tilapia.jpg",
//                     controller: controller,
//                     caption: Text(
//                       "Banku & Tilapia. The food to keep you charged whole day.\n#1 Local food.",
//                       style: TextStyle(
//                         color: Colors.white,
//                         backgroundColor: Colors.black54,
//                         fontSize: 17,
//                       ),
//                     ),
//                   ),
//                   StoryItem.inlineImage(
//                     url:
//                         "https://image.ibb.co/cU4WGx/Omotuo-Groundnut-Soup-braperucci-com-1.jpg",
//                     controller: controller,
//                     caption: Text(
//                       "Omotuo & Nkatekwan; You will love this meal if taken as supper.",
//                       style: TextStyle(
//                         color: Colors.white,
//                         backgroundColor: Colors.black54,
//                         fontSize: 17,
//                       ),
//                     ),
//                   ),
//                   StoryItem.inlineImage(
//                     url:
//                         "https://media.giphy.com/media/5GoVLqeAOo6PK/giphy.gif",
//                     controller: controller,
//                     caption: Text(
//                       "Hektas, sektas and skatad",
//                       style: TextStyle(
//                         color: Colors.white,
//                         backgroundColor: Colors.black54,
//                         fontSize: 17,
//                       ),
//                     ),
//                   )
//                 ],
//                 onStoryShow: (s) {
//                   print("Showing a story");
//                 },
//                 onComplete: () {
//                   print("Completed a cycle");
//                 },
//                 progressPosition: ProgressPosition.bottom,
//                 repeat: false,
//                 inline: true,
//               ),
//             ),
//             Material(
//               child: InkWell(
//                 onTap: () {
//                   Navigator.of(context).push(
//                       MaterialPageRoute(builder: (context) => MoreStories()));
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                       color: Colors.black54,
//                       borderRadius:
//                           BorderRadius.vertical(bottom: Radius.circular(8))),
//                   padding: EdgeInsets.symmetric(vertical: 8),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Icon(
//                         Icons.arrow_forward,
//                         color: Colors.white,
//                       ),
//                       SizedBox(
//                         width: 16,
//                       ),
//                       Text(
//                         "View more stories",
//                         style: TextStyle(fontSize: 16, color: Colors.white),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class MoreStories extends StatefulWidget {
//   @override
//   _MoreStoriesState createState() => _MoreStoriesState();
// }
//
// class _MoreStoriesState extends State<MoreStories> {
//   final storyController = StoryController();
//
//   @override
//   void dispose() {
//     storyController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("More"),
//       ),
//       body: StoryView(
//         storyItems: [
//           StoryItem.text(
//             title: "I guess you'd love to see more of our food. That's great.",
//             backgroundColor: Colors.blue,
//           ),
//           StoryItem.text(
//             title: "Nice!\n\nTap to continue.",
//             backgroundColor: Colors.red,
//             textStyle: TextStyle(
//               fontFamily: 'Dancing',
//               fontSize: 40,
//             ),
//           ),
//           StoryItem.pageImage(
//             url:
//                 "https://image.ibb.co/cU4WGx/Omotuo-Groundnut-Soup-braperucci-com-1.jpg",
//             caption: "Still sampling",
//             controller: storyController,
//           ),
//           StoryItem.pageImage(
//               url: "https://media.giphy.com/media/5GoVLqeAOo6PK/giphy.gif",
//               caption: "Working with gifs",
//               controller: storyController),
//           StoryItem.pageImage(
//             url: "https://media.giphy.com/media/XcA8krYsrEAYXKf4UQ/giphy.gif",
//             caption: "Hello, from the other side",
//             controller: storyController,
//           ),
//           StoryItem.pageImage(
//             url: "https://media.giphy.com/media/XcA8krYsrEAYXKf4UQ/giphy.gif",
//             caption: "Hello, from the other side2",
//             controller: storyController,
//           ),
//         ],
//         onStoryShow: (s) {
//           print("Showing a story");
//         },
//         onComplete: () {
//           print("Completed a cycle");
//         },
//         progressPosition: ProgressPosition.top,
//         repeat: false,
//         controller: storyController,
//       ),
//     );
//   }
// }
class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  List<Map> statisticItems = [
    {
      "title": "Event Analysis",
      "desc" : "Symptoms and heath\nanalysis",
      "btnTitle" :"Unlock",
      "image": "assets/temp/health_analysis.png",
      "height":"110",
      "width":"110",
    },
    {
      "title": "Health report for doctor",
      "desc" : "The report is based on the cycles\nyou marked in the app",
      "btnTitle" :"DOWNLOAD REPORT",
      "image":"assets/temp/female_doctor.png",
      "height":"140",
      "width":"140"
    },
    {
      "title": "Statistics of all cycles for all\ntime",
      "cycles" : "Cycles length",
      "periods" :"Periods length",
      "cyclesLength":"28 days",
      "periodsLength":"5 days",
      "image":"assets/temp/statistic_cycle.png"
    },
  ];
  int currentPageIndex = 0;
  // final List<Widget> carouselItems = [
  //   ThirdItemWidget(),
  //   ThirdItemWidget(),
  //   ThirdItemWidget(),
  // ];
  int currentIndex=0;
  final _carousalController=CarouselController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Statistic",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        // color: fontColor,
                      ),
                    )
                  ],
                )),
            // Padding(
            //   padding: const EdgeInsets.only(top: 30),
            //   child: Container(
            //     height: 250,
            //     alignment: Alignment.center,
            //     child: ListView.builder(
            //       itemCount: 3,
            //       scrollDirection: Axis.horizontal,
            //       itemBuilder: (context, index){
            //         if(index==2){
            //           return ThirdItemWidget();
            //         }else{
            //           return FirstTwoItemWidget(
            //             title: "${statisticItems[index]["title"]}",
            //             desc: "${statisticItems[index]["desc"]}",
            //             image: "${statisticItems[index]["image"]}",
            //             btnTitle: "${statisticItems[index]["btnTitle"]}",
            //             height: double.parse(statisticItems[index]["height"].toString()),
            //             width: double.parse(statisticItems[index]["width"].toString()),
            //           );
            //         }
            //       },
            //     ),
            //   ),
            // ),
            const SizedBox(height: 20),
            CarouselSlider(
              options: CarouselOptions(
                height: 250,
                viewportFraction: 1,
                reverse: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
              items: List.generate(statisticItems.length, (index) {
                final item = statisticItems[index];
                print("ietms${statisticItems[index]}}");
                if(index==0){
                  return FirstTwoItemWidget(
                    title: item["title"],
                    desc: item["desc"],
                    image: item["image"],
                    btnTitle: item["btnTitle"],
                    height: double.parse(item["height"].toString()),
                    width: double.parse(item["width"].toString()),
                  );
                }else if(index==1){
                  return FirstTwoItemWidget(
                    title: item["title"],
                    desc: item["desc"],
                    image: item["image"],
                    btnTitle: item["btnTitle"],
                    height: double.parse(item["height"].toString()),
                    width: double.parse(item["width"].toString()),
                  );
                }else{
                  return ThirdItemWidget(
                    image: item["image"],
                    title: item["title"],
                    cycles: item["cycles"],
                    cyclesLength: item["cyclesLength"],
                    periods: item["periods"],
                    periodsLength: item["periodsLength"],
                  );
                }
                // if (item.containsKey("cycles") && item.containsKey("periods")) {
                //
                // } else {
                //   return FirstTwoItemWidget(
                //     title: item["title"],
                //     desc: item["desc"],
                //     image: item["image"],
                //     btnTitle: item["btnTitle"],
                //     height: double.parse(item["height"].toString()),
                //     width: double.parse(item["width"].toString()),
                //   );
                // }
              }),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(statisticItems.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(3),
                    child: Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        color: currentIndex == index ? accentColor : fontLightColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FirstTwoItemWidget extends StatelessWidget {
  const FirstTwoItemWidget({
    super.key,
    required this.title,
    required this.desc,
    required this.btnTitle,
    required this.image,
    this.height=110,
    this.width=110
  });
   final String title;
   final String desc;
   final String btnTitle;
   final String image;
   final double height;
   final double width;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 6, bottom: 15, right: 10),
      child: Container(
        height: 210,
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: bgColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius: 0.5,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 8, bottom: 35),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                  height: height,
                  width: width,
                ),
              ),
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 25, left: 17),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: fontColor,
                    ),
                  ),
                )),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 17, bottom:38),
                  child: Text(
                    desc,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: fontColor.withOpacity(0.5),
                    ),
                  ),
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: CustomAppButton(
                  onTap: (){},
                  height: 40,
                  fontSize: 15,
                  image: "assets/temp/lock.png",
                  title: btnTitle,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
class ThirdItemWidget extends StatelessWidget {
  const ThirdItemWidget({
    super.key,
    required this.title,
    required this.cycles,
    required this.cyclesLength,
    required this.periods,
    required this.periodsLength, required this.image,
  });
  final String title;
  final String cycles;
  final String cyclesLength;
  final String periods;
  final String periodsLength;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 10, bottom: 15, right: 10),
      child: Container(
        height: 210,
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: bgColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius: 0.5,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 8, bottom: 35),
                child: Image.asset(
                  // "assets/temp/statistic_cycle.png",
                  image,
                  fit: BoxFit.cover,
                  // height: 200,
                  // width: 200,
                ),
              ),
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, left: 17),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: fontColor,
                    ),
                  ),
                )),
            Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10,left: 17, bottom:18, right: 17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cycles,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: fontColor.withOpacity(0.5),
                        ),
                      ),
                      Container(
                        height: 33,
                        width: 86,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: Colors.red
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          cyclesLength,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: bgColor,
                          ),
                        ),
                      )
                    ],
                  ),
                )),
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only( left: 17, bottom:32, right: 17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        periods,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: fontColor.withOpacity(0.5),
                        ),
                      ),
                      Container(
                        height: 33,
                        width: 72,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: Colors.red
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          periodsLength,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: bgColor,
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
