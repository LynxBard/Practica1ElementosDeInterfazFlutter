import 'package:flutter/material.dart';
import 'text_fields_screen.dart';
import 'buttons_screen.dart';
import 'selection_screen.dart';
import 'lists_screen.dart';
import 'info_screen.dart';

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
