import 'package:flutter/material.dart';
import '../models/startup_data.dart';
import '../services/prediction_service.dart';
import 'result_screen.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formData = StartupData();
  bool _isLoading = false;

  void _handlePredict() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      setState(() {
        _isLoading = true;
      });

      try {
        final predictionResult = await PredictionService.getPrediction(_formData);

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              predictionResult: predictionResult,
              formData: _formData,
            ),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                const Center(
                  child: Text(
                    'Startup Predictor',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 8),
                const Center(
                  child: Text(
                    'Enter startup details to forecast its success.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 40),

                // Form Fields
                _buildTextFormField(
                  label: 'Number of Team Members',
                  icon: Icons.people_outline,
                  onSaved: (value) => _formData.relationships = int.tryParse(value!) ?? 0,
                ),
                const SizedBox(height: 20),
                _buildTextFormField(
                  label: 'Total Funding (USD)',
                  icon: Icons.attach_money,
                  onSaved: (value) => _formData.funding_total_usd = int.tryParse(value!) ?? 0,
                ),
                const SizedBox(height: 20),
                _buildTextFormField(
                  label: 'Number of Funding Rounds',
                  icon: Icons.replay_circle_filled_outlined,
                  onSaved: (value) => _formData.funding_rounds = int.tryParse(value!) ?? 0,
                ),
                const SizedBox(height: 24),
                _buildFundingRoundSwitch(
                  label: 'Has Series A Funding?',
                  value: _formData.has_roundA == 1,
                  onChanged: (newValue) {
                    setState(() => _formData.has_roundA = newValue ? 1 : 0);
                  },
                ),
                _buildFundingRoundSwitch(
                  label: 'Has Series B Funding?',
                  value: _formData.has_roundB == 1,
                  onChanged: (newValue) {
                    setState(() => _formData.has_roundB = newValue ? 1 : 0);
                  },
                ),
                _buildFundingRoundSwitch(
                  label: 'Has Series C Funding?',
                  value: _formData.has_roundC == 1,
                  onChanged: (newValue) {
                    setState(() => _formData.has_roundC = newValue ? 1 : 0);
                  },
                ),
                _buildFundingRoundSwitch(
                  label: 'Has Series D Funding?',
                  value: _formData.has_roundD == 1,
                  onChanged: (newValue) {
                    setState(() => _formData.has_roundD = newValue ? 1 : 0);
                  },
                ),
                const SizedBox(height: 40),

                // Predict Button
                if (_isLoading)
                  const Center(child: CircularProgressIndicator())
                else
                  ElevatedButton.icon(
                    icon: const Icon(Icons.online_prediction),
                    label: const Text('Predict!'),
                    onPressed: _handlePredict,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
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
        ),
      ),
    );
  }

  TextFormField _buildTextFormField({required String label, required IconData icon, required FormFieldSetter<String> onSaved}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
      ),
      keyboardType: TextInputType.number,
      onSaved: onSaved,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a value';
        }
        if (int.tryParse(value) == null) {
          return 'Please enter a valid number';
        }
        return null;
      },
    );
  }
  
  Widget _buildFundingRoundSwitch({required String label, required bool value, required ValueChanged<bool> onChanged}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
