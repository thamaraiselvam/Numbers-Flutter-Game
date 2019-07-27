import 'package:flutter/material.dart';
import 'package:numbers/utils/constants.dart';
import 'package:numbers/widgets/dashedLine.dart';

class ScoreBoard extends StatelessWidget {
  String title;
  ScoreBoard(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
      child: Column(
        children: <Widget>[
          Card(
            color: Colors.white,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.show_chart,
                    color: primaryColor,
                  ),
                  title: Text(title,
                      style: TextStyle(
                          color: primaryColor, fontWeight: FontWeight.bold)),
                ),
                dashedLineBreak(Colors.grey),
                Table(
                  columnWidths: {
                    0: FractionColumnWidth(0.2),
                    1: FractionColumnWidth(0.6),
                    2: FractionColumnWidth(0.2)
                  },
                  children: [
                    _buildTableRow("Rank,Name,Score"),
                  ],
                ),
                ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemExtent: 35,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Text(
                        index.toString(),
                        style: TextStyle(color: greyFontColor, fontSize: 13),
                      ),
                      title: Text(
                        'Thamaraiselvam',
                        style: TextStyle(color: greyFontColor, fontSize: 13),
                      ),
                      trailing: Text(index.toString() + ' days ago',
                          style: TextStyle(color: greyFontColor, fontSize: 13)),
                    );
                  },
                ),
                SizedBox(height: 15,)
              ],
            ),
          ),
        ],
      ),
    );
  }

  TableRow _buildTableRow(String listOfNames) {
    return TableRow(
      children: listOfNames.split(',').map((name) {
        return Container(
          child: Text(
            name,
            style: TextStyle(
                fontSize: 13.0,
                color: greyFontColor,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          padding: EdgeInsets.only(top: 15.0, left: 10),
        );
      }).toList(),
    );
  }
}
