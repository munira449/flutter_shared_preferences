import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;
  String _buttonText = "Dark"; // Initial button text

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString('theme_preference') ?? 'light';
    setState(() {
      _themeMode = theme == 'dark' ? ThemeMode.dark : ThemeMode.light;
      _buttonText = theme == 'dark' ? "Light" : "Dark"; // Set initial button text
    });
  }

  Future<void> _saveThemePreference(String theme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_preference', theme);
  }

  void _toggleTheme() {
    setState(() {
      if (_themeMode == ThemeMode.light) {
        _themeMode = ThemeMode.dark;
        _buttonText = "Light"; // Change text to Light
        _saveThemePreference('dark');
      } else {
        _themeMode = ThemeMode.light;
        _buttonText = "Dark"; // Change text to Dark
        _saveThemePreference('light');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Theme Preference App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Theme Preference App'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: _toggleTheme,
            child: Text(_buttonText), // Display button text based on theme
          ),
        ),
      ),
    );
  }
}
