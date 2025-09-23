import 'package:flutter/material.dart';

// --- PANTALLA 3: ELEMENTOS DE SELECCIÓN ---
class SelectionScreen extends StatefulWidget {
  const SelectionScreen({super.key});

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  bool _isChecked = false;
  bool _isSwitched = false;
  int? _radioValue = 1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Demostración de Elementos de Selección',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Estos widgets permiten a los usuarios seleccionar opciones. Se usan para activar/desactivar ajustes o elegir una opción de un conjunto.',
          ),
          const SizedBox(height: 24),
          // Checkbox
          Row(
            children: [
              Checkbox(
                value: _isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    _isChecked = value!;
                  });
                },
              ),
              const Text('Checkbox'),
            ],
          ),
          // Switch
          Row(
            children: [
              Switch(
                value: _isSwitched,
                onChanged: (bool value) {
                  setState(() {
                    _isSwitched = value;
                  });
                },
              ),
              const Text('Switch'),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Grupo de Radio Buttons:', style: TextStyle(fontWeight: FontWeight.w500)),
          // Radio Buttons
          Row(
            children: [
              Radio<int>(
                value: 1,
                groupValue: _radioValue,
                onChanged: (int? value) {
                  setState(() {
                    _radioValue = value;
                  });
                },
              ),
              const Text('Opción 1'),
            ],
          ),
          Row(
            children: [
              Radio<int>(
                value: 2,
                groupValue: _radioValue,
                onChanged: (int? value) {
                  setState(() {
                    _radioValue = value;
                  });
                },
              ),
              const Text('Opción 2'),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Estado actual de los controles:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Checkbox: ${_isChecked ? "Activado" : "Desactivado"}\n'
            'Switch: ${_isSwitched ? "Encendido" : "Apagado"}\n'
            'Opción seleccionada: $_radioValue',
            style: const TextStyle(fontSize: 16, color: Colors.purple),
          ),
        ],
      ),
    );
  }
}
