# GlazeNavBar Example App

A comprehensive example demonstrating all features of the **GlazeNavBar** package.

## 🎯 Features Demonstrated

### 1. **Basic Navigation**

- Simple glassmorphic navigation bar
- Icons with labels
- Smooth animations between tabs
- Floating button effect

### 2. **Gradient Support**

- Custom gradient backgrounds
- Multiple gradient presets
- Gradient on both bar and floating button
- Interactive gradient selection

### 3. **Badges**

- Count badges (numeric indicators)
- Dot badges (simple notification dots)
- Custom badge colors
- Active/inactive badge states

### 4. **Theme Support**

- Light and dark mode
- Automatic theme switching
- `GlazeNavBarThemeData.light()` and `GlazeNavBarThemeData.dark()`
- System theme mode support

### 5. **Customization**

- Interactive sliders for real-time customization
- Glass blur adjustment
- Glass opacity control
- Border width and color
- Height adjustment
- Animation settings

### 6. **Programmatic Navigation**

- Navigate using `GlobalKey<GlazeNavBarState>`
- `setPage()` method demonstration

## 🚀 Running the Example

```bash
cd example
flutter pub get
flutter run
```

## 📱 Screenshots

The app includes:

- **Home Page**: Overview of all features with theme toggle
- **Gradient Demo**: Interactive gradient selection
- **Customization Demo**: Real-time property adjustments with sliders

## 🎨 Code Examples

### Basic Usage

```dart
GlazeNavBar(
  items: [
    GlazeNavBarItem(child: Icon(Icons.home), label: 'Home'),
    GlazeNavBarItem(child: Icon(Icons.search), label: 'Search'),
  ],
  onTap: (index) => setState(() => _currentIndex = index),
)
```

### With Gradients

```dart
GlazeNavBar(
  gradient: LinearGradient(
    colors: [Color(0xFF6B4CE6), Color(0xFFAE00E9)],
  ),
  buttonGradient: LinearGradient(
    colors: [Color(0xFF6B4CE6), Color(0xFFAE00E9)],
  ),
  items: [...],
)
```

### With Badges

```dart
GlazeNavBarItem(
  child: Icon(Icons.notifications),
  label: 'Notifications',
  badgeCount: 5,
  badgeColor: Colors.red,
  activeBadgeColor: Colors.orange,
)
```

## 📚 Learn More

Check out the [main package README](../README.md) for full documentation.

## 📄 License

MIT License - see the [LICENSE](../LICENSE) file for details.
