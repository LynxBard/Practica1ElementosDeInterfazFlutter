// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

// --- PUNTO DE ENTRADA DE LA APLICACIÓN ---
void main() {
  // Envolvemos la aplicación con ChangeNotifierProvider.
  // Esto hace que la instancia de 'TextFieldState' esté disponible
  // para cualquier widget descendiente en el árbol de widgets.
  runApp(
    ChangeNotifierProvider(
      create: (context) => TextFieldState(),
      child: const WidgetGalleryApp(),
    ),
  );
}

class WidgetGalleryApp extends StatelessWidget {
  const WidgetGalleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Galería de Widgets',
      // --- TEMA CORREGIDO ---
      // 'colorSchemeSeed' es la forma moderna (Material 3) de definir el tema.
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: Colors.indigo,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.indigo,
      ),
      themeMode: ThemeMode.system,
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// --- PANTALLA PRINCIPAL CON NAVEGACIÓN ---
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Lista de las cinco pantallas que se mostrarán.
  static const List<Widget> _widgetOptions = <Widget>[
    TextFieldsScreen(),
    ButtonsScreen(),
    SelectionScreen(),
    ListsScreen(),
    InfoScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galería de Widgets de UI'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Text Fields',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.touch_app),
            label: 'Botones',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            label: 'Selección',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Listas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'Info',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        showUnselectedLabels: true,
      ),
    );
  }
}

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

