import 'package:flutter/material.dart';

import '../models/profile/cycles.dart';

class UserDataProvider with ChangeNotifier{
 Cycles _cycles=Cycles();

 Cycles get cycles => _cycles;

  set cycles(Cycles value) {
    _cycles = value;
    notifyListeners();
  }
}