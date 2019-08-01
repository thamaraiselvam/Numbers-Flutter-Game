import 'package:cloud_firestore/cloud_firestore.dart';

class leaderboardService {
  final String collection = 'leaderboard';
  final String orderByKey = 'score';

  setData(Map gameState) {
    Map newData = this._formatSetData(gameState);
    Firestore.instance.collection(this.collection).document().setData(newData);
  }

  _formatSetData(Map gameState) {
    return {
      'name': 'random',
      'device': 'random',
      'time': DateTime.now().millisecondsSinceEpoch.toString(),
      'total': gameState['total'],
      'success': gameState['success'],
      'fail': gameState['fail'],
      'score': gameState['score'],
      'selectedBlocks': gameState['selectedBlocks'],
    };
  }

  getData({int limit = 6}) async {
    try {
      var resultData = await Firestore.instance
          .collection(this.collection)
          .orderBy(this.orderByKey, descending: true)
          .limit(limit)
          .getDocuments();

      return this._formatGetData(resultData);
    } catch (error) {
      print(error);
    }
  }

  _formatGetData(resultData) {
    List formattedData = [];

    int counter = 0;
    for (var document in resultData.documents) {
      document.data['rank'] = ++counter;
      formattedData.add(document.data);
    }
    return formattedData;
  }
}
