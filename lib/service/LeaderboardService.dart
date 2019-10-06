import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:numbers/store/SettingsStore.dart';
import 'package:numbers/utils/Common.dart';

class LeaderboardService {
  final String collection = 'leaderboard';
  final String orderByKey = 'score';

  setData(Map gameState) async {
    Map newData = await this._formatSetData(gameState);
    Firestore.instance.collection(this.collection).document().setData(newData);
  }

  _formatSetData(Map gameState) async {

    String name = await SettingsStore().getKey('name');

    if(name == null){
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
