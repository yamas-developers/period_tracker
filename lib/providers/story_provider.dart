import 'package:flutter/material.dart';

import '../models/status.dart';

class StoryProvider extends ChangeNotifier {
  StoryProvider() {}

  String _name = '';

  String get name {
    return _name;
  }

  String setName(String val) {
    return _name;
  }

  set name(String val) {
    _name = val;
    notifyListeners();
  }

  Story introStory = Story(id: '1', statuses: [
    Status(
        color: Colors.purple,
        description: 'Track your cycle in a simple and convenient interface',
        image: 'assets/temp/intro_1.jpg'),
    Status(
        color: Colors.purple,
        description: 'Get health tips and advices',
        image: 'assets/temp/intro_2.jpg'),
    Status(
        color: Colors.purple,
        description: 'Set goals and we will help you achieve them!',
        image: 'assets/temp/intro_3.jpg'),
    Status(
        color: Colors.purple,
        description:
            'Maintain health records and get a health report for a doctor',
        image: 'assets/temp/intro_4.jpg'),
  ]);

  List<Story> stories = <Story>[
    Story(id: '1', statuses: [
      Status(
          color: Colors.purple,
          description: 'Why do I have nightmares',
          image: 'assets/temp/nightmare4.jpeg'),
      Status(
          color: Colors.purple,
          description: 'The most common causes of bad dreams are '
              'anxiety',
          image: 'assets/temp/nightmare2.jpeg'),
      Status(
          color: Colors.purple,
          description: 'Sometimes a nightmare can be a consequence of '
              'trivial overeating',
          image: 'assets/temp/nightmare3.jpeg'),
      Status(
          color: Colors.purple,
          description: 'If you are disturbed by a nightmare then it is worth'
              'seeing a psychotherapist who can sort out of the problems',
          image: 'assets/temp/nightmare1.jpeg'),
    ]),
    Story(id: '2', statuses: [
      Status(
          color: Colors.blue,
          description: 'Vitamins for pregnancy planning',
          image: 'assets/temp/temp8.jpeg'),
      Status(
          color: Colors.purple,
          description:
              'Folic acid is neccessary for proper laying of the neural tube '
              'of the fetus',
          image: 'assets/temp/temp9.jpeg'),
      Status(
          color: Colors.purple,
          description: 'Iodine is part of thyroid hormones',
          image: 'assets/temp/temp10.jpeg'),
    ]),
    Story(id: '3', statuses: [
      Status(
          color: Colors.blue,
          description: 'A subcutaneous implant for contraception',
          image: 'assets/temp/temp5.jpeg'),
      Status(
          color: Colors.purple,
          description:
              'A subcutaneous implant is small, flexible rod that the doctor inserts under '
              'the skin of upper arm',
          image: 'assets/temp/temp6.jpeg'),
      Status(
          color: Colors.purple,
          description:
              'Before using any contraceptive it is important to talk to your doctor',
          image: 'assets/temp/temp7.jpeg'),
    ]),
    Story(id: '4', statuses: [
      Status(
          color: Colors.blue,
          description: 'How do hormonal contraceptives work?',
          image: 'assets/temp/temp11.jpeg'),
      Status(
          color: Colors.purple,
          description: 'Hormonal contraceptives thicken mucus in the cervix',
          image: 'assets/temp/temp12.jpeg'),
      Status(
          color: Colors.purple,
          description:
              'Hormonal contraceptives are reliable when used properly',
          image: 'assets/temp/temp13.jpeg'),
    ]),
  ];
}

StoryProvider obj = StoryProvider();
