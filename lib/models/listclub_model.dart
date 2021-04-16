class ListClubModel {
  String strTeamBadge;
  String strTeam;
  String strCountry;

  ListClubModel({this.strTeamBadge, this.strTeam, this.strCountry});

  factory ListClubModel.fromJson(Map<String, dynamic> json) {
    return ListClubModel(
      strTeamBadge: json['strTeamBadge'],
      strTeam: json['strTeam'],
      strCountry: json['strCountry'],
    );
  }
}
