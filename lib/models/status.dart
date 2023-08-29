import 'dart:core';

import 'package:flutter/material.dart';

class Story {
  String id;
  List<Status> statuses;
  bool seen = false;

  Story({required this.id, required this.statuses, this.seen = false});
}

class Status {
  Color? color;
  String? description;
  String? image;

  Status({this.color, this.description, this.image});
}


