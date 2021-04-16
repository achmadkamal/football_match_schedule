import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:football_match_schedule/component/list_card.dart';
import 'package:football_match_schedule/models/listclub_model.dart';
import 'package:http/http.dart' as http;

class ListClubScreen extends StatefulWidget {
  @override
  _ListClubScreenState createState() => _ListClubScreenState();
}

class _ListClubScreenState extends State<ListClubScreen> {
  TextEditingController controller = TextEditingController();
  List<ListClubModel> _listClub = [];
  List<ListClubModel> _searchClub = [];
  bool isloading = false;

  Future fetchListClub() async {
    isloading = true;
    final response = await http.get(
        'https://www.thesportsdb.com/api/v1/json/1/search_all_teams.php?l=English%20Premier%20League');

    if (response.statusCode == 200) {
      var listData = jsonDecode(response.body)['teams'];
      setState(() {
        for (var data in listData) {
          _listClub.add(ListClubModel.fromJson(data));
          isloading = false;
        }
      });
    }
  }

  void onSearch(String inputValue) {
    _searchClub.clear();
    if (inputValue.isEmpty) {
      setState(() {});
      return;
    } else {
      _listClub.forEach((f) {
        if (f.strTeam.toLowerCase().contains(inputValue) ||
            f.strCountry.toLowerCase().contains(inputValue)) {
          _searchClub.add(f);
        }
      });
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    fetchListClub();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Card(
              child: ListTile(
                leading: Icon(Icons.search),
                title: TextField(
                  controller: controller,
                  onChanged: onSearch,
                  decoration: InputDecoration(
                    hintText: "Search",
                    border: InputBorder.none,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    controller.clear();
                    onSearch('');
                  },
                  icon: Icon(Icons.cancel),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: isloading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Expanded(
                      child:
                          _searchClub.length != 0 || controller.text.isNotEmpty
                              ? ListView.builder(
                                  itemCount: _searchClub.length,
                                  itemBuilder: (context, index) {
                                    final itemSearch = _searchClub[index];
                                    return ListCard(
                                      image: itemSearch.strTeamBadge,
                                      name: itemSearch.strTeam,
                                      country: itemSearch.strCountry,
                                    );
                                  })
                              : ListView.builder(
                                  itemCount: _listClub.length,
                                  itemBuilder: (context, index) {
                                    final itemList = _listClub[index];
                                    return ListCard(
                                      image: itemList.strTeamBadge,
                                      name: itemList.strTeam,
                                      country: itemList.strCountry,
                                    );
                                  },
                                ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
