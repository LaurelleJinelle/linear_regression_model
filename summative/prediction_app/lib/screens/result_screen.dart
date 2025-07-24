import 'package:flutter/material.dart';
import '../models/startup_data.dart';

class ResultScreen extends StatelessWidget {
  final Map<String, dynamic> predictionResult;
  final StartupData formData;

  const ResultScreen({super.key, required this.predictionResult, required this.formData});

  @override
  Widget build(BuildContext context) {
    final int predictedStatus = predictionResult['predicted_status'];
    final double rawScore = predictionResult['raw_score'];
    
    final bool isSuccess = predictedStatus == 1;
    final String predictionText = isSuccess ? 'Success' : 'Failure';
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
              predictionText,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: resultColor),
            ),
            const SizedBox(height: 8),
            Text(
              'Raw Prediction Score: ${rawScore.toStringAsFixed(3)}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 48),
      
            _buildSummaryCard(context),
            const Spacer(),

            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Predict Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade800,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }


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
            _buildSummaryRow('Team Members:', formData.relationships.toString()),
            _buildSummaryRow('Total Funding:', '\$${formData.funding_total_usd}'),
            _buildSummaryRow('Funding Rounds:', formData.funding_rounds.toString()),
            _buildSummaryRow('Has Series A:', formData.has_roundA == 1 ? 'Yes' : 'No'),
            _buildSummaryRow('Has Series B:', formData.has_roundB == 1 ? 'Yes' : 'No'),
            _buildSummaryRow('Has Series C:', formData.has_roundC == 1 ? 'Yes' : 'No'),
            _buildSummaryRow('Has Series D:', formData.has_roundD == 1 ? 'Yes' : 'No'),
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
}
