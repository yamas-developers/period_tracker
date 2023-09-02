import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:period_tracker/providers/story_provider.dart';
import 'package:period_tracker/ui/self_care/status_view.dart';
import 'package:period_tracker/utils/constants.dart';
import 'package:period_tracker/utils/public_methods.dart';
import 'package:provider/provider.dart';
import '../../widgets/custom_app_button.dart';

import '../../intro/graph.dart';
import '../../models/status.dart';
import '../../widgets/showModalBottomSheet.dart';
import 'statuses.dart';

class SelfCareScreen extends StatefulWidget {
  @override
  _SelfCareScreenState createState() => _SelfCareScreenState();
}

class _SelfCareScreenState extends State<SelfCareScreen> {
  int? selectedIndex;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedIndex=null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        // title: ,
      ),
      body: Consumer<StoryProvider>(
        builder: (context, storyProvider, child){
          return Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18, 18, 0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Self Care',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24)),
                  SizedBox(height: 14),
                  Statuses(),
                  SizedBox(height: 18),
                  StatisticsWidget(),
                  SizedBox(height: 18),
                  GestureDetector(
                    onTap: () async {
                      await Navigator.push(context,
                          MaterialPageRoute(builder: (context) => StatusView(story: storyProvider.healthReportStory)));
                      context.read<StoryProvider>().notifyListeners();
                    },
                    child: ExerciseItem(
                        title: 'Health Report for doctor',
                        titleWidth: getWidth(context) * 0.4,
                        subTitle: Row(
                          children: [
                            Icon(Icons.cloud_download_outlined, color: fontColor,),
                            SizedBox(
                              width: 6,
                            ),
                            Text('PDF',
                                style: TextStyle(
                                  color: fontColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ))
                          ],
                        ),
                        image: 'assets/icons/pdf_icon.png',
                        color: Color(0xffc8f5ec)
                    ),
                  ),
                  SizedBox(height: 24),
                  Text('Exercises'.toUpperCase(),
                      style: TextStyle(
                        // color: fontLightColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      )),
                  SizedBox(height: 14),
                  ExerciseItem(
                      title: 'Kegel Exercises',
                      titleWidth: getWidth(context) * 0.3,
                      image: 'assets/icons/kegel_exercise.png',
                      imageWidth: 130,
                      color: Color(0xfff7cbe8)),
                  SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap:(){
                                // showModalBottomSheet(
                                //     context: context,
                                //     isScrollControlled: true,
                                //     shape: const RoundedRectangleBorder(
                                //         borderRadius:
                                //         BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), )),
                                //     builder: (context) {
                                //       return StatefulBuilder(
                                //         builder: (BuildContext context, void Function(void Function()) setState) {
                                //           return Container(
                                //             height: MediaQuery.of(context).size.height * 0.67,
                                //             padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                //             child: SingleChildScrollView(
                                //               child: Column(
                                //                 children: [
                                //                   Padding(
                                //                     padding:const  EdgeInsetsDirectional.only(top: 10),
                                //                     child: Row(
                                //                       mainAxisAlignment: MainAxisAlignment.end,
                                //                       children: [
                                //                         GestureDetector(
                                //                           onTap:(){
                                //                             setState(() {
                                //                               selectedIndex = null;
                                //                             });
                                //                             Navigator.pop(context);
                                //                           },
                                //                           child: Icon(
                                //                             Icons.cancel,
                                //                             color: accentColor,
                                //                             size: 28,
                                //                           ),
                                //                         ),
                                //                       ],
                                //                     ),
                                //                   ),
                                //                   Padding(
                                //                       padding: EdgeInsets.only(top: 3),
                                //                       child: Row(
                                //                         mainAxisAlignment: MainAxisAlignment.center,
                                //                         children: [
                                //                           Image.asset(
                                //                             "assets/temp/female_taking_picture.png",
                                //                             fit: BoxFit.cover,
                                //                             height: 150,width: 150,
                                //                           )
                                //                         ],
                                //                       )
                                //                   ),
                                //                   const Padding(
                                //                       padding: EdgeInsets.only(top: 30),
                                //                       child: Row(
                                //                         mainAxisAlignment: MainAxisAlignment.center,
                                //                         children: [
                                //                           Text(
                                //                             "We're twisting, we're turning, we're\n"
                                //                                 "about to launch a new feature😎",
                                //                             style: TextStyle(
                                //                                 fontSize: 19,
                                //                                 color: fontColor,
                                //                                 fontWeight: FontWeight.bold
                                //                             ),
                                //                           )
                                //                         ],
                                //                       )
                                //                   ),
                                //                   Padding(
                                //                       padding: const EdgeInsets.only(top: 30),
                                //                       child: Row(
                                //                         mainAxisAlignment: MainAxisAlignment.center,
                                //                         children: [
                                //                           Text(
                                //                             "Find out how beneficial it'll be for you",
                                //                             style: TextStyle(
                                //                               fontSize: 15,
                                //                               color: fontColor.withOpacity(0.5),
                                //                             ),
                                //                           )
                                //                         ],
                                //                       )
                                //                   ),
                                //                   Padding(
                                //                       padding: const EdgeInsets.only(top: 30),
                                //                       child: Row(
                                //                         mainAxisAlignment: MainAxisAlignment.center,
                                //                         children: [
                                //                           ...List.generate(5, (index) {
                                //                             return GestureDetector(
                                //                               onTap: (){
                                //                                 setState(() {
                                //                                   selectedIndex=index;
                                //                                 });
                                //                               },
                                //                               child: Padding(
                                //                                 padding: const EdgeInsets.all(5),
                                //                                 child: Container(
                                //                                   height: 42,
                                //                                   width: 42,
                                //                                   alignment: Alignment.center,
                                //                                   decoration: BoxDecoration(
                                //                                       borderRadius: BorderRadius.circular(10),
                                //                                       color: fontLightColor.withOpacity(0.06),
                                //                                       border: selectedIndex==index?Border.all(
                                //                                         color: accentColor,
                                //                                         width: 2,
                                //                                       ):null
                                //                                   ),
                                //                                   child: Text(
                                //                                     index.toString(),
                                //                                     style: TextStyle(
                                //                                         fontSize: 18,
                                //                                         color: fontColor.withOpacity(0.5),
                                //                                         fontWeight: FontWeight.w500
                                //                                     ),
                                //                                   ),
                                //                                 ),
                                //                               ),
                                //                             );
                                //                           })
                                //                         ],
                                //                       )
                                //                   ),
                                //                   selectedIndex!=null?
                                //                   GestureDetector(
                                //                     onTap: (){},
                                //                     child: Padding(
                                //                       padding: const EdgeInsets.only(top:20),
                                //                       child: CustomAppButton(
                                //                         onTap: (){},
                                //                         height: 40,
                                //                         fontSize: 15,
                                //                         image: "",
                                //                         title: "RATE",
                                //                       ),
                                //                     ),
                                //                   ):Padding(
                                //                     padding: const EdgeInsets.only(top:20),
                                //                     child: CustomAppButton(
                                //                       onTap: (){},
                                //                       height: 40,
                                //                       fontSize: 15,
                                //                       image: "",
                                //                       color: bgColor.withOpacity(0.5),
                                //                       title: "RATE",
                                //                     ),
                                //                   ),
                                //                 ],
                                //               ),
                                //             ),
                                //           );
                                //         },
                                //       );
                                //     }).whenComplete(() {
                                //   setState(() {
                                //     selectedIndex = null;
                                //   });
                                // });
                                Navigator.pushNamed(context, "showModalBottomSheetScreen", arguments: {
                                  "type":"yogaForBody"
                                });
                              },
                              child: ExerciseItem(
                                title: 'Yoga for body',
                                titleWidth: getWidth(context) * 0.3,
                                image: 'assets/icons/girl_yoga.png',
                                imageWidth: 190,
                                color: Color(0xffffe5a6),
                                height: 240,
                                imagePadding: const EdgeInsets.only(right: 0),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.pushNamed(context, "showModalBottomSheetScreen", arguments: {
                                  "type":"breathingExercise"
                                });
                              },
                              child: ExerciseItem(
                                title: 'Breathing exercises',
                                titleWidth: getWidth(context) * 0.8,
                                image: 'assets/icons/flower_icon.png',
                                imageWidth: 80,
                                color: Color(0xffdfe7ff),
                                height: 140,
                                imagePadding: const EdgeInsets.only(right: 0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap:(){
                                Navigator.pushNamed(context, "showModalBottomSheetScreen", arguments: {
                                  "type":"physicalExercise"
                                });
                              },
                              child: ExerciseItem(
                                title: 'Physical exercise',
                                titleWidth: getWidth(context) * 0.8,
                                image: 'assets/icons/physical_exercise.png',
                                imageWidth: 100,
                                color: Color(0xffc7f1df),
                                height: 140,
                                imageAlignment: Alignment.topRight,
                                imagePadding: const EdgeInsets.only(right: 0),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.pushNamed(context, "showModalBottomSheetScreen", arguments: {
                                  "type":"faceYoga"
                                });
                              },
                              child: ExerciseItem(
                                title: 'Face Yoga',
                                titleWidth: getWidth(context) * 0.8,
                                image: 'assets/icons/face_yoga.png',
                                imageWidth: 190,
                                color: Color(0xffdaf0fc),
                                height: 240,
                                imagePadding: const EdgeInsets.only(right: 0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Text('Counters'.toUpperCase(),
                      style: TextStyle(
                        // color: fontLightColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      )),
                  SizedBox(height: 14),
                  ExerciseItem(
                      title: 'Weight monitor',
                      titleWidth: getWidth(context) * 0.3,
                      image: 'assets/icons/weight_monitor.png',
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>WightGraphScreen()));
                      },
                      subTitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('July 8',
                              style: TextStyle(
                                color: fontLightColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              )),
                          SizedBox(
                            height: 2,
                          ),
                          Text('55 kg',
                              style: TextStyle(
                                color: fontColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ))
                        ],
                      ),
                      imageWidth: 130,
                      color: Color(0xffcfe8b0)),
                  SizedBox(height: 24),
                  Text('Diagonistics'.toUpperCase(),
                      style: TextStyle(
                        // color: fontLightColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      )),
                  SizedBox(height: 14),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, "showModalBottomSheetScreen", arguments: {
                        "type":"breastSelfCheck"
                      });
                    },
                    child: ExerciseItem(
                      title: 'Breast self check',
                      titleWidth: getWidth(context) * 0.6,
                      subTitle: Text('Soon',
                          style: TextStyle(fontSize: 18, color: fontColor)),
                      image: 'assets/icons/breast_self_check.png',
                      imageWidth: 130,
                      color: Color(0xfff7cacd),
                      imagePadding: const EdgeInsets.only(right: 0),
                    ),
                  ),
                  SizedBox(height: 34),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}

class ExerciseItem extends StatelessWidget {
  const ExerciseItem(
      {super.key,
      required this.title,
      this.subTitle = const SizedBox(),
      required this.image,
      this.color = Colors.white,
      this.titleWidth = double.infinity,
      this.imageWidth = 120,
      this.height = 150,
      this.imageAlignment = Alignment.bottomRight,
      this.imagePadding = const EdgeInsets.only(right: 18), this.onTap});

  final String title;
  final double titleWidth;
  final Widget subTitle;
  final String image;
  final double imageWidth;
  final Color color;
  final double height;
  final AlignmentGeometry imageAlignment;
  final EdgeInsetsGeometry imagePadding;
  final dynamic onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Stack(
            children: [
              Align(
                alignment: imageAlignment,
                child: Padding(
                  padding: imagePadding,
                  child: Image.asset(
                    '$image',
                    height: imageWidth,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
                  child: SizedBox(
                    width: titleWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$title',
                          style: TextStyle(
                            color: fontColor,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subTitle,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

class StatisticsWidget extends StatelessWidget {
  const StatisticsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'STATISTICS',
          style: TextStyle(
              // color: fontColor
          ),
        ),
        Text(
          'Statistics for all cycles for all time',
          style: TextStyle(
              // color: fontLightColor
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
                child: SelfCareStatWidget(
              title: 'Average cycle length',
              subTitle: '194 days',
            )),
            SizedBox(
              width: 2,
            ),
            Expanded(
                child: SelfCareStatWidget(
              title: 'Average period duration',
              subTitle: '7 days',
            )),
          ],
        )
      ],
    );
  }
}

class SelfCareStatWidget extends StatelessWidget {
  const SelfCareStatWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
          color: greyBgColor, borderRadius: BorderRadius.circular(4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${title}',
            style: TextStyle(
                color: fontColor,
                fontSize: 12),
          ),
          Text(
            '${subTitle}',
            style: TextStyle(color: fontColor,fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
