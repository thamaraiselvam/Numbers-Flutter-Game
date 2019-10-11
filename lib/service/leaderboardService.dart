import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:numbers/store/SettingsStore.dart';
import 'package:numbers/utils/Common.dart';

class LeaderboardService {
  final String collection = 'leaderboard';
  final String orderByKey = 'score';
  final Map<String, int> leaderBoardTypes = {
    'overall': 0,
    'weekly': 7,
    'daily': 1
  };

  setData(Map gameState) async {
    Map newData = await this._formatSetData(gameState);
    Firestore.instance.collection(this.collection).document().setData(newData);
  }

  _formatSetData(Map gameState) async {
    String name = await SettingsStore().getKey('name');

    if (name == null) {
      name = Common.getRandomName();
    }

    return {
      'name': name,
      'time': DateTime.now().millisecondsSinceEpoch.toString(),
      'total': gameState['total'],
      'success': gameState['success'],
      'fail': gameState['fail'],
      'score': gameState['score'],
      'selectedBlocks': gameState['selectedBlocks'],
    };
  }

  getData({int limit = 6, leaderboardType = 'overall'}) async {
    try {
      int daysToSubtract = this.leaderBoardTypes[leaderboardType];
      var resultData;

      if (daysToSubtract != 0) {
        String lastWeekTimeStamp = DateTime.now()
            .subtract(Duration(days: daysToSubtract))
            .millisecondsSinceEpoch
            .toString();

        resultData = await _getDataByTimeCondition(lastWeekTimeStamp);

      } else {
        resultData = await _getOverallData(limit);
      }

      return this._formatGetData(resultData, limit);
    } catch (error) {
      //print(error);
    }
  }

  _getDataByTimeCondition(String daysToSubtract) async {
    return await Firestore.instance
        .collection(this.collection)
        .where("time", isGreaterThanOrEqualTo: daysToSubtract)
        .getDocuments();
  }

  _getOverallData(limit) async {
    return await Firestore.instance
        .collection(this.collection)
        .orderBy(this.orderByKey, descending: true)
        .limit(limit)
        .getDocuments();
  }

  _formatGetData(collection, limit) {
    List list = this._formList(collection);
    _sortList(list);
    list = _addRank(list);
    return _splitList(list, 0, limit);
  }

  List _formList(collection) {
    List list = [];
    for (var document in collection.documents) {
      list.add(document.data);
    }

    return list;
  }

  _sortList(List documents) {
    documents.sort((m1, m2) {
      return m2["score"].compareTo(m1["score"]);
    });
  }

  List _addRank(List documents) {
    int counter = 0;
    for (var document in documents) {
      document['rank'] = ++counter;
    }

    return documents;
  }

  List _splitList(List list, int start, int end) {
    if (list.length < end) {
      end = list.length;
    }
    return list.sublist(start, end);
  }
}
