class Cycles {
  String? cycles;
  String? periods;
  String? hasData;

  Cycles({this.cycles, this.periods, this.hasData});

  Cycles.fromJson(Map<String, dynamic> json) {
    cycles = json['cycles'];
    periods = json['periods'];
    hasData = json['hasData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cycles'] = this.cycles;
    data['periods'] = this.periods;
    data['hasData'] = this.hasData;
    return data;
  }
}