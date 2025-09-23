import 'package:flutter/material.dart';

// --- GESTOR DE ESTADO (STATE MANAGEMENT) ---
// Usaremos un ChangeNotifier para notificar a los widgets cuando el texto cambie.
// Esta clase contendrá el estado que queremos compartir entre pantallas.
class TextFieldState with ChangeNotifier {
  String _displayText = '';

  String get displayText => _displayText;

  void updateText(String newText) {
    _displayText = newText;
    // Notifica a todos los widgets que están escuchando a este provider.
    notifyListeners();
  }
}
