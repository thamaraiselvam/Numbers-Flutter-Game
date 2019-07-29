import 'package:flutter/material.dart';
import 'package:numbers/utils/constants.dart';
import 'package:numbers/widgets/dashedLine.dart';
import 'package:numbers/widgets/tableRow.dart';

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
                    1: FractionColumnWidth(0.7),
                    2: FractionColumnWidth(0.2)
                  },
                  children: [
                    buildTableRow("Rank,Name,Score"),
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
}
