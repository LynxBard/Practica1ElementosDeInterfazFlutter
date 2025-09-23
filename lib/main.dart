import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/text_field_state.dart';
import 'screens/main_screen.dart';

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
