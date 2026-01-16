# 🔮 Glaze Nav Bar

[![pub package](https://img.shields.io/pub/v/glaze_nav_bar.svg)](https://pub.dev/packages/glaze_nav_bar)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

A stunning glassmorphic navigation bar with gradient support, smooth animations, and modern design for Flutter.

> **✨ Glaze your app with beautiful navigation!**

## Features

- 🔮 **Glassmorphism** - Beautiful frosted glass effect
- 🎨 **Gradient Support** - Customizable gradient backgrounds
- 🏷️ **Labels** - Optional text labels under icons
- 💫 **Smooth Animations** - Fluid transitions between items
- 📱 **Platform Aware** - Optimized for iOS and Android

---

## Installation

```yaml
dependencies:
  glaze_nav_bar: ^1.0.0
```

---

## Quick Start

```dart
import 'package:glaze_nav_bar/glaze_nav_bar.dart';

Scaffold(
  bottomNavigationBar: GlazeNavBar(
    items: [
      GlazeNavBarItem(child: Icon(Icons.home), label: 'Home'),
      GlazeNavBarItem(child: Icon(Icons.search), label: 'Search'),
      GlazeNavBarItem(child: Icon(Icons.person), label: 'Profile'),
    ],
    onTap: (index) {
      // Handle navigation
    },
  ),
)
```

---

## Gradient Example

```dart
GlazeNavBar(
  items: [
    GlazeNavBarItem(child: Icon(Icons.home), label: 'Home'),
    GlazeNavBarItem(child: Icon(Icons.search), label: 'Search'),
    GlazeNavBarItem(child: Icon(Icons.chat), label: 'Chat'),
    GlazeNavBarItem(child: Icon(Icons.person), label: 'Profile'),
  ],
  gradient: LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [Color(0xFF00E6FF), Color(0xFFAE00E9)],
  ),
  buttonGradient: LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [Color(0xFF00E6FF), Color(0xFFAE00E9)],
  ),
  onTap: (index) => setState(() => _currentIndex = index),
)
```

---

## Attributes

### GlazeNavBar

| Attribute               | Description                             | Default                         |
| ----------------------- | --------------------------------------- | ------------------------------- |
| `items`                 | List of GlazeNavBarItem                 | **Required**                    |
| `index`                 | Current active index                    | `0`                             |
| `color`                 | Color of NavigationBar                  | `Colors.white`                  |
| `buttonBackgroundColor` | Background color of floating button     | Same as `color`                 |
| `backgroundColor`       | Color of NavigationBar's background     | `Colors.transparent`            |
| `gradient`              | Gradient background (overrides `color`) | `null`                          |
| `buttonGradient`        | Gradient for floating button            | `null`                          |
| `onTap`                 | Callback when item is tapped            | `null`                          |
| `letIndexChange`        | Function to control if index can change | `(_) => true`                   |
| `animationCurve`        | Animation curve                         | `Curves.easeOut`                |
| `animationDuration`     | Animation duration                      | `Duration(milliseconds: 600)`   |
| `height`                | Height of NavigationBar                 | `70.0` (Android) / `80.0` (iOS) |
| `maxWidth`              | Max width of NavigationBar              | `null`                          |
| `iconPadding`           | Padding around the floating icon        | `12.0`                          |
| `glassBlur`             | Blur intensity for glass effect         | `20`                            |
| `glassOpacity`          | Opacity of glass background             | `0.2`                           |
| `glassBorderRadius`     | Border radius for glass effect          | `0`                             |
| `glassBorderWidth`      | Border width for glass effect           | `1.5`                           |
| `glassBorderColor`      | Border color for glass effect           | `Colors.white`                  |
| `buttonBorderColor`     | Border color for floating button        | `Colors.white`                  |
| `buttonBorderWidth`     | Border width for floating button        | `3.0`                           |

### GlazeNavBarItem

| Attribute    | Description         | Default      |
| ------------ | ------------------- | ------------ |
| `child`      | Icon widget         | **Required** |
| `label`      | Text label          | `null`       |
| `labelStyle` | TextStyle for label | `null`       |

---

## Programmatic Navigation

```dart
// Create a GlobalKey
GlobalKey<GlazeNavBarState> _navBarKey = GlobalKey();

// Use in widget
GlazeNavBar(
  key: _navBarKey,
  items: [...],
  onTap: (index) => setState(() => _page = index),
)

// Navigate programmatically
ElevatedButton(
  onPressed: () => _navBarKey.currentState?.setPage(1),
  child: Text('Go to page 1'),
)
```

---

## License

MIT License - see the [LICENSE](LICENSE) file for details.

---

## Author

Created with ❤️ by [MokarmDev](https://github.com/MokarmDev)
