# Gestor de Ahorro

Aplicación móvil desarrollada con Flutter para registrar ingresos y gastos de forma sencilla y consultar el saldo disponible en todo momento.

## Características

- Registro de movimientos como ingresos o gastos.
- Cálculo automático del saldo total.
- Listado visual de los movimientos registrados.
- Eliminación de movimientos por concepto.
- Persistencia local de los datos mediante `shared_preferences`.
- Interfaz basada en Material Design con tema oscuro.

## Tecnologías

- [Flutter](https://flutter.dev/)
- [Dart](https://dart.dev/)
- [`shared_preferences`](https://pub.dev/packages/shared_preferences)
- Material Design

## Requisitos

Antes de ejecutar el proyecto, instala:

- Flutter SDK compatible con Dart `^3.12.2`.
- Android Studio, Xcode o las herramientas de escritorio correspondientes a la plataforma objetivo.
- Un dispositivo físico o emulador configurado.

Verifica la instalación con:

```bash
flutter doctor
```

## Instalación

1. Clona el repositorio:

	```bash
	git clone https://github.com/DanielFMdev/Gestor.git
	cd Gestor/gestor_ahorro_app
	```

2. Instala las dependencias:

	```bash
	flutter pub get
	```

3. Comprueba los dispositivos disponibles:

	```bash
	flutter devices
	```

4. Ejecuta la aplicación:

	```bash
	flutter run
	```

## Uso

1. Pulsa el botón `+` para crear un movimiento.
2. Introduce el concepto y la cantidad.
3. Indica `true` si el movimiento es un ingreso o `false` si es un gasto.
4. Pulsa `Agregar` para actualizar la lista y el saldo.
5. Usa el botón de eliminar para borrar los movimientos asociados a un concepto.

Los movimientos se guardan localmente en el dispositivo, por lo que permanecen disponibles al volver a abrir la aplicación.

## Estructura principal

```text
lib/
├── main.dart             # Punto de entrada y configuración de la aplicación
├── gestor_screen.dart    # Pantalla principal y gestión de movimientos
└── movimientos.dart      # Modelo y serialización de los movimientos
```

## Comandos útiles

```bash
# Ejecutar las pruebas
flutter test

# Analizar el código
flutter analyze

# Formatear el código Dart
dart format lib test
```

## Estado del proyecto

Este proyecto forma parte de una práctica de aprendizaje de Flutter y Dart. La versión actual se enfoca en el registro básico de movimientos y el almacenamiento local.

## Próximas mejoras

- Validación más completa de los formularios.
- Edición de movimientos existentes.
- Filtrado por ingresos, gastos y concepto.
- Resumen por periodos y categorías.
- Mejoras de accesibilidad y experiencia de usuario.

## Licencia

La licencia del proyecto aún no ha sido definida. Si deseas reutilizar o distribuir el código, consulta primero con el propietario del repositorio.
