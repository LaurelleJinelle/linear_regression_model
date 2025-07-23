

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
  final List<String> _industries = ['Tech', 'Healthcare', 'Finance', 'E-commerce', 'Education', 'Entertainment'];

  void _handlePredict() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      final predictionResult = PredictionService.getPrediction(
        marketSize: _formData.marketSize,
        funding: _formData.funding,
        teamExperience: _formData.teamExperience,
        industry: _formData.industry,
      );

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            prediction: predictionResult,
            formData: _formData,
          ),
        ),
      );
    }
  }


  TextFormField _buildTextFormField({required String label, required IconData icon, required String initialValue, required FormFieldSetter<String> onSaved}) {
    return TextFormField(
      initialValue: initialValue,
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
        if (double.tryParse(value) == null) {
          return 'Please enter a valid number';
        }
        return null;
      },
    );
  }
  
  
  DropdownButtonFormField<String> _buildDropdown() {
    return DropdownButtonFormField(
      value: _formData.industry,
      decoration: InputDecoration(
        labelText: 'Industry',
        prefixIcon: const Icon(Icons.factory),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
      ),
      items: _industries.map((String industry) {
        return DropdownMenuItem<String>(
          value: industry,
          child: Text(industry),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          _formData.industry = newValue!;
        });
      },
      onSaved: (value) => _formData.industry = value!,
    );
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
                  label: 'Market Size (in millions USD)',
                  icon: Icons.bar_chart,
                  initialValue: _formData.marketSize.toString(),
                  onSaved: (value) => _formData.marketSize = double.tryParse(value!) ?? 0,
                ),
                const SizedBox(height: 20),
                _buildTextFormField(
                  label: 'Funding Amount (USD)',
                  icon: Icons.attach_money,
                  initialValue: _formData.funding.toString(),
                  onSaved: (value) => _formData.funding = double.tryParse(value!) ?? 0,
                ),
                const SizedBox(height: 20),
                _buildTextFormField(
                  label: 'Total Team Experience (years)',
                  icon: Icons.people,
                  initialValue: _formData.teamExperience.toString(),
                  onSaved: (value) => _formData.teamExperience = int.tryParse(value!) ?? 0,
                ),
                const SizedBox(height: 20),
                _buildDropdown(),
                const SizedBox(height: 20),
                const SizedBox(height: 40),

                // Predict Button
                ElevatedButton.icon(
                  icon: const Icon(Icons.online_prediction),
                  label: const Text('Predict'),
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
}