import 'package:flutter/material.dart';
import 'package:football_match_schedule/component/match_card.dart';
import 'package:football_match_schedule/models/matchclub_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MatchClubScreen extends StatefulWidget {
  @override
  _MatchClubScreenState createState() => _MatchClubScreenState();
}

class _MatchClubScreenState extends State<MatchClubScreen> {
  List<MatchClubModel> _matchClubList = [];
  bool isLoading = false;

  Future fetchMatchClub() async {
    isLoading = true;
    final response = await http.get(
        'https://www.thesportsdb.com/api/v1/json/1/eventspastleague.php?id=4328');
    if (response.statusCode == 200) {
      var listData = jsonDecode(response.body)['events'];
      setState(() {
        for (var data in listData) {
          _matchClubList.add(MatchClubModel.fromJson(data));
          isLoading = false;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMatchClub();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(10),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: _matchClubList.length,
                itemBuilder: (context, index) {
                  final itemMatch = _matchClubList[index];
                  return MatchCard(
                    image: itemMatch.strThumb,
                    event: itemMatch.strEvent,
                    date: 'Date : ' + itemMatch.dateEvent,
                    time: 'Time : ' + itemMatch.strTime,
                    league: itemMatch.strLeague,
                  );
                },
              ),
      ),
    );
  }
}
