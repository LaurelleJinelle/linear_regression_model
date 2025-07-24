// lib/services/prediction_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/startup_data.dart'; // We will update this model next

class PredictionService {
  // IMPORTANT: Replace this with your actual Render API URL
  static const String apiUrl = "https://startup-prediction-47o8.onrender.com/predict";

  static Future<Map<String, dynamic>> getPrediction(StartupData features) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        // Convert the StartupData object to a JSON string
        body: jsonEncode(features.toJson()),
      );

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON.
        return jsonDecode(response.body);
      } else {
        // If the server did not return a 200 OK response,
        // throw an exception with the error details.
        throw Exception('Failed to get prediction: ${response.body}');
      }
    } catch (e) {
      // Handle potential network errors or other exceptions.
      throw Exception('Failed to connect to the prediction service: $e');
    }
  }
}