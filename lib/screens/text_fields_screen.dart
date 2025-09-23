import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/text_field_state.dart';

// --- PANTALLA 1: TEXT FIELDS ---
class TextFieldsScreen extends StatefulWidget {
  const TextFieldsScreen({super.key});

  @override
  State<TextFieldsScreen> createState() => _TextFieldsScreenState();
}

class _TextFieldsScreenState extends State<TextFieldsScreen> {
  // Controlador para el TextField
  final TextEditingController _controller = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    // Escuchamos los cambios en el controlador para actualizar el estado global.
    _controller.addListener(() {
      // Usamos 'listen: false' porque solo queremos llamar al método,
      // no necesitamos que este widget se reconstruya cuando cambie el estado.
      Provider.of<TextFieldState>(context, listen: false)
          .updateText(_controller.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Demostración de TextFields',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Un TextField permite a los usuarios introducir texto. Es el equivalente a un EditText en desarrollo nativo de Android.',
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Escribe algo aquí...',
              hintText: 'El texto aparecerá abajo y en la Pantalla 5',
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Texto en tiempo real en esta pantalla:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          // Usamos un Consumer para reconstruir solo este widget Text cuando el estado cambie.
          Consumer<TextFieldState>(
            builder: (context, textFieldState, child) {
              return Text(
                textFieldState.displayText.isEmpty 
                    ? 'Aún no has escrito nada.' 
                    : textFieldState.displayText,
                style: const TextStyle(fontSize: 18, color: Colors.blue),
              );
            },
          ),
        ],
      ),
    );
  }
}
