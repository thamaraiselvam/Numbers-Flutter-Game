import 'package:shared_preferences/shared_preferences.dart';

class BestScoreStore {
  SharedPreferences prefs;
  final String key = 'bestScore';
  init() async {
    if (this.prefs == null) {
      this.prefs = await SharedPreferences.getInstance();
    }
  }

  updateScore(int currentBest) async {
    int bestScore = await getBestScore();

    bestScore = bestScore > currentBest ? bestScore : currentBest;

    return await this.prefs.setInt(this.key, bestScore);
  }

  Future getBestScore() async {
    await this.init();
    return this.prefs.getInt(this.key) == null ? 0 : this.prefs.getInt(this.key);
  }
}
