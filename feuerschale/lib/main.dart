import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/settings_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void _setDarkMode(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = _themeMode == ThemeMode.dark;

    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: RootPage(isDark: isDark, onThemeChanged: _setDarkMode),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
  });

  final bool isDark;
  final ValueChanged<bool> onThemeChanged;

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const HomePage(),
      SettingsPage(isDark: widget.isDark, onChanged: widget.onThemeChanged),
    ];

    return Scaffold(
      body: pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
