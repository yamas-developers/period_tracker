import 'package:flutter/material.dart';
import 'package:period_tracker/providers/story_provider.dart';
import 'package:period_tracker/ui/self_care/status_view.dart';
import 'package:period_tracker/utils/constants.dart';
import 'package:period_tracker/utils/public_methods.dart';
import 'package:provider/provider.dart';

import '../../intro/graph.dart';
import '../../models/status.dart';
import 'statuses.dart';

class SelfCareScreen extends StatefulWidget {
  @override
  _SelfCareScreenState createState() => _SelfCareScreenState();
}

class _SelfCareScreenState extends State<SelfCareScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        // title: ,
      ),
      body: Padding(
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
              ExerciseItem(
                  title: 'Health Report for doctor',
                  titleWidth: getWidth(context) * 0.4,
                  subTitle: Row(
                    children: [
                      Icon(Icons.cloud_download_outlined),
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
                  color: Color(0xffc8f5ec)),
              SizedBox(height: 24),
              Text('Exercises'.toUpperCase(),
                  style: TextStyle(
                    color: fontLightColor,
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
                        ExerciseItem(
                          title: 'Yoga for body',
                          titleWidth: getWidth(context) * 0.3,
                          image: 'assets/icons/girl_yoga.png',
                          imageWidth: 190,
                          color: Color(0xffffe5a6),
                          height: 240,
                          imagePadding: const EdgeInsets.only(right: 0),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        ExerciseItem(
                          title: 'Breathing exercises',
                          titleWidth: getWidth(context) * 0.8,
                          image: 'assets/icons/flower_icon.png',
                          imageWidth: 80,
                          color: Color(0xffdfe7ff),
                          height: 140,
                          imagePadding: const EdgeInsets.only(right: 0),
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
                        ExerciseItem(
                          title: 'Physical exercise',
                          titleWidth: getWidth(context) * 0.8,
                          image: 'assets/icons/physical_exercise.png',
                          imageWidth: 100,
                          color: Color(0xffc7f1df),
                          height: 140,
                          imageAlignment: Alignment.topRight,
                          imagePadding: const EdgeInsets.only(right: 0),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        ExerciseItem(
                          title: 'Face Yoga',
                          titleWidth: getWidth(context) * 0.8,
                          image: 'assets/icons/face_yoga.png',
                          imageWidth: 190,
                          color: Color(0xffdaf0fc),
                          height: 240,
                          imagePadding: const EdgeInsets.only(right: 0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Text('Counters'.toUpperCase(),
                  style: TextStyle(
                    color: fontLightColor,
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
                    color: fontLightColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  )),
              SizedBox(height: 14),
              ExerciseItem(
                title: 'Breast self check',
                titleWidth: getWidth(context) * 0.6,
                subTitle: Text('Soon',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
                image: 'assets/icons/breast_self_check.png',
                imageWidth: 130,
                color: Color(0xfff7cacd),
                imagePadding: const EdgeInsets.only(right: 0),
              ),
              SizedBox(height: 34),
            ],
          ),
        ),
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
          style: TextStyle(color: fontColor),
        ),
        Text(
          'Statistics for all cycles for all time',
          style: TextStyle(color: fontLightColor),
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
            style: TextStyle(color: fontColor, fontSize: 12),
          ),
          Text(
            '${subTitle}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
