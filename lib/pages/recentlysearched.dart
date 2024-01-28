import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homescreen/pages/search_history_provider.dart';
import 'package:provider/provider.dart';

class SearchHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final searchHistoryProvider = Provider.of<SearchHistoryProvider>(context);
    final searchHistory = searchHistoryProvider.searchHistory;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 50, left: 20),
                  child: Container(
                    height: size.width * 0.1,
                    width: size.width * 0.1,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          offset: Offset(2, 2),
                          blurRadius: 2,
                        ),
                      ],
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Icon(CupertinoIcons.back),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 60),
                child: Text(
                  'Recently Viewed',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      letterSpacing: 1.5),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchHistory.length,
              itemBuilder: (context, index) {
                final query = searchHistory[index];
                return ListTile(
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      query,
                      style: TextStyle(fontFamily: 'Montserrat'),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context, query);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
