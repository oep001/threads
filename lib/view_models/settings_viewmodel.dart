import 'package:flutter/material.dart';
import 'package:threads/data/settings_repository.dart';

import '../models/settings_model.dart';

class SettingsViewModel extends ChangeNotifier {
  final SettingsRepository _repository = SettingsRepository();
  SettingsModel _settings = SettingsModel(darkMode: false);

  SettingsModel get settings => _settings;
  bool get darkMode => _settings.darkMode;

  SettingsViewModel() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final isDarkMode = await _repository.isDarkMode();
    _settings = SettingsModel(darkMode: isDarkMode);
    notifyListeners();
  }

  Future<void> setDarkMode(bool darkMode) async {
    await _repository.setDarkMode(darkMode);
    _settings = _settings.copyWith(darkMode: darkMode);
    notifyListeners();
  }
}
