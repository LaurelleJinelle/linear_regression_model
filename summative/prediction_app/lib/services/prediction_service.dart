

class PredictionService {
  // Replace this with actual ML model API call.
  static String getPrediction({
    required double marketSize,
    required double funding,
    required int teamExperience,
    required String industry,
  }) {
    int score = 0;

    if (marketSize > 500) score += 2;
    if (funding > 1000000) score += 3;
    if (teamExperience > 5) score += 2;
    if (['Tech', 'Healthcare'].contains(industry)) score += 1;

    return score > 5 ? "Success" : "Failure";
  }
}