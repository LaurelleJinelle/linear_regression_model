import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/startup_data.dart'; 

class PredictionService {
  static const String apiUrl = "https://startup-prediction-api.onrender.com/predict";

  static Future<Map<String, dynamic>> getPrediction(StartupData features) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(features.toJson()),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to get prediction: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the prediction service: $e');
    }
  }
}