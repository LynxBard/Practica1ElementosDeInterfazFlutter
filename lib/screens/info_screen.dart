import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/text_field_state.dart';

// --- PANTALLA 5: ELEMENTOS DE INFORMACIÓN ---
class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  bool _isLoading = false;

  void _showProgressIndicator() {
    setState(() {
      _isLoading = true;
    });
    // Oculta el indicador de progreso después de 2 segundos.
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
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
            'Demostración de Elementos de Información',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Estos widgets se usan para mostrar información al usuario, como texto, imágenes o indicadores de progreso.',
          ),
          const SizedBox(height: 24),
          // Demostración de Text
          const Text(
            'Esto es un widget Text con estilo.',
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
          ),
          const SizedBox(height: 24),
          // Demostración de Image
          const Center(
            child: Icon(
              Icons.flutter_dash,
              size: 80,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 24),
          // Demostración de CircularProgressIndicator
          Center(
            child: Column(
              children: [
                if (_isLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: _showProgressIndicator,
                    child: const Text('Mostrar Indicador de Progreso (2s)'),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          const Divider(),
          const SizedBox(height: 16),
          // --- DEMOSTRACIÓN DE ESTADO COMPARTIDO ---
          const Text(
            'Texto compartido desde la Pantalla 1:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 8),
          // Usamos un Consumer para escuchar los cambios del TextFieldState.
          // Este widget se reconstruirá automáticamente cuando el texto cambie.
          Consumer<TextFieldState>(
            builder: (context, textFieldState, child) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  textFieldState.displayText.isEmpty
                      ? 'Ve a la Pantalla 1 y escribe algo.'
                      : textFieldState.displayText,
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
