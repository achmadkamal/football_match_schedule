class MatchClubModel {
  String strLeague;
  String strEvent;
  String dateEvent;
  String strTime;
  String strThumb;

  MatchClubModel({this.strLeague, this.strEvent, this.dateEvent, this.strTime, this.strThumb});

  factory MatchClubModel.fromJson(Map<String, dynamic> json) {
    return MatchClubModel(
      strLeague: json['strLeague'],
      strEvent: json['strEvent'],
      dateEvent: json['dateEvent'],
      strTime: json['strTime'],
      strThumb: json['strThumb'],
    );
  }
}
