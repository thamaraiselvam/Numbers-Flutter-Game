import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;


DataTable recentScoreTable(List listOfColumns) {
  return DataTable(
    columns: [
      DataColumn(label: Text('Score')),
      DataColumn(label: Text('')),
      DataColumn(label: Text('Time')),
    ],
    rows: listOfColumns
        .map(
          ((element) => DataRow(
                cells: <DataCell>[
                  DataCell(Text(element.score)),
                  DataCell(Text('')),
                  DataCell(Text(timeago.format(DateTime.fromMillisecondsSinceEpoch(int.parse(element.time))))),
                ],
              )),
        )
        .toList(),
  );
}
