import 'package:flutter/material.dart';
import 'settings_controller.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends StatelessWidget {
  const SettingsView({super.key, required this.controller});

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Theme Card
              GestureDetector(
                onTap: () {
                  // No direct navigation; theme change is handled by dropdown
                },
                child: SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Appearance',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text('Choose your app theme'),
                          const SizedBox(height: 10),
                          DropdownButton<ThemeMode>(
                            value: controller.themeMode,
                            onChanged: controller.updateThemeMode,
                            items: const [
                              DropdownMenuItem(
                                value: ThemeMode.system,
                                child: Text('System Theme'),
                              ),
                              DropdownMenuItem(
                                value: ThemeMode.light,
                                child: Text('Light Theme'),
                              ),
                              DropdownMenuItem(
                                value: ThemeMode.dark,
                                child: Text('Dark Theme'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
