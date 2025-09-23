import 'package:flutter/material.dart';

// --- PANTALLA 4: LISTAS ---
class ListsScreen extends StatelessWidget {
  const ListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Generamos una lista de 20 elementos para la demostración.
    final List<String> items = List<String>.generate(20, (i) => 'Elemento ${i + 1}');

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Demostración de Listas',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'ListView es un widget para mostrar una lista de elementos desplazable. Es altamente eficiente, especialmente con ListView.builder.',
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index]),
                  leading: const Icon(Icons.label),
                  onTap: () {
                    // Muestra un SnackBar al tocar un elemento.
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Tocaste ${items[index]}'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
