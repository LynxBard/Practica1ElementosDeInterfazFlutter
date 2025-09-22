# Práctica 1: "Instalación y Funcionamiento de los Entornos Móviles"
## Ejercicio 2: Transiciones entre Activities y Fragments (Version en Flutter)

Este proyecto es una aplicación móvil desarrollada en Flutter que funciona como una galería interactiva y educativa de los widgets de UI más comunes en el desarrollo de aplicaciones. El objetivo principal es ofrecer a los desarrolladores, especialmente a aquellos que están aprendiendo Flutter, un entorno práctico para ver, probar y entender el funcionamiento de cada componente.

La aplicación está estructurada en cinco secciones principales, cada una dedicada a una categoría de widgets:

1.  **Text Fields:** Demostración de campos de entrada de texto.
2.  **Botones:** Interacción con `ElevatedButton`, `TextButton` y `IconButton`.
3.  **Elementos de Selección:** Uso de `Checkbox`, `Switch` y `Radio` buttons.
4.  **Listas:** Implementación de una lista eficiente con `ListView.builder`.
5.  **Elementos de Información:** Muestra de `Text`, `Icon` (como placeholder de `Image`) y `CircularProgressIndicator`.

---

## Capturas de Pantalla

<table>
  <tr>
    <td align="center"><strong>1. Text Fields</strong></td>
    <td align="center"><strong>2. Botones</strong></td>
    <td align="center"><strong>3. Elementos de Selección</strong></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/13799c0f-6b8f-4451-a2fe-866775ba7406" alt="Pantalla de Text Fields" width="200"/></td>
    <td><img src="https://github.com/user-attachments/assets/a2d4e1df-5a14-483a-b3b3-afcd3d1266bf" alt="Pantalla de Botones" width="200"/></td>
    <td><img src="https://github.com/user-attachments/assets/a97de2f2-e984-4885-8ddf-44fc04550a02" alt="Pantalla de Elementos de Selección" width="200"/></td>
  </tr>
    <tr>
    <td align="center"><strong>4. Listas</strong></td>
    <td align="center"><strong>5. Info & Estado Compartido</strong></td>
  </tr>
   <tr>
    <td><img src="https://github.com/user-attachments/assets/87fabf50-246d-4bf0-b723-191017da0830" alt="Pantalla de Listas" width="200"/></td>
    <td><img src="https://github.com/user-attachments/assets/9458b4c6-af16-49a0-8cc9-61ecee32a628" alt="Pantalla de Información y Estado Compartido" width="200"/></td>
  </tr>
</table>

---

## Instrucciones de Ejecución

Para clonar, ejecutar y probar esta aplicación en tu entorno local, sigue estos sencillos pasos:

1.  **Clona el repositorio:**
    ```bash
    git clone [https://github.com/TuUsuario/TuRepositorio.git](https://github.com/TuUsuario/TuRepositorio.git)
    ```

2.  **Navega al directorio del proyecto:**
    ```bash
    cd TuRepositorio
    ```

3.  **Instala las dependencias:**
    Este comando descargará todos los paquetes necesarios para el proyecto (como `provider`).
    ```bash
    flutter pub get
    ```

4.  **Ejecuta la aplicación:**
    Asegúrate de tener un emulador en ejecución o un dispositivo físico conectado.
    ```bash
    flutter run
    ```

---

## Dificultades Encontradas y Soluciones

Durante el desarrollo de este proyecto, surgieron algunos desafíos técnicos interesantes que requirieron soluciones específicas.

### 1. Gestión de Estado entre Pantallas no Relacionadas

* **Dificultad:** Uno de los requisitos clave era que el texto introducido en la pantalla de `Text Fields` (Pantalla 1) debía mostrarse en tiempo real en la pantalla de `Elementos de Información` (Pantalla 5). Estas dos pantallas no tienen una relación directa de padre-hijo, lo que hace que pasar el estado a través de constructores sea ineficiente y complicado.

* **Solución:** Se implementó una solución de gestión de estado centralizada utilizando el paquete **`provider`**.
    1.  Se creó una clase `TextFieldState` que extiende `ChangeNotifier`. Esta clase actúa como el "almacén" de nuestro estado compartido (el texto).
    2.  La aplicación se envolvió en un `ChangeNotifierProvider` en el punto más alto del árbol de widgets (`main.dart`), haciendo que la instancia de `TextFieldState` esté disponible para toda la aplicación.
    3.  En la Pantalla 1, `Provider.of<TextFieldState>(context, listen: false)` se utilizó para actualizar el estado cada vez que el texto cambiaba.
    4.  En la Pantalla 5, se usó un widget `Consumer<TextFieldState>` para "escuchar" los cambios y reconstruir únicamente el widget de texto cuando el estado se actualizaba, garantizando una alta eficiencia.

### 2. Conflicto de Configuración de Tema en Material 3

* **Dificultad:** Al configurar el `ThemeData` de la aplicación con `useMaterial3: true`, la aplicación fallaba al iniciar con un `AssertionError`. La investigación del error reveló un conflicto entre las propiedades `primarySwatch` (el método antiguo de Material 2) y `colorSchemeSeed` (el método nuevo de Material 3).

* **Solución:** La solución fue adoptar completamente el enfoque de Material 3. Se eliminó por completo la propiedad `primarySwatch` y se dejó únicamente `colorSchemeSeed` para generar toda la paleta de colores de la aplicación. Esto no solo solucionó el error, sino que también alineó el proyecto con las prácticas de diseño modernas de Flutter, resultando en un esquema de colores más coherente y generado algorítmicamente.

---

## Hallazgos y Aprendizajes

Este proyecto sirvió como un excelente campo de pruebas para reforzar varios conceptos fundamentales de Flutter:

* **La importancia del Gestor de Estado:** Se demostró que para una comunicación de estado que no es trivial, una solución como `Provider` es indispensable para mantener el código limpio, desacoplado y escalable.

* **Eficiencia de los Widgets de Flutter:** `ListView.builder` probó ser extremadamente eficiente para renderizar listas largas, ya que solo construye los elementos que son visibles en la pantalla, conservando la memoria y el rendimiento.

* **Modularidad de la UI:** La estructura de la aplicación, dividida en widgets que representan cada pantalla, facilitó enormemente la organización del código y el manejo del estado local (`StatefulWidget`) para componentes cuya interactividad no necesitaba ser compartida globalmente (como en las pantallas de botones y selección).

* **Adaptación a las Nuevas Prácticas:** El desafío con Material 3 subrayó la importancia de mantenerse actualizado con la evolución del framework y comprender los fundamentos detrás de las nuevas APIs para evitar conflictos y aprovechar al máximo sus beneficios.
