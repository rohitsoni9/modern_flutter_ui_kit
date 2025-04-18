<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# Modern Flutter UI Kit

A modern and customizable Flutter UI kit that provides beautiful components and themes for building stunning applications.

## Features

- 🎨 Modern and customizable theme system
- 🌓 Light and dark theme support
- 🎯 Reusable UI components
- 📱 Responsive design
- 🚀 Easy to use and customize

## Screenshots

<div align="center">
  <img src="assets/screenshots/buttons.png" alt="Buttons" width="300"/>
  <img src="assets/screenshots/text_fields.png" alt="Text Fields" width="300"/>
  <img src="assets/screenshots/cards.png" alt="Cards" width="300"/>
  <img src="assets/screenshots/dialogs.png" alt="Dialogs" width="300"/>
  <img src="assets/screenshots/loading.png" alt="Loading States" width="300"/>
</div>

## Components

### Buttons

Customizable buttons with different variants:

- Primary
- Secondary
- Outlined
- Text
- Loading state
- With icons

### Text Fields

Enhanced text fields with:

- Labels and hints
- Error states
- Helper text
- Custom styling
- Validation support

## Getting Started

1. Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  modern_flutter_ui_kit: ^0.0.1
```

2. Import the package:

```dart
import 'package:modern_flutter_ui_kit/modern_flutter_ui_kit.dart';
```

3. Wrap your app with the theme provider:

```dart
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}
```

4. Use the components in your app:

```dart
CustomButton(
  text: 'Click me',
  onPressed: () {
    // Handle button press
  },
  variant: ButtonVariant.primary,
);

CustomTextField(
  label: 'Email',
  hint: 'Enter your email',
  controller: emailController,
  keyboardType: TextInputType.emailAddress,
);
```

## Theme Customization

The UI kit comes with a default theme that you can customize:

```dart
ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.light(
    primary: Colors.blue,
    secondary: Colors.green,
    // ... other colors
  ),
  // ... other theme properties
);
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
