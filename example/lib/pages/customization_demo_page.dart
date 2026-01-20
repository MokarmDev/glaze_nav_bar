import 'package:flutter/material.dart';
import 'package:glaze_nav_bar/glaze_nav_bar.dart';

/// Interactive customization demo with sliders
class CustomizationDemoPage extends StatefulWidget {
  const CustomizationDemoPage({super.key});

  @override
  State<CustomizationDemoPage> createState() => _CustomizationDemoPageState();
}

class _CustomizationDemoPageState extends State<CustomizationDemoPage> {
  int _currentIndex = 0;
  double _glassBlur = 20.0;
  double _glassOpacity = 0.25;
  double _glassBorderWidth = 1.5;
  double _buttonBorderWidth = 3.0;
  double _height = 75.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customization Demo')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Customize Your Nav Bar',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          _buildSlider(
            'Glass Blur',
            _glassBlur,
            0,
            50,
            (value) => setState(() => _glassBlur = value),
          ),
          _buildSlider(
            'Glass Opacity',
            _glassOpacity,
            0,
            1,
            (value) => setState(() => _glassOpacity = value),
          ),
          _buildSlider(
            'Glass Border Width',
            _glassBorderWidth,
            0,
            5,
            (value) => setState(() => _glassBorderWidth = value),
          ),
          _buildSlider(
            'Button Border Width',
            _buttonBorderWidth,
            0,
            8,
            (value) => setState(() => _buttonBorderWidth = value),
          ),
          _buildSlider(
            'Height',
            _height,
            60,
            100,
            (value) => setState(() => _height = value),
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Current Values:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _buildValueDisplay(
                    'Glass Blur',
                    _glassBlur.toStringAsFixed(1),
                  ),
                  _buildValueDisplay(
                    'Glass Opacity',
                    _glassOpacity.toStringAsFixed(2),
                  ),
                  _buildValueDisplay(
                    'Glass Border Width',
                    _glassBorderWidth.toStringAsFixed(1),
                  ),
                  _buildValueDisplay(
                    'Button Border Width',
                    _buttonBorderWidth.toStringAsFixed(1),
                  ),
                  _buildValueDisplay('Height', _height.toStringAsFixed(0)),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GlazeNavBar(
        index: _currentIndex,
        glassBlur: _glassBlur,
        glassOpacity: _glassOpacity,
        glassBorderWidth: _glassBorderWidth,
        buttonBorderWidth: _buttonBorderWidth,
        height: _height,
        items: [
          GlazeNavBarItem(
            child: const Icon(Icons.home, color: Colors.white),
            label: 'Home',
          ),
          GlazeNavBarItem(
            child: const Icon(Icons.settings, color: Colors.white),
            label: 'Settings',
          ),
          GlazeNavBarItem(
            child: const Icon(Icons.person, color: Colors.white),
            label: 'Profile',
          ),
        ],
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }

  Widget _buildSlider(
    String label,
    double value,
    double min,
    double max,
    ValueChanged<double> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: 50,
          label: value.toStringAsFixed(2),
          onChanged: onChanged,
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildValueDisplay(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
