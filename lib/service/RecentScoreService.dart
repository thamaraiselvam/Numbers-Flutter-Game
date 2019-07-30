import 'dart:convert';

List<RecentScore> recentScoreFromJson(String str) => new List<RecentScore>.from(json.decode(str).map((x) => RecentScore.fromJson(x)));

String recentScoreToJson(List<RecentScore> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class RecentScore {
    String score;
    String time;

    RecentScore({
        this.score,
        this.time,
    });

    RecentScore.manualPush(this.score, this.time);

    factory RecentScore.fromJson(Map<String, dynamic> json) => new RecentScore(
        score: json["score"],
        time: json["time"],
    );

    Map<String, dynamic> toJson() => {
        "score": score,
        "time": time,
    };
}
