import 'package:flutter/material.dart';

// --- PANTALLA 2: BOTONES ---
class ButtonsScreen extends StatefulWidget {
  const ButtonsScreen({super.key});

  @override
  State<ButtonsScreen> createState() => _ButtonsScreenState();
}

class _ButtonsScreenState extends State<ButtonsScreen> {
  String _lastButtonPressed = 'Ninguno';

  void _updateButtonMessage(String buttonName) {
    setState(() {
      _lastButtonPressed = buttonName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Demostración de Botones',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Los botones permiten a los usuarios realizar acciones con un solo toque. Flutter ofrece varios tipos de botones con diferentes estilos.',
          ),
          const SizedBox(height: 24),
          Center(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () => _updateButtonMessage('ElevatedButton'),
                  child: const Text('ElevatedButton'),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => _updateButtonMessage('TextButton'),
                  child: const Text('TextButton'),
                ),
                const SizedBox(height: 16),
                IconButton(
                  onPressed: () => _updateButtonMessage('IconButton'),
                  icon: const Icon(Icons.thumb_up),
                  tooltip: 'IconButton',
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Último botón presionado:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              _lastButtonPressed,
              style: const TextStyle(fontSize: 18, color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}
