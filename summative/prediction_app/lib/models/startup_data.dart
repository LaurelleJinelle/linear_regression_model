// lib/models/startup_data.dart
class StartupData {
  int relationships;
  int has_roundB;
  int funding_rounds;
  int has_roundA;
  int has_roundC;
  int has_roundD;
  int funding_total_usd;

  StartupData({
    this.relationships = 10,
    this.has_roundB = 0,
    this.funding_rounds = 1,
    this.has_roundA = 0,
    this.has_roundC = 0,
    this.has_roundD = 0,
    this.funding_total_usd = 500000,
  });

  // Add this method to convert the object to JSON
  Map<String, dynamic> toJson() => {
    'relationships': relationships,
    'has_roundB': has_roundB,
    'funding_rounds': funding_rounds,
    'has_roundA': has_roundA,
    'has_roundC': has_roundC,
    'has_roundD': has_roundD,
    'funding_total_usd': funding_total_usd,
  };
}