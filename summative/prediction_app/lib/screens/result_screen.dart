

import 'package:flutter/material.dart';
import '../models/startup_data.dart';

class ResultScreen extends StatelessWidget {
  final String prediction;
  final StartupData formData;

  const ResultScreen({super.key, required this.prediction, required this.formData, required Map<String, dynamic> predictionResult});

  Widget _buildSummaryCard(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Summary of Inputs', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(height: 24),
            _buildSummaryRow('Market Size:', '\$${formData.marketSize.toStringAsFixed(0)}M'),
            _buildSummaryRow('Funding:', '\$${formData.funding.toStringAsFixed(0)}'),
            _buildSummaryRow('Team Experience:', '${formData.teamExperience} yrs'),
            _buildSummaryRow('Industry:', formData.industry),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final bool isSuccess = prediction == 'Success';
    final Color resultColor = isSuccess ? Colors.green.shade400 : Colors.red.shade400;
    final IconData resultIcon = isSuccess ? Icons.check_circle_outline : Icons.highlight_off;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Prediction Result'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(resultIcon, size: 120, color: resultColor),
            const SizedBox(height: 24),
            Text(
              prediction,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: resultColor),
            ),
            const SizedBox(height: 8),
            const Text(
              'Based on the provided data, the model predicts this outcome.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 48),
            
            
            _buildSummaryCard(context),
            const Spacer(),

            
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade800,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              child: const Text('Predict Again'),
            ),
          ],
        ),
      ),
    );
  }
}