import 'package:flutter/material.dart';

DataTable leaderboardTable(List listOfColumns) {
  return DataTable(
    columns: [
      DataColumn(label: Text('Rank')),
      DataColumn(label: Text('Name')),
      DataColumn(label: Text('Score')),
    ],
    rows: listOfColumns
        .map(
          ((element) => DataRow(
                cells: <DataCell>[
                  DataCell(Text(element['rank'].toString())),
                  DataCell(Text(element['name'].toString())),
                  DataCell(Text(element['score'].toString())),
                ],
              )),
        )
        .toList(),
  );
}
