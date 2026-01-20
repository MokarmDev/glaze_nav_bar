import 'package:flutter/material.dart';
import 'package:glaze_nav_bar/glaze_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GlazeNavBar Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        extensions: [GlazeNavBarThemeData.light()],
        colorScheme: ColorScheme.light(
          primary: Colors.blue,
          secondary: Colors.blueAccent,
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        extensions: [GlazeNavBarThemeData.dark()],
        colorScheme: ColorScheme.dark(
          primary: Colors.blue,
          secondary: Colors.blueAccent,
        ),
      ),
      themeMode: _themeMode,
      home: HomePage(onToggleTheme: _toggleTheme),
    );
  }
}

class HomePage extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const HomePage({super.key, required this.onToggleTheme});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final GlobalKey<GlazeNavBarState> _navBarKey = GlobalKey();

  final List<DemoPage> _pages = [
    DemoPage(
      title: 'Basic Demo',
      icon: Icons.home,
      description: 'Simple navigation with icons and labels',
      color: Colors.blue,
    ),
    DemoPage(
      title: 'Gradients',
      icon: Icons.gradient,
      description: 'Custom gradient backgrounds',
      color: Colors.purple,
    ),
    DemoPage(
      title: 'Badges',
      icon: Icons.notifications,
      description: 'Count and dot badges',
      color: Colors.orange,
    ),
    DemoPage(
      title: 'Customization',
      icon: Icons.tune,
      description: 'Customize blur, opacity, borders',
      color: Colors.green,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDark ? Colors.white : const Color(0xFF1E3A5F);

    return Scaffold(
      appBar: AppBar(
        title: const Text('🔮 GlazeNavBar Examples'),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.onToggleTheme,
            tooltip: 'Toggle Theme',
          ),
        ],
      ),
      body: _buildPageContent(_pages[_currentIndex]),
      extendBody: true,
      bottomNavigationBar: GlazeNavBar(
        key: _navBarKey,
        index: _currentIndex,
        backgroundColor: Colors.transparent,
        items: [
          GlazeNavBarItem(
            child: Icon(Icons.home, color: iconColor),
            label: 'Basic',
          ),
          GlazeNavBarItem(
            child: Icon(Icons.gradient, color: iconColor),
            label: 'Gradients',
            badgeCount: 3,
            badgeColor: Colors.red,
            activeBadgeColor: Colors.orange,
          ),
          GlazeNavBarItem(
            child: Icon(Icons.notifications, color: iconColor),
            label: 'Badges',
            showBadge: true,
            badgeColor: Colors.red,
          ),
          GlazeNavBarItem(
            child: Icon(Icons.tune, color: iconColor),
            label: 'Custom',
          ),
        ],
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }

  Widget _buildPageContent(DemoPage page) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            page.color.withValues(alpha: 0.1),
            page.color.withValues(alpha: 0.05),
          ],
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(page.icon, size: 100, color: page.color),
              const SizedBox(height: 24),
              Text(
                page.title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: page.color,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                page.description,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.color?.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 48),
              _buildDemoContent(page),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDemoContent(DemoPage page) {
    switch (_currentIndex) {
      case 0:
        return _buildBasicDemo();
      case 1:
        return _buildGradientDemo();
      case 2:
        return _buildBadgesDemo();
      case 3:
        return _buildCustomizationDemo();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildBasicDemo() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Features:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildFeatureItem('✓ Glassmorphism effect'),
            _buildFeatureItem('✓ Smooth animations'),
            _buildFeatureItem('✓ Icon labels'),
            _buildFeatureItem('✓ Floating button'),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => _navBarKey.currentState?.setPage(1),
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Go to Gradients'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientDemo() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Gradient Examples:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildGradientPreview('Purple Gradient', [
              const Color(0xFF6B4CE6),
              const Color(0xFFAE00E9),
            ]),
            const SizedBox(height: 8),
            _buildGradientPreview('Ocean Gradient', [
              const Color(0xFF00E6FF),
              const Color(0xFF0066FF),
            ]),
            const SizedBox(height: 8),
            _buildGradientPreview('Sunset Gradient', [
              const Color(0xFFFF6B6B),
              const Color(0xFFFFD93D),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientPreview(String name, List<Color> colors) {
    return Row(
      children: [
        Container(
          width: 50,
          height: 30,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: colors),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(width: 12),
        Text(name),
      ],
    );
  }

  Widget _buildBadgesDemo() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Badge Types:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildFeatureItem('🔢 Count badges (numeric)'),
            _buildFeatureItem('⚫ Dot badges'),
            _buildFeatureItem('🎨 Custom colors'),
            _buildFeatureItem('✨ Active/inactive states'),
            const SizedBox(height: 16),
            const Text(
              'Notice the badge on the Gradients tab (count: 3) and this tab (dot badge)!',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomizationDemo() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Customizable Properties:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildFeatureItem('🌫️ Glass blur intensity'),
            _buildFeatureItem('👻 Glass opacity'),
            _buildFeatureItem('🖼️ Border radius'),
            _buildFeatureItem('📏 Border width & color'),
            _buildFeatureItem('📐 Height adjustment'),
            _buildFeatureItem('⏱️ Animation duration & curve'),
            const SizedBox(height: 16),
            const Text(
              'All properties can be customized via GlazeNavBarThemeData or widget parameters!',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text('  $text'),
    );
  }
}

class DemoPage {
  final String title;
  final IconData icon;
  final String description;
  final Color color;

  DemoPage({
    required this.title,
    required this.icon,
    required this.description,
    required this.color,
  });
}
