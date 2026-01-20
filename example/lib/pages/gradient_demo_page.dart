import 'package:flutter/material.dart';
import 'package:glaze_nav_bar/glaze_nav_bar.dart';

/// Advanced gradient demo with multiple preset options
class GradientDemoPage extends StatefulWidget {
  const GradientDemoPage({super.key});

  @override
  State<GradientDemoPage> createState() => _GradientDemoPageState();
}

class _GradientDemoPageState extends State<GradientDemoPage> {
  int _currentIndex = 0;
  int _selectedGradient = 0;

  final List<GradientPreset> _gradients = [
    GradientPreset(
      name: 'Purple Dream',
      colors: [const Color(0xFF6B4CE6), const Color(0xFFAE00E9)],
    ),
    GradientPreset(
      name: 'Ocean Blue',
      colors: [const Color(0xFF00E6FF), const Color(0xFF0066FF)],
    ),
    GradientPreset(
      name: 'Sunset',
      colors: [const Color(0xFFFF6B6B), const Color(0xFFFFD93D)],
    ),
    GradientPreset(
      name: 'Forest',
      colors: [const Color(0xFF11998E), const Color(0xFF38EF7D)],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final currentGradient = _gradients[_selectedGradient];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gradient Demo'),
        backgroundColor: currentGradient.colors.first,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              currentGradient.colors.first.withValues(alpha: 0.2),
              currentGradient.colors.last.withValues(alpha: 0.1),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Select a Gradient:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: List.generate(_gradients.length, (index) {
                  return GestureDetector(
                    onTap: () => setState(() => _selectedGradient = index),
                    child: Container(
                      width: 120,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: _gradients[index].colors,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _selectedGradient == index
                              ? Colors.white
                              : Colors.transparent,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          _gradients[index].name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GlazeNavBar(
        index: _currentIndex,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: currentGradient.colors,
        ),
        buttonGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: currentGradient.colors,
        ),
        items: [
          GlazeNavBarItem(
            child: const Icon(Icons.home, color: Colors.white),
            label: 'Home',
          ),
          GlazeNavBarItem(
            child: const Icon(Icons.palette, color: Colors.white),
            label: 'Colors',
          ),
          GlazeNavBarItem(
            child: const Icon(Icons.star, color: Colors.white),
            label: 'Favorites',
          ),
        ],
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}

class GradientPreset {
  final String name;
  final List<Color> colors;

  GradientPreset({required this.name, required this.colors});
}
