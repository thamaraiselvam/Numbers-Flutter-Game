import 'dart:convert';
import 'package:numbers/service/RecentScoreService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScoreStore {
  SharedPreferences prefs;

  final String scoreKey = 'recentScoreDummy';
  final maxStoreLength = 3;

  init() async {
    if (this.prefs == null) {
      this.prefs = await SharedPreferences.getInstance();
    }
  }

  updateRecentScore(int score) async {

    await this.init();

    List recentScores = await this.getRecentScore();

    RecentScore newScore = RecentScore.manualPush(score.toString(), DateTime.now().millisecondsSinceEpoch.toString());

    recentScores.insert(0, newScore);

    if (recentScores.length > this.maxStoreLength) {
      recentScores.removeLast();
    }

    return await this.prefs.setString(this.scoreKey, json.encode(recentScores));
  }

  Future getRecentScore() async {
    await this.init();
    String recentScores = this.prefs.getString(this.scoreKey);
    return recentScores == null ? [] : recentScoreFromJson(recentScores);
  }
}
